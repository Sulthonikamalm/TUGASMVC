Berikut versi **plain text (.txt)** siap copy tanpa formatting Markdown:

---

MVC Product App — Tugas Praktik PBO (Pemrograman Berorientasi Objek)

Repositori ini merupakan hasil pengerjaan Tugas Praktik Penerapan Pola Arsitektur MVC (Model–View–Controller) pada mata kuliah Pemrograman Berorientasi Objek (PBO).

Aplikasi dibangun menggunakan Java Servlet (Controller), JSP (View), dan POJO (Model) dengan penyimpanan in-memory (tanpa database fisik). Fokus utama proyek ini adalah penerapan konsep Object-Oriented Programming, Enkapsulasi, dan Separation of Concerns, serta penanganan request HTTP & validasi server-side secara ketat.

---

## TEKNOLOGI YANG DIGUNAKAN

Bahasa Pemrograman : Java (JDK 22)
Framework/Platform : Jakarta EE 10 (Servlet & JSP)
Server             : Apache Tomcat 10.1
IDE                : Apache NetBeans 22
Build Tool         : Maven
Frontend           : HTML + CSS (Custom "Clean Dashboard")

Catatan penting:
Karena menggunakan Tomcat 10, seluruh library servlet berbasis javax.servlet sudah dimigrasi ke jakarta.servlet. Menjalankan project ini di Tomcat 9 ke bawah akan menyebabkan error.

---

## STRUKTUR PROYEK & IMPLEMENTASI MVC

controllers/

* ProductServlet.java   → Routing /product, memproses form, validasi, passing data ke view
* HomeServlet.java      → Controller untuk halaman dashboard

models/

* Product.java          → POJO entitas produk
* ProductRepository.java → CRUD in-memory menggunakan List

views (JSP)/

* home.jsp             → Dashboard dengan branding TUGASMVCSULTHONIKA
* list_product.jsp     → Tabel produk + fitur pencarian
* form_product.jsp     → Form input/edit + alert error + retain input value

---

## PEMENUHAN POIN TUGAS

1. Validasi Server-Side

   * Dibuat method validateProductInput() pada ProductServlet untuk memastikan:

     * Nama & Kategori tidak kosong
     * Harga & Stok tidak bernilai negatif
   * Method dipanggil sebelum proses penyimpanan (doPost)

2. Penanganan Error di JSP

   * Jika terjadi error, Servlet mengirim atribut "error"
   * JSP menampilkan alert merah tanpa menghapus input
   * Retain value contoh:
     value="<%= product.getName() != null ? product.getName() : "" %>"

3. Perbaikan Bug & Peningkatan Fitur

   * Input Kategori diubah menjadi dropdown agar konsisten (bukan text bebas)
   * Semua JSP menggunakan UTF-8 untuk mencegah karakter error
   * CSS custom tema Merah-Abu untuk tampilan dashboard modern

---

## PERSYARATAN INSTALASI

• JDK 17 atau 22 wajib terpasang
• Apache Tomcat 10.1 wajib (karena Jakarta Servlet)
• Apache NetBeans 22
• Tomcat harus ter-registrasi di NetBeans dengan username & password manager-gui

---

## CARA MENJALANKAN

1. Clone repository
2. Buka NetBeans → Tools → Servers → Add Server → pilih Apache Tomcat
3. Masukkan lokasi instalasi Tomcat 10.1 + username/password manager-gui
4. File → Open Project → pilih folder MVCProductApp
5. Tunggu scanning Maven selesai
6. Klik kanan project → Run (atau tekan F6)
7. Aplikasi akan terbuka di browser:
   [http://localhost:8080/MVCProductApp](http://localhost:8080/MVCProductApp)

---

## INFORMASI

Project ini dibuat untuk memenuhi tugas Mata Kuliah Pemrograman Berorientasi Objek (PBO).

Created by: Sulthonika
