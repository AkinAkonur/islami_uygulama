// lib/widgets/interaktif_metin_renderer.dart

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../services/renkler.dart';

class InteraktifMetinRenderer extends StatelessWidget {
  final String hamMetin;
  final Function(String tur, String id) OnLinkTiklandi;
  final Function(String terim, String aciklama) OnTerimTiklandi;

  const InteraktifMetinRenderer({
    super.key,
    required this.hamMetin,
    required this.OnLinkTiklandi,
    required this.OnTerimTiklandi,
  });

  @override
  Widget build(BuildContext context) {
    List<InlineSpan> spans = [];
    // Metin içindeki özel tag'leri parse eden Regex
    final RegExp regExp = RegExp(
      r'\[(sahabe|ayet|sozluk|peygamber):([^\]]+)\](.*?)\[\/\1\]',
    );

    int lastMatchEnd = 0;
    for (final Match match in regExp.allMatches(hamMetin)) {
      if (match.start > lastMatchEnd) {
        spans.add(
          TextSpan(
            text: hamMetin.substring(lastMatchEnd, match.start),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              height: 1.6,
            ),
          ),
        );
      }

      final String tur = match.group(1)!;
      final String idVeyaTerim = match.group(2)!;
      final String gorunenMetin = match.group(3)!;

      spans.add(
        TextSpan(
          text: ' $gorunenMetin ',
          style: TextStyle(
            color: tur == 'sozluk' ? Colors.amberAccent : Renkler.vurgu,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
            decorationStyle: tur == 'sozluk'
                ? TextDecorationStyle.dashed
                : TextDecorationStyle.solid,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              if (tur == 'sozluk') {
                OnTerimTiklandi(
                  gorunenMetin,
                  "Terim açıklaması veritabanından çekilecek.",
                );
              } else {
                OnLinkTiklandi(tur, idVeyaTerim);
              }
            },
        ),
      );

      lastMatchEnd = match.end;
    }

    if (lastMatchEnd < hamMetin.length) {
      spans.add(
        TextSpan(
          text: hamMetin.substring(lastMatchEnd),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            height: 1.6,
          ),
        ),
      );
    }

    return RichText(text: TextSpan(children: spans));
  }
}
