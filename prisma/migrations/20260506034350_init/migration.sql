-- CreateEnum
CREATE TYPE "Role" AS ENUM ('ADMIN', 'EDITOR');

-- CreateEnum
CREATE TYPE "IntroSectionType" AS ENUM ('GENERAL', 'FIELDS', 'VISION', 'MISSION', 'CORE_VALUES');

-- CreateEnum
CREATE TYPE "ProductCategoryType" AS ENUM ('COMMERCIAL', 'INDUSTRIAL');

-- CreateEnum
CREATE TYPE "SolutionFieldType" AS ENUM ('TELECOM', 'IT', 'DIGITAL_TRANSFORM');

-- CreateEnum
CREATE TYPE "NewsCategory" AS ENUM ('COMPANY', 'INDUSTRY', 'EVENT', 'TECH');

-- CreateEnum
CREATE TYPE "PartnerType" AS ENUM ('CUSTOMER', 'PARTNER');

-- CreateTable
CREATE TABLE "users" (
    "id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password_hash" TEXT NOT NULL,
    "full_name" TEXT NOT NULL,
    "role" "Role" NOT NULL DEFAULT 'EDITOR',
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "home_slideshows" (
    "id" TEXT NOT NULL,
    "title_vi" TEXT NOT NULL,
    "title_en" TEXT,
    "subtitle_vi" TEXT,
    "subtitle_en" TEXT,
    "image_url" TEXT NOT NULL,
    "link_url" TEXT,
    "order" INTEGER NOT NULL DEFAULT 0,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "home_slideshows_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "home_videos" (
    "id" TEXT NOT NULL,
    "title_vi" TEXT NOT NULL,
    "title_en" TEXT,
    "youtube_url" TEXT NOT NULL,
    "thumbnail_url" TEXT,
    "order" INTEGER NOT NULL DEFAULT 0,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "home_videos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "company_intro_sections" (
    "id" TEXT NOT NULL,
    "type" "IntroSectionType" NOT NULL,
    "title_vi" TEXT NOT NULL,
    "title_en" TEXT,
    "content_vi" TEXT NOT NULL,
    "content_en" TEXT,
    "order" INTEGER NOT NULL DEFAULT 0,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "company_intro_sections_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "organization_nodes" (
    "id" TEXT NOT NULL,
    "parent_id" TEXT,
    "title_vi" TEXT NOT NULL,
    "title_en" TEXT,
    "person_name" TEXT,
    "avatar_url" TEXT,
    "order" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "organization_nodes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "company_histories" (
    "id" TEXT NOT NULL,
    "year" INTEGER NOT NULL,
    "title_vi" TEXT NOT NULL,
    "title_en" TEXT,
    "content_vi" TEXT NOT NULL,
    "content_en" TEXT,
    "image_url" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "company_histories_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ceo_messages" (
    "id" TEXT NOT NULL,
    "ceo_name" TEXT NOT NULL,
    "ceo_title_vi" TEXT NOT NULL,
    "ceo_title_en" TEXT,
    "content_vi" TEXT NOT NULL,
    "content_en" TEXT,
    "avatar_url" TEXT,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ceo_messages_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "partners" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "logo_url" TEXT NOT NULL,
    "website_url" TEXT,
    "type" "PartnerType" NOT NULL DEFAULT 'PARTNER',
    "order" INTEGER NOT NULL DEFAULT 0,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "partners_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "product_categories" (
    "id" TEXT NOT NULL,
    "name_vi" TEXT NOT NULL,
    "name_en" TEXT,
    "slug" TEXT NOT NULL,
    "category_type" "ProductCategoryType" NOT NULL,
    "order" INTEGER NOT NULL DEFAULT 0,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "product_categories_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "products" (
    "id" TEXT NOT NULL,
    "category_id" TEXT NOT NULL,
    "name_vi" TEXT NOT NULL,
    "name_en" TEXT,
    "slug" TEXT NOT NULL,
    "description_vi" TEXT NOT NULL,
    "description_en" TEXT,
    "thumbnail_url" TEXT,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "order" INTEGER NOT NULL DEFAULT 0,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "products_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "product_specs" (
    "id" TEXT NOT NULL,
    "product_id" TEXT NOT NULL,
    "label_vi" TEXT NOT NULL,
    "label_en" TEXT,
    "value_vi" TEXT NOT NULL,
    "value_en" TEXT,
    "order" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "product_specs_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "projects" (
    "id" TEXT NOT NULL,
    "name_vi" TEXT NOT NULL,
    "name_en" TEXT,
    "slug" TEXT NOT NULL,
    "client_name" TEXT,
    "year" INTEGER,
    "description_vi" TEXT NOT NULL,
    "description_en" TEXT,
    "thumbnail_url" TEXT,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "projects_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "solutions" (
    "id" TEXT NOT NULL,
    "field_type" "SolutionFieldType" NOT NULL,
    "title_vi" TEXT NOT NULL,
    "title_en" TEXT,
    "slug" TEXT NOT NULL,
    "content_vi" TEXT NOT NULL,
    "content_en" TEXT,
    "thumbnail_url" TEXT,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "order" INTEGER NOT NULL DEFAULT 0,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "solutions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "services" (
    "id" TEXT NOT NULL,
    "title_vi" TEXT NOT NULL,
    "title_en" TEXT,
    "slug" TEXT NOT NULL,
    "content_vi" TEXT NOT NULL,
    "content_en" TEXT,
    "icon_url" TEXT,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "order" INTEGER NOT NULL DEFAULT 0,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "services_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "news" (
    "id" TEXT NOT NULL,
    "author_id" TEXT NOT NULL,
    "category" "NewsCategory" NOT NULL,
    "title_vi" TEXT NOT NULL,
    "title_en" TEXT,
    "slug" TEXT NOT NULL,
    "content_vi" TEXT NOT NULL,
    "content_en" TEXT,
    "thumbnail_url" TEXT,
    "is_published" BOOLEAN NOT NULL DEFAULT false,
    "published_at" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "news_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "contact_info" (
    "id" TEXT NOT NULL,
    "address_vi" TEXT NOT NULL,
    "address_en" TEXT,
    "phone" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "map_embed_url" TEXT,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "contact_info_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "contact_submissions" (
    "id" TEXT NOT NULL,
    "full_name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "phone" TEXT,
    "subject" TEXT,
    "message" TEXT NOT NULL,
    "is_read" BOOLEAN NOT NULL DEFAULT false,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "contact_submissions_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "users"("email");

-- CreateIndex
CREATE UNIQUE INDEX "company_intro_sections_type_key" ON "company_intro_sections"("type");

-- CreateIndex
CREATE UNIQUE INDEX "product_categories_slug_key" ON "product_categories"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "products_slug_key" ON "products"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "projects_slug_key" ON "projects"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "solutions_slug_key" ON "solutions"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "services_slug_key" ON "services"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "news_slug_key" ON "news"("slug");

-- AddForeignKey
ALTER TABLE "organization_nodes" ADD CONSTRAINT "organization_nodes_parent_id_fkey" FOREIGN KEY ("parent_id") REFERENCES "organization_nodes"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "products" ADD CONSTRAINT "products_category_id_fkey" FOREIGN KEY ("category_id") REFERENCES "product_categories"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "product_specs" ADD CONSTRAINT "product_specs_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "products"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "news" ADD CONSTRAINT "news_author_id_fkey" FOREIGN KEY ("author_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
