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
      '"Baik Pak/Bu, sebelum saya menulis kodenya, saya jelaskan alurnya terlebih dahulu:\n'
      '1. Pertama, saya inisialisasi penampung total senilai 0.\n'
      '2. Kedua, saya gunakan perulangan foreach untuk mengalikan harga dengan kuantitas tiap item.\n'
      '3. Ketiga, saya buat validasi kondisi if untuk memeriksa apakah totalnya tembus ambang batas 100 ribu untuk mendapatkan diskon 10%.\n'
      '4. Terakhir, saya kembalikan total akhirnya. Saya mulai ketik implementasinya sekarang ya, Pak/Bu."',
    defensiveEdgeCases: [
      'Bagaimana jika array \$items kosong? (Fungsi harus tetap aman mengembalikan 0)',
      'Bagaimana jika harga atau jumlah bernilai negatif atau string? (Gunakan casting dan fungsi `max(0, ...)`))',
      'Bagaimana jika key array tidak ada? (Gunakan null coalescing `?? 0`)',
    ],
    requiredSyntaxPatterns: [
      'function',
      'foreach',
      '100000',
      '0.1',
      'return',
    ],
    explanation:
      'Tugas ini menguji apakah kamu memahami struktur dasar perulangan array, kalkulasi aritmatika, dan penulisan kondisi logika `if`. '
      'Menambahkan validasi angka nol/negatif akan langsung membuatmu dinilai sebagai developer yang matang.',
  ),

  // ─── TUGAS 2: FILTER STOK HABIS & SORTING ────────────────────────────────
  CodingTask(
    id: 'task_2',
    title: 'Filter Produk Stok Habis (Out of Stock)',
    difficulty: 'Menengah',
    scenario:
      'Pewawancara: "Diberikan kumpulan data produk di toko Warung Lupi.\n'
      'Buat fungsi `filterProdukHabis(\$daftarProduk)` yang hanya mengembalikan produk dengan stok sama dengan 0.\n'
      'Pastikan fungsi mengembalikan array baru tanpa merusak data asli."',
    expectedPseudocode: [
      'LANGKAH 1: Siapkan array kosong \$produkHabis = []',
      'LANGKAH 2: Loop setiap produk dari \$daftarProduk',
      'LANGKAH 3: Cek kondisi if (\$produk[\'stok\'] === 0)',
      'LANGKAH 4: Masukkan produk tersebut ke dalam array \$produkHabis',
      'LANGKAH 5: Return array \$produkHabis',
    ],
    boilerplateCode:
'''<?php

function filterProdukHabis(array \$daftarProduk): array {
    // Tulis pseudocode dan logika kodinganmu di sini...

}
''',
    solutionCode:
'''<?php

function filterProdukHabis(array \$daftarProduk): array {
    // Cara 1: Menggunakan array_filter (fungsional & bersih)
    return array_values(array_filter(\$daftarProduk, function (\$produk) {
        return isset(\$produk['stok']) && (int) \$produk['stok'] === 0;
    }));

    /* Atau Cara 2: Menggunakan foreach konvensional
    \$hasil = [];
    foreach (\$daftarProduk as \$p) {
        if (isset(\$p['stok']) && (int) \$p['stok'] === 0) {
            \$hasil[] = \$p;
        }
    }
    return \$hasil;
    */
}
''',
    interviewerSpeechScript:
      '"Untuk memfilter array ini, ada dua pendekatan Pak/Bu: bisa menggunakan looping konvensional atau memanfaatkan fungsi bawaan `array_filter`. '
      'Saya akan menggunakan `array_filter` dengan pengecekan strict tipe data `=== 0` dan membungkusnya dengan `array_values` agar index array-nya rapi kembali dari 0."',
    defensiveEdgeCases: [
      'Gunakan `=== 0` dengan casting `(int)` agar string "0" atau angka 0 tidak rancu dengan `null` atau `false`.',
      'Panggil `array_values()` jika memakai `array_filter` agar index array numerik tidak berlubang saat di-serialize ke JSON response.',
    ],
    requiredSyntaxPatterns: [
      'function',
      'stok',
      '=== 0',
      'return',
    ],
    explanation:
      'Menguji pemahaman manipulasi array di PHP dan perbedaan antara modifikasi data in-place vs menghasilkan data baru (immutable approach).',
  ),

  // ─── TUGAS 3: REFACTOR BUG N+1 QUERY DI CONTROLLER ──────────────────────
  CodingTask(
    id: 'task_3',
    title: 'Refactor Bug N+1 Query di Laravel',
    difficulty: 'Menengah',
    scenario:
      'Pewawancara: "Perhatikan kode Laravel Controller berikut:\n\n'
      'public function index() {\n'
      '    \$orders = Order::all();\n'
      '    return view(\'orders.index\', compact(\'orders\'));\n'
      '}\n\n'
      'Di file blade-nya ada perulangan yang menampilkan: `\$order->customer->nama` dan `\$order->items->count()`.\n'
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
];
