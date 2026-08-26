import 'package:flutter/material.dart';

import '../services/renkler.dart';

/// Proje genelinde tutarlı ikon sabitleri ve renk/boyut standartları.
/// Tüm sayfalarda aynı ikon, renk ve boyut kullanılır.
class IkonSablonu {
  IkonSablonu._();

  // ─── STANDART BOYUTLAR ───
  static const double ikonKucuk = 16;
  static const double ikonNormal = 20;
  static const double ikonOrta = 24;
  static const double ikonBuyuk = 32;
  static const double ikonHero = 40;
  static const double ikonDev = 56;

  // ─── STANDART RENKLER ───
  static Color get birincil => Renkler.vurgu;
  static Color get metin => Colors.white70;
  static Color get metinZayif => Colors.white54;
  static Color get metinCokZayif => Colors.white38;
  static Color get metinEnZayif => Colors.white24;
  static Color get kartIkon => Colors.white;
  static Color get durumBasarili => Colors.greenAccent;
  static Color get durumHata => Colors.redAccent;
  static Color get durumUyari => Colors.amberAccent;

  // ─── NAVİGASYON ───
  static const IconData geriOk = Icons.arrow_back_ios_new;
  static const IconData ileriOk = Icons.arrow_forward_ios;
  static const IconData yukariOk = Icons.keyboard_arrow_up;
  static const IconData asagiOk = Icons.keyboard_arrow_down;
  static const IconData sagOk = Icons.chevron_right;

  // ─── ANA MENÜ / BOTTOM NAV ───
  static const IconData anaSayfa = Icons.home_rounded;
  static const IconData namaz = Icons.mosque_rounded;
  static const IconData ai = Icons.auto_awesome;
  static const IconData kuran = Icons.menu_book_rounded;
  static const IconData ummet = Icons.groups_rounded;
  static const IconData profil = Icons.person_rounded;
  static const IconData ayarlar = Icons.settings_rounded;

  // ─── KUR'AN & İLİM ───
  static const IconData kitap = Icons.menu_book_rounded;
  static const IconData kitapAcik = Icons.menu_book_outlined;
  static const IconData autoStories = Icons.auto_stories_rounded;
  static const IconData hikaye = Icons.history_edu_rounded;
  static const IconData okuma = Icons.chrome_reader_mode_rounded;
  static const IconData tercume = Icons.translate_rounded;
  static const IconData arama = Icons.manage_search_rounded;

  // ─── NAMAZ & İBADET ───
  static const IconData cami = Icons.mosque_rounded;
  static const IconData camiAcik = Icons.mosque_outlined;
  static const IconData kible = Icons.explore_rounded;
  static const IconData kibleAcik = Icons.explore_outlined;
  static const IconData pusula = Icons.explore_rounded;
  static const IconData abdest = Icons.water_drop_rounded;
  static const IconData sabah = Icons.wb_twilight_rounded;
  static const IconData ogle = Icons.wb_sunny_rounded;
  static const IconData ikindi = Icons.wb_sunny_rounded;
  static const IconData aksam = Icons.wb_twilight_rounded;
  static const IconData yatsi = Icons.nights_stay_rounded;

  // ─── SES / MEDYA ───
  static const IconData oynat = Icons.play_circle_fill_rounded;
  static const IconData duraklat = Icons.pause_circle_filled_rounded;
  static const IconData durdur = Icons.stop_circle_rounded;
  static const IconData radyo = Icons.radio_rounded;
  static const IconData kulaklik = Icons.headphones_rounded;
  static const IconData ses = Icons.volume_up_rounded;
  static const IconData sesKapali = Icons.volume_off_rounded;
  static const IconData hiz = Icons.speed_rounded;
  static const IconData tekrar = Icons.replay_rounded;

  // ─── DUA & ZİKİR ───
  static const IconData dua = Icons.pan_tool_alt_rounded;
  static const IconData duaAcik = Icons.pan_tool_alt_outlined;
  static const IconData zikir = Icons.radio_button_checked;
  static const IconData tesbih = Icons.radio_button_checked;
  static const IconData kalp = Icons.favorite_rounded;
  static const IconData kalpBos = Icons.favorite_border_rounded;

  // ─── TOPLULUK ───
  static const IconData grup = Icons.groups_rounded;
  static const IconData grupAcik = Icons.groups_outlined;
  static const IconData bagis = Icons.volunteer_activism_rounded;
  static const IconData yardim = Icons.handshake_rounded;
  static const IconData etkinlik = Icons.celebration_rounded;

  // ─── ARAÇLAR ───
  static const IconData hesapla = Icons.calculate_rounded;
  static const IconData konum = Icons.location_on_rounded;
  static const IconData konumAcik = Icons.location_on_outlined;
  static const IconData bildirim = Icons.notifications_rounded;
  static const IconData bildirimAcik = Icons.notifications_outlined;
  static const IconData paylas = Icons.share_rounded;
  static const IconData paylasAcik = Icons.share_outlined;
  static const IconData kaydet = Icons.bookmark_rounded;
  static const IconData kaydetBos = Icons.bookmark_border_rounded;
  static const IconData indir = Icons.download_rounded;
  static const IconData yenile = Icons.refresh_rounded;

  // ─── DURUM ───
  static const IconData tamamlandi = Icons.check_circle_rounded;
  static const IconData tamamlandiAcik = Icons.check_circle_outline_rounded;
  static const IconData bilgi = Icons.info_outline_rounded;
  static const IconData uyari = Icons.warning_amber_rounded;
  static const IconData hata = Icons.error_outline_rounded;
  static const IconData basarili = Icons.check_rounded;

  // ─── EYLEM ───
  static const IconData ekle = Icons.add_rounded;
  static const IconData cikar = Icons.remove_rounded;
  static const IconData sil = Icons.delete_outline_rounded;
  static const IconData duzenle = Icons.edit_rounded;
  static const IconData kopyala = Icons.copy_rounded;
  static const IconData aramaKutusu = Icons.search_rounded;
  static const IconData temizle = Icons.close_rounded;
  static const IconData filtre = Icons.tune_rounded;

  // ─── DUYGU MODU ───
  static const IconData huzur = Icons.spa_rounded;
  static const IconData sukunet = Icons.spa_outlined;
  static const IconData enerji = Icons.bolt_rounded;
  static const IconData gece = Icons.nightlight_round;
  static const IconData cocuk = Icons.child_care_rounded;
  static const IconData ogrenme = Icons.school_rounded;
  static const IconData ilham = Icons.auto_awesome;

  // ─── SAYFA GERİ TUŞU (tüm sayfalarda tutarlı) ───
  static Widget geriButonu(BuildContext context, {VoidCallback? onPressed}) {
    return GestureDetector(
      onTap: onPressed ?? () => Navigator.pop(context),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Renkler.kart.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Renkler.cerceve),
        ),
        child: const Icon(geriOk, color: Colors.white70, size: 18),
      ),
    );
  }
}
