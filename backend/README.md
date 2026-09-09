# Production AI backend

This is a Firebase Cloud Functions v2 callable backend for the Flutter app.

- Anonymous Firebase Auth required.
- App Check enforced on the callable function.
- Gemini key supplied only through Secret Manager as `GEMINI_API_KEY`.
- 10 successful reservations/day/user and 3 requests/minute/user.
- Firestore stores counters only; prompts and answers are not persisted.
- Provider errors refund the daily reservation when possible.
- Direct client reads/writes are denied by `firestore.rules`.
- A small Quran reference catalog is used for retrieval grounding.

## Editorial limitation

`data/source_catalog.json` is a technical starter catalog, not a scholarly
certification. Every summary, translation choice, citation and policy must be
reviewed by qualified editors before a public religious-information release.
The backend prompt refuses unsupported personal rulings and asks users to
consult a qualified local scholar when context is insufficient.

## Deployment

Run `FIREBASE_KURULUM.ps1` from the repository root on an account that owns the
Firebase project. Cloud Functions deployment generally requires the Blaze plan.
The script never asks you to paste the Gemini key into source code; Firebase CLI
collects it directly for Secret Manager.
