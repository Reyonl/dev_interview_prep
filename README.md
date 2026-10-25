# DevInterview Prep 🚀

Aplikasi simulasi wawancara kerja & latihan live coding interaktif untuk Software Engineer (khususnya Backend Laravel, PHP, Database MySQL, Arsitektur Sistem, Keamanan Web, dan Fullstack Web/Mobile). Didesain **Offline-First Murni** tanpa perlu koneksi internet atau API key.

Dibuat untuk membantu developer dan fresh graduate mengatasi rasa cemas, melatih alur berpikir terstruktur (pseudocode), membiasakan komunikasi verbal yang elegan di hadapan pewawancara teknis, serta melatih kesiapan mental di bawah tekanan waktu (*timer mock interview*).

---

## ✨ Fitur Utama

### 1. Simulasi Tanya Jawab Berbobot & Koreksi Instan (7 Kategori)
* **Kategori Komprehensif:**
  * **HR & Behavioral:** *Elevator Pitch 90 detik, cara menjawab kelemahan tanpa dicap malas, alur kerja AI-assisted/vibe coding, hingga resolusi konflik kerja.*
  * **Core PHP & OOP:** *Perbedaan `==` vs `===` (Type Juggling), exception handling `try-catch`, dan pilar OOP.*
  * **Laravel Framework:** *Siklus Request Lifecycle, optimasi performa **N+1 Query** via Eager Loading `with()`, FormRequest vs controller validation, dan proteksi Mass Assignment `$fillable`.*
  * **Database & SQL:** *Prinsip Indexing (B-Tree vs Full Table Scan), transaksi ACID untuk integritas saldo/kasir, dan relasi multi-tabel.*
  * **Git & Workflow:** *Penyelesaian Merge Conflict di tim, pencegahan direct commit ke main, dan Feature-Branch workflow.*
  * **System Design & Scale:** *Pola Caching Cache-Aside via Redis (TTL & Invalidation), dan Asynchronous Queue Worker untuk proses berat (Email SMTP & render PDF).*
  * **Web & API Security:** *Pencegahan SQL Injection via Prepared Statements PDO, mitigasi CSRF/XSS, dan Slow Adaptive KDF (Bcrypt/Argon2id) vs fast hash MD5.*
* **Koreksi Langsung:**
  * Memberitahu secara spesifik kenapa pilihan jawaban yang keliru merupakan *jebakan pemula (red-flag)*.
  * Menampilkan **Naskah Jawaban Ideal** yang disukai interviewer.
  * Dilengkapi **Tips Senior Developer** untuk memberikan nilai tambah teknis.

### 2. Mode Simulasi Ujian Realistis (Mock Interview Exam) ⏱️
* **Pengalaman Ujian Sebenarnya:** 10 pertanyaan acak lintas kategori.
* **Batas Waktu Per Soal:** Hitung mundur 60 detik per soal dengan progress bar interaktif (hijau, kuning, merah) dan auto-submit saat timeout.
* **Laporan Evaluasi Lengkap:** Skor akurasi (0 - 100%), status kelulusan (Siap Tempur / Perlu Polesan), total durasi pengerjaan, dan review detail.

### 3. Audio Voice Interviewer (Text-To-Speech) 🎙️
* Didukung engine TTS lokal tanpa kuota internet.
* **Pembacaan Soal Otomatis:** Interviewer membacakan pertanyaan langsung ke telinga pengguna (bisa diatur ON/OFF).
* **Audio Naskah Verbal:** Memutar audio naskah jawaban ideal dan narasi live coding agar kandidat terbiasa dengan pelafalan istilah teknis.

### 4. Live Coding & Pseudocode Lab (Tugas Praktik Interaktif)
Melatih alur kerja live coding 2 tahap:
* **Tugas Praktis Industri:**
  * *Kalkulator Kasir & Diskon 10%*
  * *Transfer Saldo Atomik (ACID DB Transaction di Laravel)*
  * *Optimasi N+1 Query pada Daftar Transaksi (Eager Loading)*
  * *Pembalik Kata (Reverse String) Tanpa Built-in Function*
  * *Sanitasi Format Nomor WhatsApp Indonesia (+62 / 08 / 62)*
  * *Two Sum (Pencari Pasangan Target) Efisien O(N) Hash Map*
* **Tab 1: Alur & Naskah Ucapan**
  * **Tahap Logika (Pseudocode):** Panduan poin-poin komentar yang harus diketik di layar sebelum menulis baris kode (dapat disisipkan ke editor dengan 1 klik).
  * **Naskah yang Kamu Ucapkan ke Interviewer:** Skrip percakapan persis yang bisa kamu ucapkan ke interviewer saat mulai coding.
  * **Kasus Batas (Defensive Edge Cases):** Pengecekan ekstra (angka negatif, string kosong, null coalescing) yang membuat interviewer terkesan.
* **Tab 2: Live Code Editor & Evaluasi Mandiri**
  * Tulis kodenya langsung di editor monospace bawaan aplikasi.
  * **Evaluasi Otomatis:** Memeriksa struktur logika, pola algoritma, dan fungsi kunci.
  * **Solusi Bersih Senior Developer:** Menampilkan implementasi kode standar industri yang bersih dan optimal.

### 5. Readiness Index Dashboard & App Launcher Icon
* Menghitung persentase kesiapan wawancara (0% – 100%) secara *real-time*.
* Riwayat skor tersimpan otomatis di perangkat lokal (*local persistence* via SharedPreferences).
* Dilengkapi **App Icon Resmi Bertema Developer Dark Aesthetic** di Android (Adaptive Icon), Web (PWA & Favicon), dan Windows (`.ico`).

---

## 🛠️ Tech Stack & Arsitektur

* **Framework:** Flutter 3.47+ (Dart 3)
* **UI Style:** Material 3 Dark Developer Aesthetic (Midnight Slate `#090D16`, Accent Amber `#FF8A3D`, Emerald `#10B981`)
* **State Management & Persistence:** `ChangeNotifier` + `shared_preferences`
* **Audio Engine:** `flutter_tts` (Offline native speech synthesis)
* **Platforms:** Android, Windows Desktop, Web (Chrome & Edge)
* **Automated Testing:** 100% Passing Unit & Widget Tests (10 automated tests)

---

## 🚀 Menjalankan Aplikasi di Lokal

### Prasyarat:
* Flutter SDK (3.47+)
* Dart SDK (3.13+)

### Langkah:
```bash
# Clone repositori
git clone https://github.com/Reyonl/dev_interview_prep.git
cd dev_interview_prep

# Pasang dependensi
flutter pub get

# Jalankan pengujian & verifikasi kualitas
dart analyze lib test
flutter test

# Jalankan di Web (Chrome)
flutter run -d chrome

# Jalankan di Windows Desktop
flutter run -d windows

# Jalankan di HP Android (Hubungkan via USB Debugging)
flutter run
```

---

## 📦 Build APK & CI/CD GitHub Actions

Repositori ini dilengkapi alur otomatisasi GitHub Actions:
* **`.github/workflows/flutter-ci.yml`**: Setiap ada *push* ke branch `main`, GitHub Actions otomatis menjalankan analisis kode statis (`flutter analyze`), unit test (`flutter test`), dan meng-compile **Release APK** yang bisa langsung diunduh dari tab **Actions Artifacts**.
* **`.github/workflows/release.yml`**: Setiap *push tag* versi (contoh: `v1.0.0`), GitHub Actions otomatis menerbitkan **GitHub Release** dengan file APK siap install.

---

## 👨‍💻 Author

**Reyon Lau Jiemin**  
* Informatics Engineering Graduate (GPA 3.56) · BNSP Certified Web Programmer  
* GitHub: [@Reyonl](https://github.com/Reyonl)  
* Portfolio: [Reyonl/portofolio-v2](https://github.com/Reyonl/portofolio-v2)
