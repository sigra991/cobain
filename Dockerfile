# 1. Gunakan Node.js 26 versi Alpine yang ringan
FROM node:26-alpine

# 2. Instal OpenSSL agar mesin Prisma ORM bisa berjalan lancar di Alpine Linux
RUN apk add --no-cache openssl

# 3. Buat dan masuk ke folder kerja '/backend' di dalam container
WORKDIR /backend

# 4. Salin package.json dan folder prisma terlebih dahulu
COPY package*.json ./
COPY prisma ./prisma/

# 5. Instal seluruh dependensi (Prisma CLI dibutuhkan saat tahap build untuk generate client)
RUN npm install

# 6. Buat kode Prisma Client di dalam container
RUN npx prisma generate

# 7. Salin seluruh sisa kode aplikasi Express dari laptop ke container
COPY . .

# 8. Buka jalur port 5000
EXPOSE 5000

# 9. Jalankan migrasi database otomatis (opsional), lalu nyalakan server Express
CMD ["node index.js"]
