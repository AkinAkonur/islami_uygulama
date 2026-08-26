import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../l10n/app_localizations.dart';
import '../services/renkler.dart';
import '../widgets/kart_sekilleri.dart';

/// Profil verileri (fotoğraf + isim) için kalıcı depo.
class ProfilStore {
  ProfilStore._();

  static const _keyResim = 'profil_resmi';
  static const _keyIsim = 'profil_isim';

  static Future<SharedPreferences> get _p => SharedPreferences.getInstance();

  static Future<Uint8List?> resimOku() async {
    final p = await _p;
    final raw = p.getString(_keyResim);
    if (raw == null || raw.isEmpty) return null;
    try {
      return base64Decode(raw);
    } catch (_) {
      return null;
    }
  }

  static Future<void> resimKaydet(Uint8List bytes) async {
    final p = await _p;
    await p.setString(_keyResim, base64Encode(bytes));
  }

  static Future<void> resimSil() async {
    final p = await _p;
    await p.remove(_keyResim);
  }

  static Future<String> isimOku() async {
    final p = await _p;
    return p.getString(_keyIsim) ?? '';
  }

  static Future<void> isimKaydet(String isim) async {
    final p = await _p;
    await p.setString(_keyIsim, isim);
  }

  static int hicriYil() => 1448 + (DateTime.now().year - 2026);
}

class ProfilSayfasi extends StatefulWidget {
  const ProfilSayfasi({super.key});

  @override
  State<ProfilSayfasi> createState() => _ProfilSayfasiState();
}

class _ProfilSayfasiState extends State<ProfilSayfasi> {
  final TextEditingController _isimCtrl = TextEditingController();
  Uint8List? _resim;

  @override
  void initState() {
    super.initState();
    _yukle();
  }

  Future<void> _yukle() async {
    final resim = await ProfilStore.resimOku();
    final isim = await ProfilStore.isimOku();
    if (mounted) {
      setState(() {
        _resim = resim;
        _isimCtrl.text = isim;
      });
    }
  }

  Future<void> _fotografSec() async {
    final secim = await showModalBottomSheet<ImageSource>(
      context: context,
      backgroundColor: Renkler.kart,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                'Profil Fotoğrafı',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: const UcdIkon(ikon: Icons.photo_library_rounded,
                  renk: Colors.white70),
              title: const Text(
                'Galeriden Seç',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () => Navigator.pop(ctx, ImageSource.gallery),
            ),
            ListTile(
              leading: const UcdIkon(ikon: Icons.camera_alt_rounded,
                  renk: Colors.white70),
              title: const Text(
                'Kamera ile Çek',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () => Navigator.pop(ctx, ImageSource.camera),
            ),
          ],
        ),
      ),
    );
    if (secim == null || !mounted) return;
    final xfile = await ImagePicker().pickImage(
      source: secim,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 85,
    );
    if (xfile == null || !mounted) return;
    final bytes = await xfile.readAsBytes();
    await ProfilStore.resimKaydet(bytes);
    if (mounted) setState(() => _resim = bytes);
  }

  Future<void> _fotografSil() async {
    await ProfilStore.resimSil();
    if (mounted) setState(() => _resim = null);
  }

  Future<void> _isimKaydet() async {
    await ProfilStore.isimKaydet(_isimCtrl.text.trim());
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).t('pf.nameSaved'))),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final bugun = DateTime.now();
    const aylar = [
      'Ocak', 'Şubat', 'Mart', 'Nisan', 'Mayıs', 'Haziran',
      'Temmuz', 'Ağustos', 'Eylül', 'Ekim', 'Kasım', 'Aralık',
    ];
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Renkler.bannerUst, Renkler.bannerAlt],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _baslikSatiri(context),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    _profilKarti(l, bugun, aylar),
                    const SizedBox(height: 16),
                    _isimKarti(l),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _baslikSatiri(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const UcdIkon(ikon: Icons.arrow_back_ios_new, renk: Colors.white),
          ),
          const SizedBox(width: 8),
          const Text(
            'Profilim',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          const UcdIkon(ikon: Icons.person_rounded, renk: Colors.white54),
        ],
      ),
    );
  }

  Widget _profilKarti(AppLocalizations l, DateTime bugun, List<String> aylar) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Renkler.kart.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: _fotografSec,
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 48,
                  backgroundColor: Renkler.cerceve,
                  backgroundImage:
                      _resim != null ? MemoryImage(_resim!) : null,
                  child: _resim == null
                      ? const UcdIkon(ikon: Icons.person_rounded,
                          renk: Colors.white70, boyut: 44)
                      : null,
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Renkler.vurgu,
                      shape: BoxShape.circle,
                    ),
                    child: const UcdIkon(ikon: Icons.camera_alt_rounded,
                        renk: Colors.white, boyut: 16),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            _isimCtrl.text.trim().isEmpty ? 'Misafir Kardeş' : _isimCtrl.text.trim(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${bugun.day} ${aylar[bugun.month - 1]} ${bugun.year} · Hicri ${ProfilStore.hicriYil()}',
            style: TextStyle(color: Colors.white54, fontSize: 12),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton.icon(
                onPressed: _fotografSec,
                style: OutlinedButton.styleFrom(
                  foregroundColor: Renkler.vurgu,
                  side: BorderSide(color: Renkler.vurgu.withValues(alpha: 0.6)),
                ),
                icon: const UcdIkon(ikon: Icons.photo_library_rounded, renk: Colors.white70, boyut: 16),
                label: Text(_resim == null ? 'Fotoğraf Ekle' : 'Değiştir'),
              ),
              const SizedBox(width: 10),
              if (_resim != null)
                TextButton.icon(
                  onPressed: _fotografSil,
                  style: TextButton.styleFrom(foregroundColor: Colors.redAccent),
                  icon: const UcdIkon(ikon: Icons.delete_outline, renk: Colors.redAccent, boyut: 16),
                  label: Text(l.t('c.remove')),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _isimKarti(AppLocalizations l) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Renkler.kart.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              UcdIkon(ikon: Icons.edit_rounded, renk: Renkler.vurgu, boyut: 20),
              SizedBox(width: 8),
              Text(
                'İsmin',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _isimCtrl,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: l.t('pf.nameHint'),
              hintStyle: const TextStyle(color: Colors.white38),
              filled: true,
              fillColor: Renkler.seciliYuzey,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: FilledButton(
              onPressed: _isimKaydet,
              style: FilledButton.styleFrom(backgroundColor: Renkler.vurgu),
              child: const Text('Kaydet'),
            ),
          ),
        ],
      ),
    );
  }
}
