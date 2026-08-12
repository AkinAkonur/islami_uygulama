// lib/pages/kissalar/kissa_detay_page.dart
// Kıssa / siyer / peygamber kaydı için zengin detay ekranı: kimlik kartı,
// metin, ayet ve hadisler, kronoloji, coğrafya, hikmetler, akademik notlar,
// quiz, favorileme ve renkli kişisel notlar (KissaStore).

import 'package:flutter/material.dart';

import '../../services/renkler.dart';
import '../kissalar/kissa_store.dart';
import '../kissalar/kissalar_verileri.dart';

/// Katalog ve kaynakça bilgisi (içeriğin güvenilirlik kaynakları).
const List<String> _kaynakca = [
  'Diyanet İşleri Başkanlığı - Kur\'an Yolu Tefsiri',
  'İbn Kesîr - Peygamberler ve Melikler Tarihi (el-Bidâye ve\'n-Nihâye)',
  'Taberî - Târîhü\'l-Ümem ve\'l-Mülûk (Tarih-i Taberî)',
  'M. Âsım Köksal - İslam Tarihi',
  'İbn Hişâm - Sîretü\'n-Nebî',
  'Kadı Iyaz - eş-Şifâ (Şifa-i Şerif)',
  'İmam Nevevî - Riyâzü\'s-Sâlihîn',
];

class KissaDetayPage extends StatefulWidget {
  final KissaKaydi kissa;

  const KissaDetayPage({super.key, required this.kissa});

  @override
  State<KissaDetayPage> createState() => _KissaDetayPageState();
}

class _KissaDetayPageState extends State<KissaDetayPage> {
  final Map<int, int> _secimler = {};

  KissaKaydi get kissa => widget.kissa;

  void _quizCevap(int soruIndex, int secenekIndex) {
    if (_secimler.containsKey(soruIndex)) return;
    setState(() => _secimler[soruIndex] = secenekIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        backgroundColor: Renkler.yuzey,
        elevation: 0,
        title: Text(
          kissa.baslik,
          style: const TextStyle(color: Colors.white, fontSize: 17),
        ),
        actions: [
          ValueListenableBuilder<Set<String>>(
            valueListenable: KissaStore.favoriler,
            builder: (context, favoriler, _) {
              final dolu = favoriler.contains(kissa.id);
              return IconButton(
                tooltip: dolu ? 'Favorilerden çıkar' : 'Favorilere ekle',
                icon: Icon(
                  dolu ? Icons.favorite : Icons.favorite_border,
                  color: dolu ? Colors.redAccent : Colors.white70,
                ),
                onPressed: () => KissaStore.favoriDegistir(kissa.id),
              );
            },
          ),
          IconButton(
            tooltip: 'Notlar',
            icon: const Icon(Icons.sticky_note_2_outlined, color: Colors.white70),
            onPressed: _notlarDialoguGoster,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _baslikKarti(),
          if (kissa.kimlikKarti.isNotEmpty) ...[
            const SizedBox(height: 14),
            _kimlikKarti(),
          ],
          if (kissa.sesUrl != null) ...[
            const SizedBox(height: 14),
            _sesliAnlatimKarti(),
          ],
          const SizedBox(height: 22),
          if (kissa.metin.isNotEmpty) ...[
            _bolumBasligi('📖 Hayatı ve Anlatımı'),
            const SizedBox(height: 6),
            for (final paragraf in kissa.metin) _paragraf(paragraf),
          ],
          if (kissa.ayetler.isNotEmpty) ...[
            const SizedBox(height: 22),
            _bolumBasligi('📜 İlgili Kur\'an Ayetleri'),
            const SizedBox(height: 8),
            for (final ayet in kissa.ayetler) _ayetKarti(ayet),
          ],
          if (kissa.hadisler.isNotEmpty) ...[
            const SizedBox(height: 22),
            _bolumBasligi('🤲 Hadis-i Şerifler'),
            const SizedBox(height: 8),
            for (final hadis in kissa.hadisler) _hadisKarti(hadis),
          ],
          if (kissa.kronoloji.isNotEmpty) ...[
            const SizedBox(height: 22),
            _bolumBasligi('🗓️ Kronoloji'),
            const SizedBox(height: 8),
            _kronolojiListesi(),
          ],
          if (kissa.cografya.isNotEmpty) ...[
            const SizedBox(height: 22),
            _bolumBasligi('🗺️ Mekanlar ve Coğrafya'),
            const SizedBox(height: 8),
            for (final nokta in kissa.cografya) _cografyaKarti(nokta),
          ],
          if (kissa.hikmetler.isNotEmpty) ...[
            const SizedBox(height: 22),
            _bolumBasligi('💡 Hikmet ve Dersler'),
            const SizedBox(height: 8),
            for (final hikmet in kissa.hikmetler) _hikmetKarti(hikmet),
          ],
          if (kissa.akademikNotlar.isNotEmpty) ...[
            const SizedBox(height: 22),
            _bolumBasligi('🎓 Akademik / Detay Notlar'),
            const SizedBox(height: 8),
            _akademikNotlar(),
          ],
          if (kissa.quiz.isNotEmpty) ...[
            const SizedBox(height: 22),
            _bolumBasligi('❓ Ne Kadar Öğrendin?'),
            const SizedBox(height: 8),
            for (var i = 0; i < kissa.quiz.length; i++) _quizKarti(i),
          ],
          const SizedBox(height: 26),
          _kaynakcaKarti(),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  // ----------------------------- BÖLÜMLER -----------------------------

  Widget _baslikKarti() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Renkler.kart,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Renkler.cerceve),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(kissa.emoji, style: const TextStyle(fontSize: 40)),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  kissa.baslik,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          if (kissa.donem.isNotEmpty) ...[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Renkler.seciliYuzey,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                kissa.donem,
                style: TextStyle(color: Renkler.vurgu, fontSize: 12),
              ),
            ),
          ],
          const SizedBox(height: 12),
          Text(
            kissa.ozet,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
              height: 1.5,
            ),
          ),
          if (kissa.temalar.isNotEmpty) ...[
            const SizedBox(height: 12),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                for (final tema in kissa.temalar)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Renkler.zemin,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Renkler.vurgu, width: 0.8),
                    ),
                    child: Text(
                      tema,
                      style: TextStyle(
                        color: Renkler.vurgu,
                        fontSize: 11,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _kimlikKarti() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Renkler.kart,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Renkler.cerceve),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '🪪 Kimlik Kartı',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          for (final alan in kissa.kimlikKarti)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 130,
                    child: Text(
                      '${alan.alanAdi}:',
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      alan.deger,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _sesliAnlatimKarti() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Renkler.seciliYuzey,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Renkler.vurgu),
      ),
      child: Row(
        children: [
          Icon(Icons.headphones, color: Renkler.vurgu, size: 28),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Sesli anlatım mevcut. İnternetsiz dinleyebilirsiniz: dokunarak oynatın.',
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ),
          Icon(Icons.play_circle_fill, color: Renkler.vurgu, size: 34),
        ],
      ),
    );
  }

  Widget _bolumBasligi(String baslik) {
    return Text(
      baslik,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 17,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _paragraf(String metin) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        metin,
        style: const TextStyle(color: Colors.white70, fontSize: 14, height: 1.7),
      ),
    );
  }

  Widget _ayetKarti(AyetKaydi ayet) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Renkler.kart,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Renkler.vurgu, width: 0.7),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ayet.arapca,
            textAlign: TextAlign.right,
            style: TextStyle(
              color: Renkler.vurgu,
              fontSize: 18,
              height: 1.9,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: 40,
            height: 2,
            color: Renkler.cerceve,
          ),
          const SizedBox(height: 10),
          Text(
            ayet.meal,
            style: const TextStyle(color: Colors.white70, fontSize: 13, height: 1.6),
          ),
          const SizedBox(height: 8),
          Text(
            ayet.kaynak,
            style: const TextStyle(color: Colors.amberAccent, fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _hadisKarti(HadisKaydi hadis) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Renkler.kart,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Renkler.cerceve),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.format_quote, color: Colors.white38, size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  hadis.metin,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    height: 1.6,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            hadis.kaynak,
            style: const TextStyle(color: Colors.amberAccent, fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _kronolojiListesi() {
    return Column(
      children: [
        for (var i = 0; i < kissa.kronoloji.length; i++)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: Renkler.seciliYuzey,
                      shape: BoxShape.circle,
                      border: Border.all(color: Renkler.vurgu, width: 2),
                    ),
                  ),
                  if (i != kissa.kronoloji.length - 1)
                    Container(width: 2, height: 46, color: Renkler.cerceve),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        kissa.kronoloji[i].tarih,
                        style: TextStyle(
                          color: Renkler.vurgu,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        kissa.kronoloji[i].olay,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }

  Widget _cografyaKarti(CografyaNokta nokta) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Renkler.kart,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Renkler.cerceve),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.place, color: Renkler.vurgu, size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nokta.yer,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                if (nokta.enlem != null && nokta.boylam != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(
                      '${nokta.enlem!.toStringAsFixed(2)}, ${nokta.boylam!.toStringAsFixed(2)}',
                      style: const TextStyle(color: Colors.white38, fontSize: 10),
                    ),
                  ),
                const SizedBox(height: 4),
                Text(
                  nokta.aciklama,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _hikmetKarti(String hikmet) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Renkler.kart,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.lightbulb_outline, color: Renkler.vurgu, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              hikmet,
              style: const TextStyle(color: Colors.white70, fontSize: 13, height: 1.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _akademikNotlar() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Renkler.kart,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Renkler.cerceve),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final not in kissa.akademikNotlar)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('•  ', style: TextStyle(color: Colors.white38)),
                  Expanded(
                    child: Text(
                      not,
                      style: const TextStyle(
                        color: Colors.white60,
                        fontSize: 12,
                        height: 1.6,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _quizKarti(int index) {
    final soru = kissa.quiz[index];
    final cevaplandi = _secimler.containsKey(index);
    final secilen = _secimler[index];
    final dogru = soru.dogruIndex;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Renkler.kart,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Renkler.cerceve),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${index + 1}. ${soru.soru}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 10),
          for (var s = 0; s < soru.secenekler.length; s++)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () => _quizCevap(index, s),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: cevaplandi && s == secilen && s != dogru
                        ? const Color(0xFF7B3B3B)
                        : Renkler.zemin,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: cevaplandi && s == dogru
                          ? const Color(0xFF66BB6A)
                          : cevaplandi && s == secilen
                              ? const Color(0xFFE57373)
                              : Renkler.cerceve,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        cevaplandi && s == dogru
                            ? Icons.check_circle
                            : cevaplandi && s == secilen
                                ? Icons.cancel
                                : Icons.radio_button_unchecked,
                        size: 18,
                        color: cevaplandi && s == dogru
                            ? const Color(0xFF66BB6A)
                            : Colors.white38,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          soru.secenekler[s],
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          if (cevaplandi)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                secilen == dogru
                    ? '✅ Doğru!'
                    : '❌ Yanlış. Doğru cevap: ${soru.secenekler[dogru]}',
                style: TextStyle(
                  color:
                      secilen == dogru ? const Color(0xFF66BB6A) : const Color(0xFFE57373),
                  fontSize: 12.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _kaynakcaKarti() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Renkler.seciliYuzey.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Renkler.cerceve),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '📚 Kaynakça',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Bu içerik; aşağıdaki kaynak eserlerden derlenmiş olup genel okuyucu ve '
            'araştırmacı için güvenilir bir zemin oluşturmayı hedefler:',
            style: const TextStyle(color: Colors.white54, fontSize: 11.5, height: 1.5),
          ),
          const SizedBox(height: 8),
          for (final kaynak in _kaynakca)
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('•  ', style: TextStyle(color: Colors.white38)),
                  Expanded(
                    child: Text(
                      kaynak,
                      style: const TextStyle(
                        color: Colors.white60,
                        fontSize: 11.5,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  // --------------------------- NOTLAR DİYALOĞU ---------------------------

  Future<void> _notlarDialoguGoster() async {
    final controller = TextEditingController();
    var seciliRenk = 0;

    await showModalBottomSheet(
      context: context,
      backgroundColor: Renkler.yuzey,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: MediaQuery.of(context).viewInsets.bottom + 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '📝 Kişisel Notlarım',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ValueListenableBuilder<Map<String, List<KissaNotu>>>(
                    valueListenable: KissaStore.notlar,
                    builder: (context, notlar, _) {
                      final liste = notlar[kissa.id] ?? const <KissaNotu>[];
                      if (liste.isEmpty) {
                        return const Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                            'Henüz not eklenmemiş.',
                            style: TextStyle(color: Colors.white54, fontSize: 12),
                          ),
                        );
                      }
                      return Column(
                        children: [
                          for (var i = 0; i < liste.length; i++)
                            Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: kissaHex(
                                  KissaStore.notRenkHexleri[liste[i].renkIndex],
                                ).withValues(alpha: 0.18),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: kissaHex(
                                    KissaStore.notRenkHexleri[liste[i].renkIndex],
                                  ).withValues(alpha: 0.5),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      liste[i].metin,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete_outline,
                                      size: 18,
                                      color: Colors.white38,
                                    ),
                                    onPressed: () =>
                                        KissaStore.notSil(kissa.id, i),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                  Row(
                    children: [
                      for (var i = 0; i < 5; i++)
                        GestureDetector(
                          onTap: () => setSheetState(() => seciliRenk = i),
                          child: Container(
                            width: 26,
                            height: 26,
                            margin: const EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              color: kissaHex(KissaStore.notRenkHexleri[i]),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: seciliRenk == i
                                    ? Colors.white
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: controller,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Bu kıssaya dair notunuz...',
                      hintStyle: const TextStyle(color: Colors.white38, fontSize: 13),
                      filled: true,
                      fillColor: Renkler.kart,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: Renkler.vurgu,
                        foregroundColor: Colors.black87,
                      ),
                      onPressed: () {
                        final metin = controller.text.trim();
                        if (metin.isEmpty) return;
                        KissaStore.notEkle(kissa.id, metin, seciliRenk);
                        controller.clear();
                      },
                      child: const Text('Notu Ekle'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}