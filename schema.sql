-- Medelec Healthcare Solutions (MHS) Supabase Database Schema

-- 1. Create Products Table
CREATE TABLE IF NOT EXISTS public.products (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    slug TEXT UNIQUE NOT NULL,
    name TEXT NOT NULL,
    specialty TEXT NOT NULL,
    brand TEXT NOT NULL,
    description TEXT,
    image_url TEXT,
    pdf_url TEXT,
    is_published BOOLEAN DEFAULT true,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Index for efficient published product lookups
CREATE INDEX IF NOT EXISTS idx_products_published ON public.products (is_published);
CREATE INDEX IF NOT EXISTS idx_products_specialty ON public.products (specialty);
CREATE INDEX IF NOT EXISTS idx_products_brand ON public.products (brand);

-- 2. Row Level Security (RLS) Setup
ALTER TABLE public.products ENABLE ROW LEVEL SECURITY;

-- Allow public read access to published products
CREATE POLICY "Public users can view published products" 
ON public.products 
FOR SELECT 
USING (is_published = true);

-- Allow authenticated admins to view all products (including unpublished)
CREATE POLICY "Admins can view all products" 
ON public.products 
FOR SELECT 
TO authenticated 
USING (true);

-- Allow authenticated admins to insert products
CREATE POLICY "Admins can insert products" 
ON public.products 
FOR INSERT 
TO authenticated 
WITH CHECK (true);

-- Allow authenticated admins to update products
CREATE POLICY "Admins can update products" 
ON public.products 
FOR UPDATE 
TO authenticated 
USING (true)
WITH CHECK (true);

-- Allow authenticated admins to delete products
CREATE POLICY "Admins can delete products" 
ON public.products 
FOR DELETE 
TO authenticated 
USING (true);
