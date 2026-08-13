import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:islami_uygulama/services/canli_yayin_konfigurasyonu.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('varsayilan konfigurasyon gecerli kaynaklar icerir', () {
    final konfig = CanliYayinKonfig.varsayilan();
    expect(konfig.gecerli, isTrue);
    expect(konfig.youtubeVideoId, isNotEmpty);
    expect(konfig.hlsKaynaklar.length, greaterThanOrEqualTo(2));
    expect(konfig.radyoKanallari, isNotEmpty);
    expect(CanliYayinKonfigurasyonu.sesAkisUrl, isNotNull);
  });

  test('JSON konfigurasyonu dogru cozulur (dinamik LiveStreamUrl)', () {
    final json = {
      'surum': 3,
      'guncellenme': '2026-08-12T12:00:00Z',
      'kabeyayini': {
        'kaynakAdi': 'Yeni Resmi Yayin',
        'youtubeVideoId': 'ABC123',
        'hlsKaynaklar': [
          {'ad': 'Yedek A', 'url': 'https://ornek.com/a.m3u8'},
          {'ad': 'Yedek B', 'tip': 'hls', 'url': 'http://ornek.com/b.m3u8'},
          {'ad': 'YT', 'tip': 'youtube', 'url': 'https://youtu.be/x'},
        ],
        'sesUrl': 'http://ornek.com/ses.m3u8',
      },
      'radyoKanallari': [
        {'ad': 'R1', 'aciklama': 'a', 'url': 'https://r1/stream.mp3'},
      ],
    };

    final konfig = CanliYayinKonfig.json(json);
    expect(konfig.surum, 3);
    expect(konfig.youtubeVideoId, 'ABC123');
    expect(konfig.kaynakAdi, 'Yeni Resmi Yayin');
    expect(konfig.hlsKaynaklar.length, 3);
    expect(konfig.hlsKaynaklar[1].youtube, isFalse);
    expect(konfig.hlsKaynaklar[2].youtube, isTrue);
    expect(konfig.sesUrl, 'http://ornek.com/ses.m3u8');
    expect(konfig.radyoKanallari.single.ad, 'R1');
    expect(konfig.gecerli, isTrue);
  });

  test('bos ya da bozuk JSON konfigurasyonu gecersiz sayilir', () {
    expect(
      CanliYayinKonfig.json({
        'kabeyayini': {'youtubeVideoId': ''},
      }).gecerli,
      isFalse,
    );
  });

  test('YouTube embed adresi video ID icerir ve otomatik oynatma ayari var', () {
    CanliYayinKonfigurasyonu.aktif.value = CanliYayinKonfig(
      youtubeVideoId: 'TESTID123',
    );
    final url = CanliYayinKonfigurasyonu.youtubeEmbedUrl();
    expect(url, contains('TESTID123'));
    expect(url, contains('autoplay=1'));
  });

  test('kanal tabanli embed adresi kanal ID icerir', () {
    CanliYayinKonfigurasyonu.aktif.value = CanliYayinKonfig(
      youtubeVideoId: 'TESTID123',
      youtubeLiveChannelId: 'UCSAYDIKANALID123456789',
    );
    final url = CanliYayinKonfigurasyonu.youtubeChannelEmbedUrl();
    expect(url, isNotNull);
    expect(url, contains('live_stream'));
    expect(url, contains('UCSAYDIKANALID123456789'));
    expect(url, contains('autoplay=1'));
  });

  test('kanal ID yoksa kanal embed adresi null dondurur', () {
    CanliYayinKonfigurasyonu.aktif.value = CanliYayinKonfig(
      youtubeVideoId: 'TESTID123',
    );
    expect(CanliYayinKonfigurasyonu.youtubeChannelEmbedUrl(), isNull);
  });

  test('JSON kanal tabanli embed icin youtubeLiveChannelId cozer', () {
    final json = {
      'kabeyayini': {
        'youtubeVideoId': 'ABC123',
        'youtubeLiveChannelId': 'UCOS52AZQ',
        'hlsKaynaklar': [
          {'ad': 'Yedek A', 'url': 'https://ornek.com/a.m3u8'},
        ],
      },
    };
    final konfig = CanliYayinKonfig.json(json);
    expect(konfig.youtubeLiveChannelId, 'UCOS52AZQ');
    expect(konfig.gecerli, isTrue);
  });

  test('sesUrl yoksa ilk HLS kaynagi ses akisi olarak kullanilir', () {
    CanliYayinKonfigurasyonu.aktif.value = const CanliYayinKonfig(
      hlsKaynaklar: [
        CanliYayinKaynak(ad: 'A', url: 'https://a.m3u8'),
      ],
    );
    expect(CanliYayinKonfigurasyonu.sesAkisUrl, 'https://a.m3u8');
  });

  test('varsayilan kanal listesi tum kategorileri kapsar', () {
    final konfig = CanliYayinKonfig.varsayilan();
    final kategoriler = konfig.radyoKanallari.map((k) => k.kategori).toSet();
    expect(kategoriler, contains(RadyoKategori.tilavet));
    expect(kategoriler, contains(RadyoKategori.ilahi));
    expect(kategoriler, contains(RadyoKategori.dini));
    expect(konfig.radyoKanallari.length, greaterThanOrEqualTo(10));
  });

  test('JSON kategori alanini dogru cozer', () {
    final json = {
      'radyoKanallari': [
        {'ad': 'R1', 'url': 'https://r1/stream.mp3'},
        {
          'ad': 'R2',
          'kategori': 'ilahi',
          'url': 'https://r2/stream.mp3',
        },
        {'ad': 'R3', 'kategori': 'DİNİ', 'url': 'https://r3/stream.mp3'},
        {'ad': 'R4', 'kategori': 'yurtdisi', 'url': 'https://r4/stream.mp3'},
      ],
    };
    final konfig = CanliYayinKonfig.json(json);
    expect(konfig.radyoKanallari[0].kategori, RadyoKategori.tilavet);
    expect(konfig.radyoKanallari[1].kategori, RadyoKategori.ilahi);
    expect(konfig.radyoKanallari[2].kategori, RadyoKategori.dini);
    expect(konfig.radyoKanallari[3].kategori, RadyoKategori.yurtdisi);
  });

  test('radyo_istasyonlari JSON yapisi dogru cozulur (6 istasyon, 6 dil)', () {
    final istasyonlar = CanliYayinKonfigurasyonu.radyoIstasyonlari;
    expect(istasyonlar.length, 6);

    final diller = istasyonlar.map((s) => s.dil).toSet();
    expect(diller, {'tr', 'ar', 'ms', 'fr', 'ur', 'en'});

    for (final istasyon in istasyonlar) {
      expect(istasyon.id, isNotEmpty, reason: '${istasyon.kanalAdi} id');
      expect(istasyon.kanalAdi, isNotEmpty);
      expect(istasyon.streamUrl, isNotEmpty, reason: '${istasyon.kanalAdi} url');
      expect(istasyon.kanal.url, istasyon.streamUrl);
      expect(istasyon.kanal.kategori, RadyoKategori.yurtdisi);
    }
  });

  test('radyo istasyonu JSON ozel alan adlarini cozer (kanal_adi, stream_url)', () {
    const json = '''
    {
      "radyo_istasyonlari": [
        {
          "id": "st-test",
          "kanal_adi": "Deneme Radyosu",
          "dil": "ur",
          "kategori": "Kur'an & Tefsir",
          "stream_url": "https://ornek.com/akış.mp3",
          "logo_url": "https://ornek.com/logo.png"
        }
      ]
    }
    ''';
    final cozulen = [
      for (final o in (jsonDecode(json) as Map<String, dynamic>)['radyo_istasyonlari'] as List)
        if (o is Map<String, dynamic>) RadyoIstasyonu.json(o),
    ];
    final istasyon = cozulen.single;
    expect(istasyon.id, 'st-test');
    expect(istasyon.kanalAdi, 'Deneme Radyosu');
    expect(istasyon.dil, 'ur');
    expect(istasyon.streamUrl, 'https://ornek.com/akış.mp3');
    expect(istasyon.logoUrl, 'https://ornek.com/logo.png');
  });

  test('uzak JSON radyoIstasyonlari girdisini gomuluyen uzerine alir', () {
    final json = {
      'radyo_istasyonlari': [
        {
          'id': 'st-uzak',
          'kanal_adi': 'Uzak Radyo',
          'dil': 'en',
          'kategori': 'Genel',
          'stream_url': 'https://uzak.com/ak.mp3',
        },
      ],
    };
    final konfig = CanliYayinKonfig.json(json);
    expect(konfig.radyoIstasyonlari.single.id, 'st-uzak');
    expect(konfig.radyoIstasyonlari.single.kanalAdi, 'Uzak Radyo');
  });

  test('dil etiketleri tanimlanan kodlar icin Turkce dondurur', () {
    expect(radyoDilEtiketi('tr'), 'Türkçe');
    expect(radyoDilEtiketi('ar'), 'Arapça');
    expect(radyoDilEtiketi('ms'), 'Malayca');
    expect(radyoDilEtiketi('fr'), 'Fransızca');
    expect(radyoDilEtiketi('ur'), 'Urduca');
    expect(radyoDilEtiketi('en'), 'İngilizce');
  });
}