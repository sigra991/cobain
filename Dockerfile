# 1. Gunakan Node.js 26 versi Slim (Debian) yang sudah memiliki OpenSSL bawaan
FROM node:26-slim

# 2. Buat dan masuk ke folder kerja '/backend' di dalam container
WORKDIR /backend

# 3. Salin package.json dan folder prisma terlebih dahulu
COPY package*.json ./
COPY prisma ./prisma/

# 4. Instal seluruh dependensi
RUN npm install

# 5. Buat kode Prisma Client di dalam container
RUN npx prisma generate

# 6. Salin seluruh sisa kode aplikasi Express ke container
COPY . .

# 7. Buka jalur port 5000
EXPOSE 5000

# 8. Nyalakan server Express
CMD ["node", "server.js"]
