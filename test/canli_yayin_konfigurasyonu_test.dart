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

  test('sesUrl yoksa ilk HLS kaynagi ses akisi olarak kullanilir', () {
    CanliYayinKonfigurasyonu.aktif.value = const CanliYayinKonfig(
      hlsKaynaklar: [
        CanliYayinKaynak(ad: 'A', url: 'https://a.m3u8'),
      ],
    );
    expect(CanliYayinKonfigurasyonu.sesAkisUrl, 'https://a.m3u8');
  });
}