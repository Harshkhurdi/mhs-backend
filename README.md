# Medelec Healthcare Solutions (MHS) — Backend & Firebase Configuration

Firebase **security rules** for **Medelec Healthcare Solutions** — Firestore rules that replace the previous Supabase RLS policies.

---

## 📁 Repository Structure

```
mhs-backend/
└── firestore.rules    # Firestore rules: products catalog + inquiries
```

> **Note:** This repository requires no environment variables. The Firebase web
> app configuration used by the site lives in the frontend (`mhs-frontend/.env`) only.
>
> **Media hosting:** product images and PDF brochures are referenced by URL —
> host the files anywhere (company web space, the manufacturer's site, or any
> static host) and paste the link in the admin dashboard. Firebase Storage is
> not used because it requires the paid Blaze plan on new projects.

---

## 🗄 Firebase Setup Flow

### 1. Create Firestore Database
In the **Firebase console** (project `mhs-project-7235e`) → **Firestore Database** → **Create database** (Production mode).

### 2. Publish Firestore Rules
**Firestore Database** → **Rules** → replace the contents with `firestore.rules` from this repository → **Publish**.

### 3. Enable Authentication & Create the Admin Account
- **Authentication** → **Sign-in method** → enable **Email/Password**.
- Public self-registration is disabled for security. Create the administrative user via:
  **Authentication** → **Users** → **Add user** — use an authorized company email address and a secure password.

---

## 🛡 Security Rules Overview

- **`products` collection** (medical equipment catalog):
  - `read`: Public — filtered by `is_published = true`; authenticated admins read everything, including drafts.
  - `create`, `update`, `delete`: Authenticated admin users only.
- **`inquiries` collection** (contact form & RFQ submissions):
  - `create`: Public — any visitor can submit.
  - `read`: Authenticated admin users only. No `update`/`delete`, same as before.
- **Product media** (product photography & PDF datasheets):
  - Referenced by public URL; hosted outside Firebase.

