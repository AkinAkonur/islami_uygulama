/// Terjemahan Bahasa Melayu (Malaysia & Brunei).
const Map<String, String> msDil = {
  // ---------------- LAMAN UTAMA ----------------
  'h.priv': 'PRIVASI PENUH UJUNG KE UJUNG',
  'h.how': 'Bagaimana perasaanmu hari ini?',
  'h.daily': 'Penerapan Harian',
  'h.discover': 'Teroka',
  'h.more': 'Lebih Banyak',
  'h.duas': 'Doa',
  'h.cuzler': 'Juz',
  'h.donate': 'Derma',
  'h.ilham': 'Inspirasi',
  'h.qiblaTitle': 'Kiblat',
  'h.qiblaDir': 'Arah Kiblat',
  'h.kaaba': 'Ke Arah Kaabah',
  'h.locate': 'Lokasi',
  'h.ayet': 'Ayat Hari Ini',
  'h.last': 'Terakhir:',
  'h.streak': 'Siri {n} hari',
  'h.navHome': 'Laman Utama',
  'h.navNamaz': 'Solat',
  'h.navAi': 'AI',
  'h.navKuran': "Al-Qur'an",
  'h.navUmmet': 'Umat',

  // Perasaan
  'm.huzurlu': 'Tenang',
  'm.sukurlu': 'Bersyukur',
  'm.yorgun': 'Penat',
  'm.umutlu': 'Berharap',
  'm.kaygili': 'Risau',

  // Modul harian
  'mod.devam': 'Sambung',
  'mod.gorev': 'Tugasan Harian',
  'mod.cami': 'Masjid & Lokasi',
  'mod.camiAlt': 'Kiblat, masjid dan waktu',
  'mod.carki': 'Roda Matlamat',
  'mod.carkiAlt': "Al-Qur'an · Zikir · Solat",
  'mod.hizli': 'Tasbih Pantas',
  'mod.dinle': "Dengar Al-Qur'an",
  'mod.dinleAlt': "Qari Al-Qur'an",
  'mod.widget': 'Panduan Widget',
  'mod.widgetAlt': 'Pemasangan widget waktu solat',
  'mod.pusula': 'Kompas Kiblat',
  'mod.pusulaAlt': 'Cari arah ke Kaabah',
  'mod.gorsel': 'Panduan Solat Visual',
  'mod.gorselAlt': 'Panduan solat & wudhu',

  // Waktu solat
  'p.imsak': 'Solat Subuh',
  'p.gunes': 'Terbit',
  'p.ogle': 'Solat Zuhur',
  'p.ikindi': 'Solat Asar',
  'p.aksam': 'Solat Maghrib',
  'p.yatsi': 'Solat Isyak',
  'v.yaklasan': 'WAKTU SOLAT BERIKUTNYA',
  'v.siradaki': 'SETERUSNYA',
  'v.kaldi': 'tinggal',

  // Ayat hari ini
  'ay.1': 'Sesungguhnya bersama kesulitan itu ada kemudahan.',
  'ay.2': 'Ketahuilah, hanya dengan mengingat Allah hati menjadi tenang.',
  'ay.3': 'Maka ingatlah kepada-Ku, Aku pun akan mengingatmu.',
  'ay.4': 'Jika kamu bersyukur, nescaya Aku akan menambah nikmatmu.',
  'ay.5': 'Siapa yang bertawakal kepada Allah, maka Allah cukuplah baginya.',
  'ay.6': 'Janganlah berputus asa dari rahmat Allah.',
  'ay.7': 'Allah tidak membebani seseorang melampaui kemampuannya.',
  'ref.1': 'Surah Ash-Sharh, 6',
  'ref.2': "Surah Ar-Ra'd, 28",
  'ref.3': 'Surah Al-Baqarah, 152',
  'ref.4': 'Surah Ibrahim, 7',
  'ref.5': 'Surah At-Talaq, 3',
  'ref.6': 'Surah Az-Zumar, 53',
  'ref.7': 'Surah Al-Baqarah, 286',

  // ---------------- SETTINGS ----------------
  'set.title': 'Tetapan',
  'set.account': 'Akaun & Profil',
  'set.editProfile': 'Sunting Profil',
  'set.editProfileAlt': 'Foto, nama dan statistik',
  'set.time': 'Waktu Solat & Lokasi',
  'set.autoLoc': 'Lokasi Automatik (GPS)',
  'set.autoLocAlt': 'Apabila permit diberi, bandar dikesan secara automatik',
  'set.method': 'Kaedah Pengiraan',
  'set.methodDialog': 'Kaedah Pengiraan',
  'set.methodAuto': 'Automatik ikut negara',
  'set.methodInfo':
      'Waktu solat dikira mengikut kedudukan matahari. Terdapat banyak '
      'mazhab pengiraan di dunia; waktu mungkin berbeza beberapa minit antara '
      'negara. Kaedah pilihan anda digunakan untuk jadual waktu dan semua '
      'pemberitahuan.',
  'set.notif': 'Pemberitahuan',
  'set.notifAll': 'Benarkan Semua Pemberitahuan',
  'set.notifAllAlt': 'Waktu solat, ayat dan hari istimewa',
  'set.notifCenter': 'Pusat Pemberitahuan',
  'set.namazNotif': 'Peringatan Waktu Solat',
  'set.namazNotifAlt': 'Tetapkan masa peringatan untuk setiap solat',
  'set.notifCenterAlt': 'Mod senyap, kiraan qada, tetapan jenis',
  'set.langSection': 'Bahasa & Wilayah',
  'set.lang': 'Bahasa',
  'set.langAlt': 'Umat Islam dunia memilih bahasa sendiri',
  'set.chooseLang': 'Pilih Bahasa',
  'set.langUpdated': 'Bahasa dikemas kini.',
  'set.dark': 'Mod Gelap',
  'set.darkAlt': 'Tema aplikasi dikemas kini serta-merta',
  'set.appearance': 'Penampilan',
  'set.about': 'Mengenai',
  'set.privacy': 'Dasar Privasi',
  'set.privacyCenter': 'Pusat Privasi',
  'set.privacyCenterAlt': 'Kebenaran, muat turun & padam data anda',
  'set.rate': 'Nilai Aplikasi Ini',
  'set.version': 'Versi 1.0.0',
  'set.accent': 'Warna Aksen',
  'set.accentDialog': 'Pilih Warna Aksen',
  'set.accentInfo': 'Warna aksen menentukan warna utama aplikasi. Jika '
      '"Automatik" dipilih, warna berubah secara semula jadi mengikut waktu '
      'solat.',
  's.accentUpdated': 'Warna aksen dikemas kini.',
  'c.auto': 'Automatik (ikut waktu solat)',
  'c.zumrut': 'Zamrud',
  'c.mavi': 'Biru',
  'c.altin': 'Emas',
  'c.turkuaz': 'Teal',
  'c.gul': 'Mawar',

  // Deskripsi kaedah
  'm.13': 'Disyorkan untuk Turki',
  'm.3': 'Biasa Digunakan di Seluruh Dunia',
  'm.2': 'Untuk Amerika Syarikat dan Kanada',
  'm.1': 'Untuk Asia Selatan',
  'm.4': 'Arab Saudi dan sekitarnya',
  'm.5': 'Afrika dan Timur Tengah',

  // Mesej
  's.locUpdated': 'Lokasi diperbarui: {sehir}',
  's.locFail': 'Lokasi tidak dapat diperoleh. Periksa kebenaran GPS dan '
      'lokasi peranti, atau pilih bandar secara manual dari skrin Lokasi.',
  's.notifOn': 'Semua pemberitahuan dibenarkan.',
  's.notifOff': 'Semua pemberitahuan dimatikan.',
  's.methodUpdated': 'Waktu solat diperbarui dengan kaedah baru.',

  // Dialog
  'd.privacy': 'Kebijakan Privasi',
  'd.privacyBody': 'Aplikasi menyimpan data anda pada peranti; maklumat '
      'kota dan lokasi hanya digunakan untuk mengira waktu solat dan arah '
      'kiblat dengan tepat. Data lokasi tidak dikongsi dengan pihak ketiga '
      'dan boleh dihapuskan oleh pengguna.',
  'd.understand': 'Faham',
  'd.thanks': 'Terima kasih! 🙏',
  'd.rateBody': 'Kami gembira anda menggunakan aplikasi ini. Beri penilaian '
      'di kedai aplikasi untuk membantu kami menjangkau lebih ramai umat.',
  'd.ok': 'OK',

  // Halaman Dasar Privasi
  'pp.intro': 'Dasar privasi ini menerangkan maklumat yang dikumpul oleh '
      'aplikasi Huzur & Perjalanan Rohani, cara ia digunakan dan cara ia '
      'dilindungi. Dengan menggunakan aplikasi ini, anda bersetuju dengan '
      'dasar ini.',
  'pp.s1t': 'Data yang Kami Kumpul',
  'pp.s1b': 'Semua data anda disimpan pada peranti anda; aplikasi tidak '
      'memerlukan akaun. Maklumat profil, kemajuan bacaan, rekod ibadah '
      'dan tetapan disimpan hanya dalam storan tempatan.',
  'pp.s2t': 'Lokasi dan Kiblat',
  'pp.s2b': 'Bandar atau koordinat anda digunakan untuk mengira waktu solat '
      'yang tepat dan arah kiblat. Maklumat ini hanya dihantar ke perkhidmatan '
      'API waktu solat dan tidak pernah digunakan untuk pemasaran atau '
      'disimpan di luar peranti anda.',
  'pp.s3t': 'Pemberitahuan',
  'pp.s3b': 'Pemberitahuan waktu solat dan hari khas hanya dihantar dengan '
      'izin anda. Anda boleh menghidupkan atau mematikan pilihan ini pada '
      'bila-bila masa dari skrin tetapan.',
  'pp.s4t': 'Perkongsian dengan Pihak Ketiga',
  'pp.s4b': 'Data anda tidak pernah dikongsi, dijual atau disewa kepada '
      'pihak ketiga. Aplikasi tidak membuat sambungan luaran kecuali '
      'perkhidmatan API percuma yang pilihan.',
  'pp.s5t': 'Penyimpanan dan Pemadaman Data',
  'pp.s5b': 'Data anda hanya disimpan dengan selamat pada peranti anda. '
      'Apabila anda menyahpasang aplikasi atau membersihkan data daripada '
      'tetapan, semua maklumat dipadam secara kekal.',
  'pp.s6t': 'Privasi Kanak-kanak',
  'pp.s6b': 'Aplikasi ini mengandungi kandungan umum dan tidak meminta '
      'maklumat daripada kanak-kanak. Walau bagaimanapun, pengawasan '
      'keluarga amat digalakkan.',
  'pp.s7t': 'Perubahan dan Hubungan',
  'pp.s7b': 'Dasar ini mungkin dikemas kini; perubahan penting akan '
      'diumumkan dalam aplikasi. Anda boleh menggunakan saluran hubungan '
      'dalam aplikasi untuk sebarang soalan.',
  'pp.last': 'Kemas kini terakhir: Ogos 2026',

  // Halaman penilaian
  'r.baslik': 'Bagaimana pengalaman anda?',
  'r.baslikPuanli': 'Terima kasih atas maklum balas berharga anda!',
  'r.altBaslik': 'Penilaian anda membantu kami mengembangkan aplikasi dan '
      'menjangkau lebih ramai saudara.',
  'r.soru': 'Berapa bintang yang anda berikan kepada aplikasi ini?',
  'r.etiket1': 'Sangat buruk',
  'r.etiket2': 'Buruk',
  'r.etiket3': 'Baik',
  'r.etiket4': 'Sangat baik',
  'r.etiket5': 'Cemerlang',
  'r.ipucu': 'Ketik bintang di atas untuk mula menilai.',
  'r.oneriBaslik': 'Bantu kami bertambah baik',
  'r.oneriIpucu': 'Tulis masalah yang anda hadapi atau cadangan di sini…',
  'r.gonder': 'Hantar Maklum Balas',
  'r.gonderildi': 'Dihantar',
  'r.gonderildiMetin': 'Maklum balas anda telah sampai. Setiap catatan '
      'membuat aplikasi lebih baik.',
  'r.tesekkurBaslik': 'Kami gembira!',
  'r.tesekkurMetin': 'Penilaian tinggi anda memberi kami kekuatan. Simpan '
      'penilaian anda untuk berkongsi kepuasan ini dengan kami.',
  'r.kaydet': 'Simpan Penilaian Saya',
  'r.kaydedildi': 'Penilaian anda telah disimpan. Terima kasih! 🙏',
  'r.not': 'Penilaian anda hanya disimpan pada peranti anda dan tidak pernah '
      'dihantar ke mana-mana pelayan.',

  // ---------------- PEMBANTU AI ----------------
  'ai.title': 'Tafsir AI & Pembantu',
  'ai.hak': 'Kredit',
  'ai.disclaimer': 'Pembantu ini untuk tujuan maklumat dan tafsir; bagi '
      'hukum agama yang mengikat (fatwa), sila rujuk ulama yang berkelayakan.',
  'ai.mode': 'Mod Pembantu',
  'ai.askTitle': 'Tanya tentang Ayat, Surah atau Soalan Rohani',
  'ai.hint': 'cth. Apa pandangan anda tentang Nisa 34?',
  'ai.samples': 'Contoh Soalan',
  'ai.answerTitle': 'Jawapan AI',
  'ai.apiMissingTitle': 'Kunci API tidak ditetapkan',
  'ai.apiMissingBody': 'Dapatkan kunci percuma: aistudio.google.com/apikey\n'
      'Kemudian jalankan aplikasi seperti ini:\n'
      'flutter run --dart-define=GEMINI_API_KEY=KEY',
  'ai.fbUp': 'Terima kasih atas maklum balas anda!',
  'ai.fbDown': 'Maklum balas anda telah diterima.',
  'ai.c.tefsir': 'Tafsir Al-Quran',
  'ai.c.fikih': 'Fikah & Ibadah',
  'ai.c.akaid': 'Akidah & Iman',
  'ai.c.hadis': 'Hadis & Sunnah',
  'ai.c.siyer': 'Sirah & Sejarah',
  'ai.c.dua': 'Doa & Zikir',
  'ai.c.aile': 'Keluarga & Perkahwinan',
  'ai.c.teselli': 'Hiburan & Harapan',
  'ai.c.karsilastirma': 'Perbandingan',
  'ai.c.ogrenme': 'Mod Pembelajaran',
  'ai.q1': 'Terangkan Surah Al-Fatihah langkah demi langkah.',
  'ai.q2': 'Ayat dan hadis apa tentang kesabaran?',
  'ai.q3': 'Bagaimana cara solat qada?',
  'ai.q4': 'Apakah bezanya tafsir dan terjemahan?',
  'ai.q5': 'Ayat apa tentang keampunan dan taubat?',
  'ai.q6': 'Hadis apa tentang berbuat baik kepada ibu bapa?',
  'ai.q7': 'Apa cadangan sokongan rohani pada hari yang sukar?',
  'ai.q8': 'Apakah bezanya zakat dan sedekah?',
  'ai.cs.tefsir.1': 'Apakah tafsir Surah Al-Ikhlas?',
  'ai.cs.tefsir.2': 'Apakah yang diajar oleh Ayat Kursi?',
  'ai.cs.tefsir.3': 'Apakah hikmah ayat yang berulang dalam Ar-Rahman?',
  'ai.cs.fikih.1': 'Apakah rukun solat?',
  'ai.cs.fikih.2': 'Apakah yang membatalkan wudu?',
  'ai.cs.fikih.3': 'Bagaimanakah zakat dikira?',
  'ai.cs.akaid.1': 'Apakah rukun iman?',
  'ai.cs.akaid.2': 'Apakah takdir dan bagaimana memahaminya?',
  'ai.cs.akaid.3': 'Apakah maksud beriman kepada malaikat?',
  'ai.cs.hadis.1': 'Kitab hadis yang manakah dipercayai?',
  'ai.cs.hadis.2': 'Apakah bezanya hadis sahih dan daif?',
  'ai.cs.hadis.3': 'Hadis apakah tentang hak jiran?',
  'ai.cs.siyer.1': 'Ceritakan zaman kanak-kanak Nabi.',
  'ai.cs.siyer.2': 'Bolehkah anda bercerita tentang Hijrah?',
  'ai.cs.siyer.3': 'Bolehkah anda meringkaskan Perang Badar?',
  'ai.cs.dua.1': 'Senaraikan doa-doa yang terdapat dalam Al-Quran.',
  'ai.cs.dua.2': 'Doa apakah yang dibaca ketika cemas dan tertekan?',
  'ai.cs.dua.3': 'Apakah zikir pagi dan petang?',
  'ai.cs.aile.1': 'Bagaimana cara mengekalkan keharmonian rumahtangga?',
  'ai.cs.aile.2': 'Apakah hak ibu bapa?',
  'ai.cs.aile.3': 'Bagaimana cara mendidik anak dalam Islam?',
  'ai.cs.teselli.1': 'Saya cemas, ayat apakah yang menenangkan saya?',
  'ai.cs.teselli.2': 'Ucapkan beberapa perkataan rohani untuk kesedihan.',
  'ai.cs.teselli.3': 'Saya hilang harapan, apa yang patut saya buat?',
  'ai.cs.karsilastirma.1': 'Apakah beza solat fardu dan sunat?',
  'ai.cs.karsilastirma.2': 'Apakah beza zakat dan sedekah?',
  'ai.cs.karsilastirma.3': 'Apakah perbezaan utama antara mazhab fiqah?',
  'ai.cs.ogrenme.1': 'Apakah ilmu tafsir? Jelaskan ringkas.',
  'ai.cs.ogrenme.2': 'Bagaimana cara mula belajar usul fiqah?',
  'ai.cs.ogrenme.3': 'Jelaskan istilah-istilah Islam yang lazim.',
  'ai.kaynak': 'Sumber',
  'ai.kaynakNot': 'Jawapan ini bersifat maklumat; sentiasa sahkan nombor '
      'ayat dan hadis daripada sumber tafsir dan hadis.',
  'ai.yardimBaslik': 'Bagaimana saya boleh membantu anda?',
  'ai.ornekBaslik': 'Contoh Pantas',
  'h.welcome': 'Selamat datang, {name}',
  'h.hijriYear': 'Hijri {year}',
  'h.ilhamDesc': 'Inspirasi baharu setiap hari, penemuan baharu setiap masa.',
  'h.ilhamExplore': 'Jelajahi halaman Inspirasi →',
  'h.greeting.sub': 'Hijri {year}',
};