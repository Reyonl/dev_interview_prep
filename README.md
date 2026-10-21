# DevInterview Prep 🚀

Aplikasi simulasi wawancara kerja & latihan live coding interaktif untuk Software Engineer (khususnya Backend Laravel, PHP, Database MySQL, dan Fullstack Web/Mobile). Didesain **Offline-First Murni** tanpa perlu koneksi internet atau API key.

Dibuat untuk membantu developer dan fresh graduate mengatasi rasa cemas, melatih alur berpikir terstruktur (pseudocode), serta membiasakan komunikasi verbal yang elegan di hadapan pewawancara teknis.

---

## ✨ Fitur Utama

### 1. Simulasi Tanya Jawab Berbobot & Koreksi Instan
* **Kategori Komprehensif:**
  * **HR & Behavioral:** *Elevator Pitch 90 detik, cara menjawab kelemahan tanpa dicap malas, alur kerja AI-assisted/vibe coding, hingga resolusi konflik kerja.*
  * **Core PHP & OOP:** *Perbedaan `==` vs `===` (Type Juggling), exception handling `try-catch`, dan pilar OOP.*
  * **Laravel Framework:** *Siklus Request Lifecycle, optimasi performa **N+1 Query** via Eager Loading `with()`, FormRequest vs controller validation, dan proteksi Mass Assignment `$fillable`.*
  * **Database & SQL:** *Prinsip Indexing (B-Tree vs Full Table Scan), transaksi ACID untuk integritas saldo/kasir, dan relasi multi-tabel.*
  * **Git & Workflow:** *Penyelesaian Merge Conflict di tim dan Feature-Branch workflow.*
* **Koreksi Langsung:**
  * Memberitahu secara spesifik kenapa pilihan jawaban yang keliru merupakan *jebakan pemula (red-flag)*.
  * Menampilkan **Naskah Jawaban Ideal** yang disukai interviewer.
  * Dilengkapi **Tips Senior Developer** untuk memberikan nilai tambah teknis.

### 2. Live Coding & Pseudocode Lab (Tugas Praktik Interaktif)
Melatih alur kerja live coding 2 tahap:
* **Tab 1: Alur & Naskah Ucapan**
  * **Tahap Logika (Pseudocode):** Panduan poin-poin komentar yang harus diketik di layar sebelum menulis baris kode (dapat disisipkan ke editor dengan 1 klik).
  * **Naskah yang Kamu Ucapkan ke Interviewer:** Skrip percakapan persis yang bisa kamu ucapkan ke interviewer saat mulai coding.
  * **Kasus Batas (Defensive Edge Cases):** Pengecekan ekstra (angka negatif, string kosong, null coalescing) yang membuat interviewer terkesan.
* **Tab 2: Live Code Editor & Evaluasi Mandiri**
  * Tulis kodenya langsung di editor monospace bawaan aplikasi.
  * **Evaluasi Otomatis:** Memeriksa struktur logika, pola algoritma, dan fungsi kunci.
  * **Solusi Bersih Senior Developer:** Menampilkan implementasi kode standar industri yang bersih dan optimal.

### 3. Readiness Index Dashboard
* Menghitung persentase kesiapan wawancara (0% – 100%) secara *real-time*.
* Riwayat skor tersimpan otomatis di perangkat lokal (*local persistence* via SharedPreferences).

---

## 🛠️ Tech Stack & Arsitektur

* **Framework:** Flutter 3.47+ (Dart 3)
* **UI Style:** Material 3 Dark Developer Aesthetic (Midnight Slate `#090D16`, Accent Amber `#FF8A3D`, Emerald `#10B981`)
* **State Management & Persistence:** `ChangeNotifier` + `shared_preferences`
* **Platforms:** Android, Windows Desktop, Web (Chrome & Edge)
* **Automated Testing:** 100% Passing Unit & Widget Tests

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
