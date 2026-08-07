/// Traductions françaises.
const Map<String, String> frDil = {
  // ---------------- ACCUEIL ----------------
  'h.priv': 'CONFIDENTIALITÉ DE BOUT EN BOUT',
  'h.how': "Comment te sens-tu aujourd'hui ?",
  'h.daily': 'Spiritualité du jour',
  'h.discover': 'Explorer',
  'h.more': 'Plus',
  'h.duas': 'Invocations',
  'h.donate': 'Faire un don',
  'h.ilham': 'Inspiration',
  'h.qiblaTitle': 'Qibla',
  'h.qiblaDir': 'Direction de la Qibla',
  'h.kaaba': "Vers la Kaaba",
  'h.locate': 'Localiser',
  'h.ayet': 'Verset du jour',
  'h.last': 'Dernier :',
  'h.streak': 'Série de {n} jours',
  'h.navHome': 'Accueil',
  'h.navNamaz': 'Prières',
  'h.navAi': 'IA',
  'h.navKuran': 'Coran',
  'h.navUmmet': 'Oumma',
  'h.navVideo': 'Vidéos',

  // Humeurs
  'm.huzurlu': 'Serein',
  'm.sukurlu': 'Reconnaissant',
  'm.yorgun': 'Fatigué',
  'm.umutlu': 'Optimiste',
  'm.kaygili': 'Inquiet',

  // Modules quotidiens
  'mod.devam': 'Continuer',
  'mod.gorev': 'Tâches quotidiennes',
  'mod.cami': 'Mosquée & localisation',
  'mod.camiAlt': 'Qibla, mosquées et horaires',
  'mod.carki': 'Roue des objectifs',
  'mod.carkiAlt': 'Coran · Dhikr · Prière',
  'mod.hizli': 'Tasbih rapide',
  'mod.dinle': "Écouter le Coran",
  'mod.dinleAlt': 'Récitateurs du Coran',
  'mod.widget': 'Guide des widgets',
  'mod.widgetAlt': 'Configuration du widget des horaires',
  'mod.pusula': 'Boussole de la Qibla',
  'mod.pusulaAlt': "Trouver la direction de la Kaaba",
  'mod.gorsel': 'Guide de prière illustré',
  'mod.gorselAlt': 'Guide de la prière et des ablutions',
  'mod.tesbih': 'Tasbih',
  'mod.tesbihAlt': 'Compteur de dhikr',

  // Horaires de prière
  'p.imsak': 'Prière du Fajr',
  'p.gunes': 'Lever du soleil',
  'p.ogle': 'Prière du Dhuhr',
  'p.ikindi': 'Prière du Asr',
  'p.aksam': 'Prière du Maghrib',
  'p.yatsi': 'Prière du Isha',
  'v.yaklasan': 'PROCHAINE PRIÈRE',
  'v.siradaki': 'SUIVANTE',
  'v.kaldi': 'restant',

  // Verset du jour
  'ay.1': 'En vérité, avec la difficulté vient un soulagement.',
  'ay.2': "Le cœur ne s'apaise que dans l'évocation d'Allah.",
  'ay.3': 'Évoquez-moi donc, Je vous évoquerai.',
  'ay.4': 'Si vous êtes reconnaissants, Je multiplierai certainement Mes bienfaits.',
  'ay.5': "Quiconque s'en remet à Allah, Allah lui suffit.",
  'ay.6': "Ne désespérez pas de la miséricorde d'Allah.",
  'ay.7': "Allah n'impose à aucune âme une charge au-dessus de ses capacités.",
  'ref.1': 'Sourate Ash-Sharh, verset 6',
  'ref.2': "Sourate Ar-Ra'd, verset 28",
  'ref.3': 'Sourate Al-Baqarah, verset 152',
  'ref.4': 'Sourate Ibrahim, verset 7',
  'ref.5': 'Sourate At-Talaq, verset 3',
  'ref.6': 'Sourate Az-Zumar, verset 53',
  'ref.7': 'Sourate Al-Baqarah, verset 286',

  // ---------------- RÉGLAGES ----------------
  'set.title': 'Réglages',
  'set.account': 'Compte & profil',
  'set.editProfile': 'Modifier le profil',
  'set.editProfileAlt': 'Photo, nom et statistiques',
  'set.time': 'Horaires de prière & localisation',
  'set.autoLoc': 'Localisation automatique (GPS)',
  'set.autoLocAlt': 'Si autorisée, la ville est détectée automatiquement',
  'set.method': 'Méthode de calcul',
  'set.methodDialog': 'Méthode de calcul',
  'set.methodAuto': 'Automatique selon le pays',
  'set.methodInfo':
      'Les horaires de prière sont calculés selon la position du soleil. '
      "Plusieurs écoles de calcul existent dans le monde ; les horaires "
      'peuvent varier de quelques minutes selon les pays. Votre choix '
      "s'applique au calendrier et à toutes les notifications.",
  'set.notif': 'Notifications',
  'set.notifAll': 'Autoriser toutes les notifications',
  'set.notifAllAlt': 'Horaires de prière, versets et jours spéciaux',
  'set.notifCenter': 'Centre de notifications',
  'set.notifCenterAlt': 'Mode silencieux, compteur de rattrapage, types',
  'set.langSection': 'Langue et région',
  'set.lang': 'Langue',
  'set.langAlt': 'Les musulmans du monde choisissent leur langue',
  'set.chooseLang': 'Choisir la langue',
  'set.langUpdated': 'Langue mise à jour.',
  'set.dark': 'Mode sombre',
  'set.darkAlt': 'Le thème se met à jour instantanément',
  'set.appearance': 'Apparence',
  'set.about': 'À propos',
  'set.privacy': 'Politique de confidentialité',
  'set.rate': 'Noter l’application',
  'set.version': 'Version 1.0.0',

  // Descriptions des méthodes
  'm.13': 'Recommandée pour la Turquie',
  'm.3': 'Largement utilisée dans le monde',
  'm.2': 'Pour les États-Unis et le Canada',
  'm.1': 'Pour l’Asie du Sud',
  'm.4': 'Arabie saoudite et alentours',
  'm.5': 'Afrique et Moyen-Orient',

  // Messages
  's.locUpdated': 'Localisation mise à jour : {sehir}',
  's.locFail': 'Localisation impossible. Vérifiez l’autorisation GPS et la '
      'position de l’appareil, ou choisissez la ville manuellement depuis '
      "l'écran Localisation.",
  's.notifOn': 'Toutes les notifications sont autorisées.',
  's.notifOff': 'Toutes les notifications sont désactivées.',
  's.methodUpdated': 'Horaires mis à jour avec la nouvelle méthode.',

  // Dialogues
  'd.privacy': 'Politique de confidentialité',
  'd.privacyBody': "L'application conserve vos données sur votre appareil ; "
      "les informations de ville et de localisation servent uniquement à "
      "calculer précisément les horaires de prière et la direction de la "
      'Qibla. Ces données ne sont jamais partagées avec des tiers et peuvent '
      'être supprimées par l’utilisateur.',
  'd.understand': 'Compris',
  'd.thanks': 'Merci ! 🙏',
  'd.rateBody': 'Nous sommes heureux que vous utilisiez notre application. '
      'Donnez une note sur la boutique pour nous aider à atteindre plus de '
      'frères et sœurs.',
  'd.ok': 'OK',
};