import '../models/coding_task.dart';

const List<CodingTask> taskBank = [
  // ─── TUGAS 1: KALKULASI KASIR & ATURAN DISKON ───────────────────────────
  CodingTask(
    id: 'task_1',
    title: 'Kalkulator Kasir & Diskon 10%',
    difficulty: 'Mudah',
    scenario:
      'Pewawancara: "Buat fungsi di PHP bernama `hitungTotalKasir(\$items)`.\n'
      'Setiap item berupa associative array dengan key [\'harga\'] dan [\'jumlah\'].\n'
      'Jika total belanja melebihi Rp 100.000, berikan potongan diskon 10%.\n'
      'Kembalikan angka total akhir yang harus dibayar pembeli."',
    expectedPseudocode: [
      'LANGKAH 1: Inisialisasi variabel \$total = 0',
      'LANGKAH 2: Lakukan perulangan foreach untuk menjumlahkan (\$item[\'harga\'] * \$item[\'jumlah\'])',
      'LANGKAH 3: Cek kondisi if (\$total > 100000), hitung diskon 10% dan kurangkan',
      'LANGKAH 4: Return nilai \$total akhir',
    ],
    boilerplateCode:
'''<?php

function hitungTotalKasir(array \$items): float {
    // 1. Tulis pseudocode logikamu dulu di sini...
    // 2. Tulis kodenya di bawah komentar...
    
}
''',
    solutionCode:
'''<?php

function hitungTotalKasir(array \$items): float {
    // LANGKAH 1: Inisialisasi variabel total
    \$total = 0.0;

    // LANGKAH 2: Hitung subtotal setiap produk
    foreach (\$items as \$item) {
        // Validasi defensif: pastikan angka tidak negatif
        \$harga = max(0, (float) (\$item['harga'] ?? 0));
        \$jumlah = max(0, (int) (\$item['jumlah'] ?? 0));
        \$total += \$harga * \$jumlah;
    }

    // LANGKAH 3: Kondisi diskon 10% jika di atas Rp 100.000
    if (\$total > 100000) {
        \$diskon = \$total * 0.10;
        \$total -= \$diskon;
    }

    // LANGKAH 4: Kembalikan total akhir
    return \$total;
}
''',
    interviewerSpeechScript:
      '"Pertama saya inisialisasi variabel accumulator `\$total = 0.0`. '
      'Kemudian saya lakukan looping foreach pada `\$items` dan menghitung subtotal perkalian harga dan kuantitas. '
      'Saya tambahkan pengaman defensif menggunakan `?? 0` agar kode tidak memicu PHP Warning jika ada key array yang hilang. '
      'Terakhir, saya evaluasi apakah total melebihi seratus ribu; jika ya, kurangkan diskon 10% lalu kembalikan totalnya."',
    defensiveEdgeCases: [
      'Data array kosong `[]`: langsung mengembalikan 0 tanpa error fatal.',
      'Key array hilang (undefined index) dicegah dengan null coalescing `??`.',
      'Kuantitas atau harga bernilai negatif dinormalisasi ke 0.',
    ],
    requiredSyntaxPatterns: [
      'function',
      'foreach',
      'if',
      'return',
    ],
    explanation:
      'Tugas ini menguji kebiasaan berpikir terstruktur: penanganan tipe data, loop, kondisional, dan defensive null handling.',
  ),

  // ─── TUGAS 2: TRANSAKSI SALDO ATOMIK (ACID DI LARAVEL) ───────────────────
  CodingTask(
    id: 'task_2',
    title: 'Transfer Saldo Antar User (Database ACID)',
    difficulty: 'Menengah',
    scenario:
      'Pewawancara: "Buat method di Laravel Service untuk transfer saldo dari User A ke User B sebesar nominal tertentu.\n'
      'Pastikan saldo pengirim cukup, kedua saldo ter-update, dan jika terjadi error di tengah jalan, uang tidak boleh hilang."',
    expectedPseudocode: [
      'LANGKAH 1: Validasi awal: nominal harus > 0',
      'LANGKAH 2: Buka transaksi database dengan DB::transaction()',
      'LANGKAH 3: Lock baris pengirim dengan lockForUpdate() dan cek kecukupan saldo',
      'LANGKAH 4: Kurangi saldo pengirim dan tambahkan saldo penerima',
      'LANGKAH 5: Buat riwayat mutasi transaksi',
      'LANGKAH 6: Otomatis commit jika sukses, atau lempar Exception agar rollback jika saldo kurang',
    ],
    boilerplateCode:
'''<?php

namespace App\\Services;

use Illuminate\\Support\\Facades\\DB;
use App\\Models\\User;
use Exception;

class TransferService {
    public function transfer(int \$fromId, int \$toId, float \$amount): bool {
        // Tulis logika transaksi aman di sini...

    }
}
''',
    solutionCode:
'''<?php

namespace App\\Services;

use Illuminate\\Support\\Facades\\DB;
use App\\Models\\User;
use Exception;

class TransferService {
    public function transfer(int \$fromId, int \$toId, float \$amount): bool {
        if (\$amount <= 0) {
            throw new Exception("Nominal transfer harus lebih dari 0.");
        }

        return DB::transaction(function () use (\$fromId, \$toId, \$amount) {
            // Pessimistic Locking untuk mencegah race condition
            \$sender = User::where('id', \$fromId)->lockForUpdate()->firstOrFail();
            \$receiver = User::where('id', \$toId)->lockForUpdate()->firstOrFail();

            if (\$sender->saldo < \$amount) {
                throw new Exception("Saldo pengirim tidak mencukupi.");
            }

            \$sender->decrement('saldo', \$amount);
            \$receiver->increment('saldo', \$amount);

            return true;
        });
    }
}
''',
    interviewerSpeechScript:
      '"Untuk transfer uang, integritas data adalah nomor satu. '
      'Saya membungkus seluruh alur dalam `DB::transaction()` closure. '
      'Selain itu, saya menggunakan Pessimistic Locking via `lockForUpdate()` agar tidak terjadi double-spending jika user menekan tombol transfer dua kali dengan cepat. '
      'Jika saldo kurang, saya melempar Exception sehingga transaksi otomatis di-rollback oleh Laravel."',
    defensiveEdgeCases: [
      'Nominal negatif atau 0 dicegah di awal fungsi.',
      'Race condition dicegah dengan `lockForUpdate()`.',
      'Rollback otomatis terjadi jika query increment penerima gagal.',
    ],
    requiredSyntaxPatterns: [
      'DB::transaction',
      'decrement',
      'increment',
      'throw',
    ],
    explanation:
      'Menunjukkan kamu bukan sekadar membuat fitur berjalan, tetapi memahami keamanan transaksi keuangan di level basis data.',
  ),

  // ─── TUGAS 3: REFACTOR N+1 QUERY DI LARAVEL CONTROLLER ───────────────────
  CodingTask(
    id: 'task_3',
    title: 'Optimasi N+1 Query pada Daftar Transaksi',
    difficulty: 'Menengah',
    scenario:
      'Pewawancara: "Lihat kode controller ini:\n'
      '  \$orders = Order::all();\n'
      '  // Di blade: \$order->customer->nama dan \$order->items->count()\n'
      'Apa masalah performa di sini dan bagaimana cara memperbaikinya?"',
    expectedPseudocode: [
      'LANGKAH 1: Identifikasi masalah N+1 Query: `Order::all()` memicu query tambahan setiap pemanggilan relasi di blade',
      'LANGKAH 2: Ganti `all()` dengan Eager Loading `with([\'customer\', \'items\'])`',
      'LANGKAH 3: Opsional: ganti `items->count()` dengan `withCount(\'items\')` agar query lebih ringan',
    ],
    boilerplateCode:
'''<?php

// Tuliskan method controller yang sudah diperbaiki di sini:
public function index() {
    
}
''',
    solutionCode:
'''<?php

namespace App\\Http\\Controllers;

use App\\Models\\Order;
use Illuminate\\View\\View;

class OrderController extends Controller 
{
    public function index(): View 
    {
        // SOLUSI: Menggunakan Eager Loading untuk customer dan withCount untuk menghitung items
        \$orders = Order::query()
            ->with(['customer:id,nama,email']) // hanya ambil kolom yang dibutuhkan
            ->withCount('items')                // menghitung items langsung di database SQL
            ->latest()                          // urutkan dari yang terbaru
            ->paginate(20);                     // batasi dengan paginasi

        return view('orders.index', compact('orders'));
    }
}
''',
    interviewerSpeechScript:
      '"Masalah pada kode awal adalah N+1 Query. Jika ada 100 order, Laravel akan menjalankan 1 query awal, lalu 100 query untuk mengambil customer, dan 100 query lagi untuk items—total 201 query!\n'
      'Perbaikan yang saya lakukan:\n'
      '1. Menerapkan Eager Loading via `with([\'customer\'])` sehingga relasi diambil di awal hanya dengan 1 query WHERE IN.\n'
      '2. Memakai `withCount(\'items\')` daripada memuat semua model item hanya untuk dihitung jumlahnya.\n'
      '3. Menambahkan paginasi `paginate(20)` agar server tidak kehabisan memori saat transaksi mencapai ribuan."',
    defensiveEdgeCases: [
      'Gunakan spesifik kolom pada eager loading, misal `customer:id,nama` untuk menghemat alokasi memori RAM PHP.',
      'Gunakan paginasi (`paginate()`) daripada `get()` membabi buta.',
    ],
    requiredSyntaxPatterns: [
      'with',
      'order',
      'compact',
      'return',
    ],
    explanation:
      'Pertanyaan wajib untuk kandidat Backend Laravel. Menunjukkan bahwa kamu peduli pada skalabilitas performa query database di server produksi.',
  ),

  // ─── TUGAS 4: REVERSE STRING TANPA BUILT-IN FUNCTION ────────────────────
  CodingTask(
    id: 'task_4',
    title: 'Pembalik Kata (Reverse String) Tanpa strrev()',
    difficulty: 'Tantangan',
    scenario:
      'Pewawancara: "Buat fungsi `balikKata(\$teks)` yang membalikkan urutan huruf dari sebuah string tanpa menggunakan fungsi bawaan `strrev()`.\n'
      'Contoh: input \'LARAVEL\' -> output \'LEVARAL\'."',
    expectedPseudocode: [
      'LANGKAH 1: Cari panjang string dengan strlen(\$teks)',
      'LANGKAH 2: Inisialisasi string kosong \$hasil = ""',
      'LANGKAH 3: Lakukan perulangan mundur dari index terakhir (panjang - 1) sampai index 0',
      'LANGKAH 4: Gabungkan karakter tiap index ke variabel \$hasil',
      'LANGKAH 5: Return \$hasil',
    ],
    boilerplateCode:
'''<?php

function balikKata(string \$teks): string {
    // Jangan gunakan strrev(). Tulis logika algoritmamu di sini...

}
''',
    solutionCode:
'''<?php

function balikKata(string \$teks): string {
    \$panjang = strlen(\$teks);
    \$hasil = '';

    // Loop mundur dari karakter terakhir ke pertama
    for (\$i = \$panjang - 1; \$i >= 0; \$i--) {
        \$hasil .= \$teks[\$i];
    }

    return \$hasil;
}
''',
    interviewerSpeechScript:
      '"Karena tidak boleh menggunakan `strrev()`, logikanya adalah kita membaca string tersebut dari karakter paling belakang ke paling depan. '
      'Kita ambil panjang string menggunakan `strlen`, lalu buat perulangan `for` mundur dengan decrement \$i--, dan merangkai karakternya satu per satu ke string penampung."',
    defensiveEdgeCases: [
      'String kosong `""`: panjang 0, loop tidak jalan, return string kosong (aman).',
      'String 1 huruf: langsung return huruf tersebut (aman).',
    ],
    requiredSyntaxPatterns: [
      'function',
      'strlen',
      'for',
      'return',
    ],
    explanation:
      'Tes algoritma klasik untuk menguji apakah kamu memahami konsep manipulasi string sebagai array karakter dan kontrol indeks perulangan.',
  ),

  // ─── TUGAS 5: SANITASI NOMOR WHATSAPP INDONESIA ─────────────────────────
  CodingTask(
    id: 'task_5',
    title: 'Sanitasi & Format Nomor WhatsApp (+62 / 08 / 62)',
    difficulty: 'Mudah',
    scenario:
      'Pewawancara: "User sering menginput nomor WhatsApp dengan format acak-acakan: \'0812-3456-7890\', \'+62 812 3456 7890\', atau \'6281234567890\'.\n'
      'Buat fungsi `formatNomorWA(\$nomor)` di PHP yang membersihkan karakter non-angka dan mengubahnya menjadi format standar internasional `628...`."',
    expectedPseudocode: [
      'LANGKAH 1: Hapus semua karakter selain angka menggunakan preg_replace("/\\D/", "", \$nomor)',
      'LANGKAH 2: Cek awalan nomor:',
      '  - Jika berawalan "08", ganti digit "0" di awal menjadi "62"',
      '  - Jika sudah berawalan "628", biarkan tetap',
      'LANGKAH 3: Validasi panjang nomor wajar (10 - 15 digit)',
      'LANGKAH 4: Kembalikan string nomor bersih',
    ],
    boilerplateCode:
'''<?php

function formatNomorWA(string \$nomor): string {
    // 1. Bersihkan karakter non-angka...
    // 2. Format awalan menjadi 628...

}
''',
    solutionCode:
'''<?php

function formatNomorWA(string \$nomor): string {
    // 1. Bersihkan semua spasi, strip, tanda plus, tanda kurung
    \$clean = preg_replace('/\\D/', '', \$nomor);

    // 2. Jika berawalan 0, ubah menjadi 62 (contoh: 0812 -> 62812)
    if (str_starts_with(\$clean, '0')) {
        \$clean = '62' . substr(\$clean, 1);
    }

    // 3. Kembalikan format nomor yang sudah terstandar
    return \$clean;
}
''',
    interviewerSpeechScript:
      '"Untuk integrasi WhatsApp Gateway seperti Fonnte atau Wablas, nomor harus berformat kode negara 62 tanpa tanda plus atau strip. '
      'Langkah pertama saya menghapus semua karakter non-digit menggunakan regex `preg_replace`. '
      'Kemudian saya memeriksa apakah string berawalan \'0\'; jika iya, saya ganti digit nol tersebut dengan kode negara \'62\'. '
      'Dengan begitu, semua variasi input user menjadi seragam dan siap dikirim."',
    defensiveEdgeCases: [
      'Input mengandung spasi dan simbol seperti "+62 812-3456-7890" otomatis bersih.',
      'Nomor yang sudah berawalan 628 tidak diubah dua kali (idempotent).',
    ],
    requiredSyntaxPatterns: [
      'function',
      'preg_replace',
      'substr',
      'return',
    ],
    explanation:
      'Tugas live coding praktis yang sangat sering diujikan di perusahaan e-commerce, POS kasir, atau agensi software lokal Indonesia.',
  ),

  // ─── TUGAS 6: PENCARI PASANGAN TARGET (TWO SUM) ──────────────────────────
  CodingTask(
    id: 'task_6',
    title: 'Two Sum (Pencari Pasangan Saldo Target) O(N)',
    difficulty: 'Menengah',
    scenario:
      'Pewawancara: "Diberikan array nominal transaksi `\$transaksi` dan sebuah target saldo `\$target`.\n'
      'Temukan dan kembalikan dua angka dari array tersebut yang jika dijumlahkan menghasilkan nilai `\$target` tepat.\n'
      'Gunakan pendekatan efisien O(N) dengan bantuan Map/Associative Array, bukan brute force loop bersarang O(N²)."',
    expectedPseudocode: [
      'LANGKAH 1: Siapkan associative array kosong \$seen = [] untuk menyimpan angka yang sudah lewat',
      'LANGKAH 2: Loop setiap elemen \$angka di dalam \$transaksi',
      'LANGKAH 3: Hitung selisih \$sisa = \$target - \$angka',
      'LANGKAH 4: Jika \$sisa sudah ada di dalam \$seen (isset(\$seen[\$sisa])), kita menemukan pasangannya! Return [\$sisa, \$angka]',
      'LANGKAH 5: Simpan \$seen[\$angka] = true lalu lanjutkan loop',
      'LANGKAH 6: Jika tidak ada pasangan ditemukan, return array kosong []',
    ],
    boilerplateCode:
'''<?php

function cariPasangan(array \$transaksi, int \$target): array {
    // Tulis algoritma Two Sum O(N) dengan associative array di sini:

}
''',
    solutionCode:
'''<?php

function cariPasangan(array \$transaksi, int \$target): array {
    \$seen = []; // Hash map lookup O(1)

    foreach (\$transaksi as \$angka) {
        \$sisa = \$target - \$angka;

        // Cek apakah angka komplementernya sudah pernah kita lewati sebelumnya
        if (isset(\$seen[\$sisa])) {
            return [\$sisa, \$angka];
        }

        // Tandai angka saat ini ke dalam hash map
        \$seen[\$angka] = true;
    }

    return []; // Tidak ditemukan pasangan
}
''',
    interviewerSpeechScript:
      '"Pendekatan brute force menggunakan nested loop for di dalam for memiliki kompleksitas waktu O(N²), yang akan sangat lambat jika transaksi mencapai ribuan. '
      'Oleh karena itu, saya mengoptimalkannya menjadi O(N) waktu dan O(N) ruang menggunakan Hash Map (associative array di PHP). '
      'Di setiap iterasi, kita hitung selisihnya (\$target - \$angka). Jika selisih tersebut sudah ada di Map via `isset()`, kita langsung menemukan pasangannya dalam lookup O(1)."',
    defensiveEdgeCases: [
      'Array kosong atau kurang dari 2 elemen: langsung return [] tanpa error.',
      'Target berupa angka negatif atau nol tetap tertangani dengan benar secara matematis.',
    ],
    requiredSyntaxPatterns: [
      'function',
      'foreach',
      'isset',
      'return',
    ],
    explanation:
      'Soal algoritma paling legendaris dalam wawancara kerja software engineer dunia. Menunjukkan bahwa kamu paham efisiensi kompleksitas waktu Big-O.',
  ),
];
