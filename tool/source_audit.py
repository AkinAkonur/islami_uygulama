"""Kaynak yapısı denetimi; Flutter analizinin veya cihaz testinin yerine geçmez."""
from pathlib import Path
from collections import Counter
import json,re,sys,xml.etree.ElementTree as ET,zipfile
root=Path(__file__).resolve().parents[1]
errors=[]
dart=list((root/'lib').rglob('*.dart'))+list((root/'test').rglob('*.dart'))
for p in dart:
 s=p.read_text(encoding='utf-8-sig')
 for imp in re.findall(r'''(?:import|export|part)\s+['"]([^'"]+)['"]''',s):
  if imp.startswith('dart:'): continue
  if imp.startswith('package:islami_uygulama/'):
   target=root/'lib'/imp.split('/',1)[1]
  elif imp.startswith('package:'): continue
  else: target=p.parent/imp
  if not target.exists(): errors.append(f'Missing import: {p.relative_to(root)} -> {imp}')
for p in (root/'android').rglob('*.xml'):
 try: ET.parse(p)
 except Exception as e: errors.append(f'XML: {p.relative_to(root)}: {e}')
for p in (root/'assets').rglob('*.json'):
 try: json.loads(p.read_text(encoding='utf-8-sig'))
 except Exception as e: errors.append(f'JSON: {p.relative_to(root)}: {e}')
for p in (root/'android/app/src/main/res').rglob('*'):
 if p.is_file() and not re.fullmatch(r'[a-z0-9_]+(?:\.9)?\.[a-z0-9]+',p.name):
  errors.append(f'Invalid Android resource filename: {p.name}')
lang_keys={}
for lang in ['tr','en','ar','id','ms','ur','bn','fr','ru']:
 s=(root/f'lib/l10n/{lang}.dart').read_text(encoding='utf-8-sig')
 keys=re.findall(r'''['"]([\w.]+)['"]\s*:''',s)
 duplicates=[k for k,n in Counter(keys).items() if n>1]
 if duplicates: errors.append(f'Duplicate keys {lang}: {duplicates}')
 lang_keys[lang]=set(keys)
union=set().union(*lang_keys.values())
for lang,keys in lang_keys.items():
 if keys!=union: errors.append(f'Missing keys {lang}: {sorted(union-keys)}')
for p in (root/'lib').rglob('*.dart'):
 if 'l10n' in p.parts: continue
 for key in re.findall(r'''\.t\(['"]([\w.]+)['"]\)''',p.read_text(encoding='utf-8-sig')):
  if key not in union: errors.append(f'Undefined translation {p.relative_to(root)}: {key}')
for p in (root/'assets').rglob('*.zip'):
 with zipfile.ZipFile(p) as z:
  if z.testzip(): errors.append(f'Damaged nested ZIP: {p.name}')
for name in ['ezan_kisa','altin_cingilti','zumrut_damla','huzur_zili']:
 p=root/f'android/app/src/main/res/raw/{name}.mp3'
 if not p.exists() or p.stat().st_size==0: errors.append(f'Missing sound: {name}')
checks={
 'legacy_notice_removed':not (root/'android/app/src/main/res/raw/NOTICE.txt').exists(),
 'secde_object_supported':"secdeVarMi(a['sajda'])" in (root/'lib/services/kuran_api.dart').read_text(),
 'language_search':"/all/$aktifMealEdisyonu" in (root/'lib/services/kuran_api.dart').read_text(),
 'vibration_channel':"titresimAktif ? 'v1' : 'v0'" in (root/'lib/services/gercek_bildirimler.dart').read_text(),
 'silent_option':"sessiz('sessiz', '')" in (root/'lib/services/namaz_bildirim_ayarlari.dart').read_text(),
}
errors.extend(k for k,v in checks.items() if not v)
report={'kind':'Structural source audit; NOT compilation or runtime tests','lib_dart_files':len(list((root/'lib').rglob('*.dart'))),'test_dart_files':len(list((root/'test').rglob('*.dart'))),'translation_key_counts':{k:len(v) for k,v in lang_keys.items()},'checks':checks,'errors':errors}
(root/'docs/source_audit.json').write_text(json.dumps(report,ensure_ascii=False,indent=2),encoding='utf-8')
print(json.dumps(report,ensure_ascii=False,indent=2))
sys.exit(bool(errors))
