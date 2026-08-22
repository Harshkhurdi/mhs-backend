# Medelec Healthcare Solutions (MHS) — Backend & Database Schema

Database migrations, seed data, and Row-Level Security (RLS) configuration for **Medelec Healthcare Solutions**.

---

## 📁 Repository Structure

```
mhs-backend/
├── supabase/
│   └── migrations/
│       ├── 001_create_products.sql         # Base products schema & constraints
│       ├── 002_seed_products.sql           # Initial OEM equipment catalog
│       ├── 003_rls_policies.sql            # Public read / Authenticated write rules
│       ├── 004_add_is_published.sql        # Draft/Publish status control
│       ├── 005_create_storage_bucket.sql   # Storage bucket for brochures/images
│       └── 006_create_inquiries.sql        # Contact form & RFQ inquiries table
├── .env.example                            # Supabase keys template
└── README.md
```

---

## 🗄 Database & Supabase Setup Flow

### 1. Apply Database Migrations
In your **Supabase Dashboard** -> **SQL Editor**, run the migration files in numerical order (`001` through `006`).

### 2. Create Admin Account
Public self-registration is disabled for security. Create the initial administrative user via:
- **Supabase Dashboard** -> **Authentication** -> **Users** -> **Add User** -> **Create User**
- Use an authorized company email address and set a secure password.

### 3. Verify Storage Bucket
Run `005_create_storage_bucket.sql` to instantiate the `product-media` public bucket for PDF datasheets and product photography.

---

## 🛡 Security Rules Overview

- **`products` Table**:
  - `SELECT`: Public (anon role) — filtered by `is_published = true` on the frontend.
  - `INSERT`, `UPDATE`, `DELETE`: Authenticated admin users only.
- **`product-media` Storage Bucket**:
  - `SELECT`: Public access.
  - `INSERT`, `UPDATE`, `DELETE`: Authenticated admin users only.
