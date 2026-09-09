// ===========================================================================
// ACİL DURUM SÖZLÜĞÜ - SAHADA GEREKLİ 30 TEMEL CÜMLE
// Türkçe + Arapça + okunuş. Sesli okuma için "Dinle" butonu kullanılır
// (cihazın metin okuma/TTS motoruyla, internet gerekmez).
// ===========================================================================

import 'hac_umre_verileri.dart';

const List<AcilCumle> acilCumleler = [
  // ---------------- YARDIM & İLETİŞİM ----------------
  AcilCumle(
    id: 'yardim_genel',
    kategori: 'Yardım & İletişim',
    turkce: 'Yardım eder misiniz?',
    arapca: 'هَلْ تَسْتَطِيعُ مُسَاعَدَتِي؟',
    okunus: 'Hel testetî\'u musâadetî?',
  ),
  AcilCumle(
    id: 'yardim_telefon',
    kategori: 'Yardım & İletişim',
    turkce: 'Telefonumu çalabilir miyim?',
    arapca: 'هَلْ يُمْكِنُنِي اسْتِعْمَالُ هَاتِفِكَ؟',
    okunus: 'Hel yemkinunî isti\'mâlü hâtifike?',
  ),
  AcilCumle(
    id: 'yardim_polis',
    kategori: 'Yardım & İletişim',
    turkce: 'Polisi arayabilir misiniz?',
    arapca: 'هَلْ تَسْتَطِيعُ الاتِّصَالَ بِالشُّرْطَةِ؟',
    okunus: 'Hel testetî\'u\'l-ittisâle biş-şurtah?',
  ),
  AcilCumle(
    id: 'yardim_ambulans',
    kategori: 'Yardım & İletişim',
    turkce: 'Ambulans çağırın lütfen!',
    arapca: 'اُدْعُ الإِسْعَافَ مِنْ فَضْلِكَ!',
    okunus: 'Udu\'l-İs\'âfe min fadlike!',
  ),
  AcilCumle(
    id: 'yardim_internet',
    kategori: 'Yardım & İletişim',
    turkce: 'İnternet bağlantısı nerede var?',
    arapca: 'أَيْنَ وُجُودُ الانْتِرْنِتِ؟',
    okunus: 'Eyne vücûdü\'l-internet?',
  ),
  // ---------------- ULAŞIM ----------------
  AcilCumle(
    id: 'ulasim_otel',
    kategori: 'Ulaşım',
    turkce: 'Beni otelime götürür müsünüz?',
    arapca: 'هَلْ تَسْتَطِيعُ أَنْ تُوْصِلَنِي إِلَى فُنْدُقِي؟',
    okunus: 'Hel testetî\'u en tûsilânî ilâ fundukî?',
    not: 'Otel kartınızı şoföre gösterin.',
  ),
  AcilCumle(
    id: 'ulasim_taksi',
    kategori: 'Ulaşım',
    turkce: 'Bu adrese taksi ile gidebilir miyim?',
    arapca: 'هَلْ أَسْتَطِيعُ الذَّهَابَ بِالتَّاكْسِي إِلَى هَذَا الْعُنْوَانِ؟',
    okunus: 'Hel estetî\'u\'z-zehebe bit-tâksî ilâ hâzâ\'l-unvân?',
  ),
  AcilCumle(
    id: 'ulasim_haram',
    kategori: 'Ulaşım',
    turkce: 'Mescid-i Haram\'a nasıl gidebilirim?',
    arapca: 'كَيْفَ أَذْهَبُ إِلَى الْمَسْجِدِ الْحَرَامِ؟',
    okunus: 'Keyfe ezhebü ilel-Mescidi\'l-Harâm?',
  ),
  AcilCumle(
    id: 'ulasim_nebevi',
    kategori: 'Ulaşım',
    turkce: 'Mescid-i Nebevî\'ye nasıl giderim?',
    arapca: 'كَيْفَ أَذْهَبُ إِلَى الْمَسْجِدِ النَّبَوِيِّ؟',
    okunus: 'Keyfe ezhebü ilel-Mescidi\'n-Nebevî?',
  ),
  AcilCumle(
    id: 'ulasim_uzaklik',
    kategori: 'Ulaşım',
    turkce: 'Burası ne kadar uzak?',
    arapca: 'كَمْ تَبْلُغُ الْمَسَافَةُ إِلَى هُنَاكَ؟',
    okunus: 'Kem teblüğü\'l-mesâfetü ilâ hünâk?',
  ),
  // ---------------- SAĞLIK ----------------
  AcilCumle(
    id: 'saglik_doktor',
    kategori: 'Sağlık',
    turkce: 'Bir doktora ihtiyacım var.',
    arapca: 'أَحْتَاجُ إِلَى طَبِيبٍ.',
    okunus: 'Ahtâcü ilâ tabîb.',
  ),
  AcilCumle(
    id: 'saglik_hasta',
    kategori: 'Sağlık',
    turkce: 'Kendimi iyi hissetmiyorum.',
    arapca: 'أَشْعُرُ بِتَعَبٍ.',
    okunus: 'Eş\'uru bi-ta\'ab.',
  ),
  AcilCumle(
    id: 'saglik_bas',
    kategori: 'Sağlık',
    turkce: 'Başım çok ağrıyor.',
    arapca: 'رَأْسِي يُؤْلِمُنِي كَثِيرًا.',
    okunus: 'Re\'sî yü\'limünî kesîrâ.',
  ),
  AcilCumle(
    id: 'saglik_ilac',
    kategori: 'Sağlık',
    turkce: 'Bu ilacı nereden alabilirim?',
    arapca: 'مِنْ أَيْنَ أَسْتَطِيعُ شِرَاءَ هَذَا الدَّوَاءِ؟',
    okunus: 'Min eyne estetî\'u şirâe hâzâ\'d-devâ\'?',
  ),
  AcilCumle(
    id: 'saglik_tksandalyem',
    kategori: 'Sağlık',
    turkce: 'Tekerlekli sandalyeye ihtiyacım var.',
    arapca: 'أَحْتَاجُ إِلَى كُرْسِيٍّ مُتَحَرِّكٍ.',
    okunus: 'Ahtâcü ilâ kürsiyyin müteharrik.',
  ),
  AcilCumle(
    id: 'saglik_hastane',
    kategori: 'Sağlık',
    turkce: 'Hastane nerede?',
    arapca: 'أَيْنَ الْمُسْتَشْفَى؟',
    okunus: 'Eyne\'l-müsteşfâ?',
  ),
  // ---------------- KAYIP & GÜVENLİK ----------------
  AcilCumle(
    id: 'kayip_es',
    kategori: 'Kayıp & Güvenlik',
    turkce: 'Eşimi / çocuğumu kaybettim.',
    arapca: 'فَقَدْتُ زَوْجَتِي / وَلَدِي.',
    okunus: 'Fakadtü zevcetî / veledî.',
  ),
  AcilCumle(
    id: 'kayip_esya',
    kategori: 'Kayıp & Güvenlik',
    turkce: 'Çantamı kaybettim.',
    arapca: 'فَقَدْتُ حَقِيبَتِي.',
    okunus: 'Fakadtü hakîbetî.',
  ),
  AcilCumle(
    id: 'kayip_danisma',
    kategori: 'Kayıp & Güvenlik',
    turkce: 'Danışma / kayıp eşya bürosu nerede?',
    arapca: 'أَيْنَ مَكْتَبُ الْمَعْلُومَاتِ وَالْأَشْيَاءِ الْمَفْقُودَةِ؟',
    okunus: 'Eyne mektebü\'l-ma\'lûmâti vel-eşyâi\'l-mefkûdeh?',
  ),
  AcilCumle(
    id: 'kayip_pasaport',
    kategori: 'Kayıp & Güvenlik',
    turkce: 'Pasaportumu kaybettim. Ne yapmalıyım?',
    arapca: 'فَقَدْتُ جَوَازَ السَّفَرِ. مَاذَا أَفْعَلُ؟',
    okunus: 'Fakadtü cevâze\'s-sefer. Mâzâ ef\'al?',
    not: 'Türk Konsolosluğu\'na başvurun: Cidde/Mekke Konsolosluğu.',
  ),
  AcilCumle(
    id: 'kayip_toplandi',
    kategori: 'Kayıp & Güvenlik',
    turkce: 'Grup arkadaşlarımdan ayrıldım.',
    arapca: 'اِنْفَصَلْتُ عَنْ مَجْمُوعَتِي.',
    okunus: 'İnfasaltü an mecmûatî.',
  ),
  // ---------------- TEMEL İHTİYAÇLAR ----------------
  AcilCumle(
    id: 'ihtiyac_su',
    kategori: 'Temel İhtiyaçlar',
    turkce: 'Su nerede?',
    arapca: 'أَيْنَ الْمَاءُ؟',
    okunus: 'Eyne\'l-mâ\'?',
  ),
  AcilCumle(
    id: 'ihtiyac_tuvalet',
    kategori: 'Temel İhtiyaçlar',
    turkce: 'Tuvalet nerede?',
    arapca: 'أَيْنَ الحَمَّامُ؟',
    okunus: 'Eyne\'l-hammâm?',
  ),
  AcilCumle(
    id: 'ihtiyac_yemek',
    kategori: 'Temel İhtiyaçlar',
    turkce: 'Yakınlarda nerede yemek yiyebilirim?',
    arapca: 'أَيْنَ أَسْتَطِيعُ أَنْ آكُلَ هُنَا؟',
    okunus: 'Eyne estetî\'u en âküle hünâ?',
  ),
  AcilCumle(
    id: 'ihtiyac_para',
    kategori: 'Temel İhtiyaçlar',
    turkce: 'Döviz bürosu nerede?',
    arapca: 'أَيْنَ مَكَانُ تَصْرِيفِ الْعُمْلَةِ؟',
    okunus: 'Eyne mekânü tasrîfi\'l-ümleh?',
  ),
  AcilCumle(
    id: 'ihtiyac_saat',
    kategori: 'Temel İhtiyaçlar',
    turkce: 'Şu an saat kaç?',
    arapca: 'كَمِ السَّاعَةُ الآنَ؟',
    okunus: 'Kemi\'s-sâatü\'l-ân?',
  ),
  // ---------------- NAZİK RİCALAR ----------------
  AcilCumle(
    id: 'rica_yavas',
    kategori: 'Nazik Ricalar',
    turkce: 'Yavaşça konuşur musunuz lütfen?',
    arapca: 'هَلْ تَسْتَطِيعُ أَنْ تَتَكَلَّمَ بِبُطْءٍ مِنْ فَضْلِكَ؟',
    okunus: 'Hel testetî\'u en tetekelleme bi-but\'in min fadlike?',
  ),
  AcilCumle(
    id: 'rica_tekrar',
    kategori: 'Nazik Ricalar',
    turkce: 'Lütfen tekrar eder misiniz?',
    arapca: 'أَعِدْ مِنْ فَضْلِكَ.',
    okunus: 'E\'id min fadlike.',
  ),
  AcilCumle(
    id: 'rica_yaz',
    kategori: 'Nazik Ricalar',
    turkce: 'Bunu yazar mısınız?',
    arapca: 'هَلْ تَسْتَطِيعُ كِتَابَةَ ذَلِكَ؟',
    okunus: 'Hel testetî\'u kitâbete zâlik?',
  ),
  AcilCumle(
    id: 'rica_turkce',
    kategori: 'Nazik Ricalar',
    turkce: 'Türkçe bilen biri var mı?',
    arapca: 'هَلْ يُوجَدُ شَخْصٌ يَعْرِفُ التُّرْكِيَّةَ؟',
    okunus: 'Hel yûcedü şahsun ya\'rifü\'t-Türkiyyeh?',
  ),
  AcilCumle(
    id: 'rica_foto',
    kategori: 'Nazik Ricalar',
    turkce: 'Bizi fotoğraflar mısınız?',
    arapca: 'هَلْ تَسْتَطِيعُ أَنْ تُصَوِّرَنَا؟',
    okunus: 'Hel testetî\'u en tüsevverenâ?',
  ),
  AcilCumle(
    id: 'rica_tesekkur',
    kategori: 'Nazik Ricalar',
    turkce: 'Çok teşekkür ederim.',
    arapca: 'شُكْرًا جَزِيلاً.',
    okunus: 'Şükran cezîlâ.',
  ),
];

/// Sözlük kategorileri (görünüm sırasıyla).
const List<String> acilKategoriler = [
  'Yardım & İletişim',
  'Ulaşım',
  'Sağlık',
  'Kayıp & Güvenlik',
  'Temel İhtiyaçlar',
  'Nazik Ricalar',
];

/// Sözlük notu.
const String acilSozlukNotu =
    'Sesli okuma, cihazınızın metin okuma (TTS) motoruyla yapılır ve internet '
    'gerektirmez. İnternet olduğunda Arapça ses kalitesi artar.';
