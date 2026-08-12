import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

/// Al Quran Cloud API'den 30 cüzü quran-uthmani hattıyla indirir,
/// gereksiz alanları ayıklar ve assets/cuzler/cuz{N}.json olarak yazar.
Future<void> main() async {
  final client = http.Client();
  final dizin = Directory('assets/cuzler');
  dizin.createSync(recursive: true);
  var toplam = 0;

  for (var n = 1; n <= 30; n++) {
    final res = await client
        .get(Uri.parse('https://api.alquran.cloud/v1/juz/$n/quran-uthmani'))
        .timeout(const Duration(seconds: 60));
    if (res.statusCode != 200) {
      stdout.writeln('Cüz $n başarısız: ${res.statusCode}');
      continue;
    }
    final json = jsonDecode(utf8.decode(res.bodyBytes)) as Map<String, dynamic>;
    final data = json['data'] as Map<String, dynamic>;
    final ayah = (data['ayahs'] as List<dynamic>).map((e) {
      final m = e as Map<String, dynamic>;
      final sure = m['surah'] as Map<String, dynamic>;
      return <String, Object>{
        's': sure['number'] as int,
        'a': m['numberInSurah'] as int,
        'n': m['number'] as int,
        't': (m['text'] as String).replaceAll('\uFEFF', ''),
        'p': m['page'] as int,
        'sj': m['sajda'] is bool ? m['sajda'] as bool : true,
      };
    }).toList();
    final dosya = File('${dizin.path}/cuz$n.json');
    dosya.writeAsStringSync(jsonEncode(ayah), flush: true);
    toplam += dosya.lengthSync();
    stdout.writeln('Cüz $n: ${dosya.lengthSync()} bayt, ${ayah.length} ayet');
  }

  stdout.writeln('Toplam: $toplam bayt');
  client.close();
}
