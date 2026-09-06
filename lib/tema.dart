// ===========================================================================
// TEMA - Uygulama geneli "3D Zümrüt & Altın" dokunsal teması
// ---------------------------------------------------------------------------
// Tek merkezden tüm sayfalara premium mücevher görünümü verir:
//  • Altın/yeşil çekirdek palet (vurgu altın, zemin zümrüt koyu)
//  • Butonlar: altın dolu, siyah yazı, ince altın kenar, kısa gölge
//  • Kaydırıcılar: altın parlayan topuz + zümrüt→altın gradyan iz
//  • Kartlar/diyaloglar: zümrüt dolgu + ince altın kenar + yumuşak ışıma
//  • Toggle'lar, çubuklar, sekmeler, girişler: hep aynı altın/zümrüt dili
//
// Her sayfanın kendi `Renkler` paleti ve UcdKart gibi şablonları bu tema ile
// birleşir; sayfaların içerik şablonu bozulmaz, yalnızca görünümü değişir.
// ===========================================================================

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'services/renkler.dart';
import 'widgets/altin_tactile.dart';

class Tema {
  Tema._();

  // Merkez dokular: altın + zümrüt
  static const _altin = Color(0xFFEABA2F);
  static const _altinParlak = Color(0xFFF9E3A8);
  static const _altinKoyu = Color(0xFF9A6B00);
  static const _zumrut = Color(0xFF10B981);
  static const _zemin = Color(0xFF0B150E);
  static const _kart = Color(0xFF12241A);
  static const _kartAcik = Color(0xFF1A3323);
  static const _border = Color(0xFF6A5A1F);

  /// Renk yelpazesinin açık ve koyu modda kullanılan ortak temeli.
  static ColorScheme _renkYelpazi({required Brightness parlaklik}) {
    final koyu = parlaklik == Brightness.dark;
    final sekonderIsik = koyu ? const Color(0xFF34D399) : const Color(0xFF059669);
    return ColorScheme(
      brightness: parlaklik,
      primary: _altin,
      onPrimary: Colors.black,
      secondary: sekonderIsik,
      onSecondary: Colors.black,
      error: koyu ? const Color(0xFFE57373) : const Color(0xFFD32F2F),
      onError: Colors.black,
      surface: koyu ? _kart : const Color(0xFFEAF0E9),
      onSurface: koyu ? Colors.white : const Color(0xFF14281B),
      outline: _border,
      surfaceContainerHighest: koyu ? _kartAcik : const Color(0xFFDDE7DC),
    );
  }

  /// Tam temayı kurar; [karanlik] modu seçer.
  static ThemeData kur({required bool karanlik}) {
    final base = ThemeData(
      brightness: karanlik ? Brightness.dark : Brightness.light,
      useMaterial3: true,
      fontFamily: 'Roboto',
      colorScheme: _renkYelpazi(
        parlaklik: karanlik ? Brightness.dark : Brightness.light,
      ),
      scaffoldBackgroundColor:
          karanlik ? Renkler.zemin : const Color(0xFFF3F6F2),
      appBarTheme: AppBarTheme(
        backgroundColor: karanlik ? Renkler.yuzey : const Color(0xFFEAF0E9),
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        iconTheme: IconThemeData(color: karanlik ? Colors.white70 : Colors.black87),
      ),
      iconTheme: IconThemeData(
        color: karanlik ? Colors.white70 : const Color(0xFF2A3B2E),
        shadows: [
          Shadow(
            color: Colors.black.withValues(alpha: 0.28),
            offset: const Offset(0, 1.1),
            blurRadius: 2,
          ),
        ],
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.resolveWith(
            (s) => s.contains(WidgetState.selected)
                ? _altinParlak
                : (karanlik ? Colors.white70 : const Color(0xFF2A3B2E)),
          ),
          shape: const WidgetStatePropertyAll(CircleBorder()),
          overlayColor: WidgetStatePropertyAll(_altin.withValues(alpha: 0.12)),
          padding: const WidgetStatePropertyAll(EdgeInsets.all(8)),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: karanlik ? Renkler.navBar : const Color(0xFFEAF0E9),
        indicatorColor: _altin.withValues(alpha: 0.28),
        height: 66,
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            color: states.contains(WidgetState.selected) ? _altin : null,
            size: 24,
          ),
        ),
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => TextStyle(
            fontSize: 11,
            fontWeight: states.contains(WidgetState.selected)
                ? FontWeight.bold
                : FontWeight.normal,
            color: states.contains(WidgetState.selected)
                ? _altinParlak
                : null,
          ),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: karanlik ? Renkler.navBar : const Color(0xFFEAF0E9),
        selectedItemColor: _altinParlak,
        unselectedItemColor: karanlik ? Colors.white54 : const Color(0xFF5D6B5F),
        selectedIconTheme: const IconThemeData(color: _altin),
        type: BottomNavigationBarType.fixed,
      ),
      // ---------- BUTONLAR (3D kabartma: basınca çöker) ----------
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith(
            (s) => s.contains(WidgetState.disabled)
                ? Colors.white12
                : _zumrut,
          ),
          foregroundColor: WidgetStateProperty.resolveWith(
            (s) => s.contains(WidgetState.disabled)
                ? Colors.white38
                : Colors.white,
          ),
          elevation: const WidgetStatePropertyAll(0),
          surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
          side: WidgetStatePropertyAll(
            BorderSide(color: _altin.withValues(alpha: 0.85), width: 1.3),
          ),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 18, vertical: 13),
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          ),
          textStyle: WidgetStatePropertyAll(
            const TextStyle(fontWeight: FontWeight.w700, letterSpacing: 0.3),
          ),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith(
            (s) => s.contains(WidgetState.disabled)
                ? Colors.white12
                : (karanlik ? _zumrut : const Color(0xFF178A5F)),
          ),
          foregroundColor: WidgetStateProperty.resolveWith(
            (s) => s.contains(WidgetState.disabled)
                ? Colors.white38
                : Colors.white,
          ),
          elevation: const WidgetStatePropertyAll(0),
          surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
          side: WidgetStatePropertyAll(
            BorderSide(color: _altin.withValues(alpha: 0.85), width: 1.3),
          ),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          ),
          textStyle: WidgetStatePropertyAll(
            const TextStyle(fontWeight: FontWeight.w700, letterSpacing: 0.3),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.resolveWith(
            (s) => s.contains(WidgetState.disabled)
                ? Colors.white38
                : _altinParlak,
          ),
          backgroundColor: WidgetStateProperty.resolveWith(
            (s) => s.contains(WidgetState.pressed)
                ? karanlik
                    ? _altin.withValues(alpha: 0.12)
                    : _altin.withValues(alpha: 0.10)
                : Colors.transparent,
          ),
          elevation: const WidgetStatePropertyAll(0),
          surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
          side: WidgetStatePropertyAll(
            BorderSide(color: _altin.withValues(alpha: 0.75), width: 1.4),
          ),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          ),
          textStyle: WidgetStatePropertyAll(
            const TextStyle(fontWeight: FontWeight.w600, letterSpacing: 0.3),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.resolveWith(
            (s) => s.contains(WidgetState.disabled)
                ? Colors.white38
                : _altinParlak,
          ),
          backgroundColor: WidgetStatePropertyAll(_altin.withValues(alpha: 0.10)),
          elevation: const WidgetStatePropertyAll(0),
          surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
          side: WidgetStatePropertyAll(
            BorderSide(color: _altin.withValues(alpha: 0.45), width: 1),
          ),
          minimumSize: const WidgetStatePropertyAll(Size(56, 44)),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 14, vertical: 9),
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          textStyle: WidgetStatePropertyAll(
            const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: _altin,
        foregroundColor: Colors.black,
        elevation: 0,
        highlightElevation: 0,
        shape: const CircleBorder(),
      ),
      // ---------- KAYDIRICILAR ----------
      sliderTheme: SliderThemeData(
        trackHeight: 3,
        activeTrackColor: _altin,
        inactiveTrackColor: _kartAcik.withValues(alpha: 0.7),
        thumbColor: _altinParlak,
        thumbShape: const RoundSliderThumbShape(
          enabledThumbRadius: 8,
          elevation: 0,
          pressedElevation: 0,
        ),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
        overlayColor: _altin.withValues(alpha: 0.22),
        trackShape: const GradyanSliderTrackShape(),
        valueIndicatorColor: _altinKoyu,
        valueIndicatorTextStyle: const TextStyle(color: Colors.white),
      ),
      // ---------- TOGGLE'LAR ----------
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (states) =>
              states.contains(WidgetState.selected) ? _altin : Colors.white38,
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? _zumrut.withValues(alpha: 0.55)
              : Colors.white24,
        ),
        trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? _altin
              : Colors.white24,
        ),
        checkColor: const WidgetStatePropertyAll(Colors.black),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected) ? _altin : null,
        ),
        overlayColor: WidgetStateProperty.resolveWith(
          (states) => _altin.withValues(alpha: 0.15),
        ),
      ),
      // ---------- KARTLAR / YÜZEYLER ----------
      cardTheme: CardThemeData(
        color: karanlik ? _kart : const Color(0xFFEAF0E9),
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: _border.withValues(alpha: 0.55), width: 1),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: karanlik ? _kart : const Color(0xFFF3F6F2),
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: _border.withValues(alpha: 0.7), width: 1.2),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: karanlik ? _kart : const Color(0xFFF3F6F2),
        surfaceTintColor: Colors.transparent,
        modalBackgroundColor: karanlik ? _kart : const Color(0xFFF3F6F2),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
        ),
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: karanlik ? _kart : const Color(0xFFF3F6F2),
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(color: _border.withValues(alpha: 0.5)),
        ),
        textStyle: TextStyle(
          color: karanlik ? Colors.white70 : const Color(0xFF2A3B2E),
          fontSize: 13,
        ),
      ),
      // ---------- GİRİŞ ALANLARI ----------
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: karanlik ? _zemin : const Color(0xFFE4ECE3),
        labelStyle: TextStyle(
          color: karanlik ? Colors.white54 : const Color(0xFF5D6B5F),
        ),
        hintStyle: TextStyle(
          color: karanlik ? Colors.white30 : const Color(0xFF8A978C),
        ),
        prefixIconColor: karanlik ? Colors.white54 : const Color(0xFF5D6B5F),
        suffixIconColor: karanlik ? Colors.white54 : const Color(0xFF5D6B5F),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: _border.withValues(alpha: 0.4)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: _altin.withValues(alpha: 0.8), width: 1.4),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE57373)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE57373), width: 1.4),
        ),
      ),
      // ---------- SEKMELER ----------
      tabBarTheme: TabBarThemeData(
        labelColor: _altinParlak,
        unselectedLabelColor: karanlik ? Colors.white54 : const Color(0xFF5D6B5F),
        indicatorColor: _altin,
        dividerColor: Colors.transparent,
        labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
      ),
      // ---------- DİĞER AYARLAR ----------
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: _altin,
        linearTrackColor: karanlik ? Colors.white12 : const Color(0xFFDDE7DC),
        circularTrackColor: karanlik ? Colors.white12 : const Color(0xFFDDE7DC),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: karanlik ? const Color(0xFF1A2E20) : const Color(0xFF1A2E20),
        contentTextStyle: const TextStyle(color: Colors.white),
        actionTextColor: _altinParlak,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: _altin.withValues(alpha: 0.45)),
        ),
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: karanlik ? _zemin : const Color(0xFF2A3B2E),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _altin.withValues(alpha: 0.4)),
        ),
        textStyle: const TextStyle(color: Colors.white, fontSize: 12),
        waitDuration: const Duration(milliseconds: 400),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: karanlik ? const Color(0xFF1D3A26) : const Color(0xFFDDE7DC),
        selectedColor: _altin.withValues(alpha: 0.55),
        side: BorderSide(color: _altin.withValues(alpha: 0.65), width: 1.1),
        labelStyle: TextStyle(
          color: karanlik ? Colors.white70 : const Color(0xFF2A3B2E),
          fontWeight: FontWeight.w600,
        ),
        secondaryLabelStyle: TextStyle(
          color: karanlik ? Colors.white70 : const Color(0xFF2A3B2E),
          fontWeight: FontWeight.w600,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        showCheckmark: false,
      ),
      dividerTheme: DividerThemeData(
        color: karanlik ? Colors.white12 : const Color(0xFFCFD9C9),
        thickness: 1,
      ),
      listTileTheme: ListTileThemeData(
        textColor: karanlik ? Colors.white : const Color(0xFF14281B),
        iconColor: karanlik ? Colors.white70 : const Color(0xFF2A3B2E),
        tileColor: karanlik ? Renkler.yuzey : const Color(0xFFEAF0E9),
        selectedTileColor: _altin.withValues(alpha: 0.18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: _altin.withValues(alpha: 0.22)),
        ),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: _altin,
        selectionColor: _altin.withValues(alpha: 0.4),
        selectionHandleColor: _altinParlak,
      ),
      timePickerTheme: TimePickerThemeData(
        backgroundColor: karanlik ? _kart : const Color(0xFFF3F6F2),
        hourMinuteTextColor: Colors.white,
        dayPeriodTextColor: _altinParlak,
        dialHandColor: _altin,
        dialBackgroundColor: karanlik ? const Color(0xFF1A3323) : const Color(0xFFDDE7DC),
        entryModeIconColor: _altinParlak,
        hourMinuteColor: WidgetStateColor.resolveWith(
          (states) => states.contains(WidgetState.selected) ? _altin : (karanlik ? Colors.white : const Color(0xFF14281B)),
        ),
        dayPeriodColor: WidgetStateColor.resolveWith(
          (states) => states.contains(WidgetState.selected) ? _altin : (karanlik ? _kartAcik : const Color(0xFFDDE7DC)),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: BorderSide(color: _border.withValues(alpha: 0.6)),
        ),
      ),
      datePickerTheme: DatePickerThemeData(
        backgroundColor: karanlik ? _kart : const Color(0xFFF3F6F2),
        surfaceTintColor: Colors.transparent,
        headerBackgroundColor: karanlik ? _zemin : const Color(0xFFE0E9DE),
        headerForegroundColor: Colors.white,
        dayStyle: TextStyle(color: karanlik ? Colors.white : const Color(0xFF14281B)),
        weekdayStyle: TextStyle(
          color: karanlik ? Colors.white54 : const Color(0xFF5D6B5F),
        ),
        todayBorder: const BorderSide(color: _altin, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: _border.withValues(alpha: 0.6)),
        ),
      ),
    );

    return base;
  }

  /// Sistem durum çubuğu rengini zümrüt/altın tona uyarlar.
  static void sistemCubuklari({required bool karanlik}) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness:
            karanlik ? Brightness.light : Brightness.dark,
        statusBarBrightness:
            karanlik ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: karanlik ? _zemin : const Color(0xFFF3F6F2),
        systemNavigationBarIconBrightness:
            karanlik ? Brightness.light : Brightness.dark,
      ),
    );
  }
}