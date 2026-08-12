// lib/services/saygi_ifadeleri_servisi.dart

import 'package:flutter/material.dart';

import '../models/kissalar_model.dart';

class SaygiIfadeleri {
  static String formatla(String metin, String dilKodu, HonorificType tip) {
    switch (tip) {
      case HonorificType.pbuh:
        return dilKodu == 'tr' ? '$metin (s.a.v.)' : '$metin (PBUH)';
      case HonorificType.saw:
        return '$metin ﷺ';
      case HonorificType.aleyhisselam:
        return dilKodu == 'tr' ? '$metin (a.s.)' : '$metin (p.b.u.h.)';
      case HonorificType.radiallahuanh:
        return dilKodu == 'tr' ? '$metin (r.a.)' : '$metin (R.A.)';
    }
  }

  static TextStyle getDilFontu(String dilKodu) {
    if (dilKodu == 'ur') {
      return const TextStyle(fontFamily: 'Nastaliq', height: 2.0);
    } else if (dilKodu == 'ar') {
      return const TextStyle(fontFamily: 'Naskh', height: 1.8);
    }
    return const TextStyle(fontFamily: 'Roboto', height: 1.5);
  }
}
