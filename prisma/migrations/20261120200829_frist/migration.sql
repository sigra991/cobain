-- CreateEnum
CREATE TYPE "Role" AS ENUM ('ADMIN', 'KETUA', 'PEGAWAI');

-- CreateEnum
CREATE TYPE "StatusEnum" AS ENUM ('PENDING', 'DIVERIFIKASI', 'DIPROSES', 'SELESAI', 'DITOLAK');

-- CreateTable
CREATE TABLE "users" (
    "id" SERIAL NOT NULL,
    "username" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "role" "Role" NOT NULL DEFAULT 'PEGAWAI',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "pegawai" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "nama" TEXT NOT NULL,
    "email" TEXT,
    "telepon" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "pegawai_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "clients" (
    "id" SERIAL NOT NULL,
    "nama_anak" TEXT NOT NULL,
    "nama_ortu" TEXT,
    "telepon" TEXT,
    "alamat" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "clients_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "status_client" (
    "id" SERIAL NOT NULL,
    "client_id" INTEGER NOT NULL,
    "pegawai_id" INTEGER NOT NULL,
    "status" "StatusEnum" NOT NULL DEFAULT 'PENDING',
    "keterangan" TEXT,
    "tanggal" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "status_client_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "users_username_key" ON "users"("username");

-- CreateIndex
CREATE UNIQUE INDEX "pegawai_user_id_key" ON "pegawai"("user_id");

-- AddForeignKey
ALTER TABLE "pegawai" ADD CONSTRAINT "pegawai_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "status_client" ADD CONSTRAINT "status_client_client_id_fkey" FOREIGN KEY ("client_id") REFERENCES "clients"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "status_client" ADD CONSTRAINT "status_client_pegawai_id_fkey" FOREIGN KEY ("pegawai_id") REFERENCES "pegawai"("id") ON DELETE CASCADE ON UPDATE CASCADE;
