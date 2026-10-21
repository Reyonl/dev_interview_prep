import '../models/question.dart';

const List<Question> questionBank = [
  // ─── 1. HR & BEHAVIORAL ──────────────────────────────────────────────────
  Question(
    id: 'hr_1',
    category: QuestionCategory.hr,
    question: 'Pewawancara: "Halo Reyon, silakan perkenalkan diri kamu secara singkat."',
    whyAsked: 'Melihat kemampuan komunikasi, struktur berpikir, dan keselarasan profil dengan posisi yang dilamar.',
    options: [
      'Menyebutkan nama, hobi, alamat lengkap sesuai KTP, dan membacakan riwayat sekolah dari SD hingga kuliah.',
      'Menjelaskan formula "Masa Lalu (Pendidikan & BNSP) -> Proyek Nyata (Warung Lupi & DAILY.CO) -> Minat & Relevansi saat ini".',
      'Langsung bercerita bahwa kamu orang yang perfeksionis dan sangat butuh pekerjaan ini.',
      'Menjelaskan bahwa kamu belum punya pengalaman apa-apa tapi siap belajar dari nol.',
    ],
    correctOptionIndex: 1,
    idealAnswer:
      'Gunakan elevator pitch 90 detik:\n'
      '"Nama saya Reyon Lau Jiemin, lulusan S1 Teknik Informatika Unpam (IPK 3,56) dengan sertifikasi BNSP Web Programmer. '
      'Fokus saya di backend Laravel/PHP & Flutter. Saya sudah membangun proyek nyata seperti Warung Lupi (REST API + printer Bluetooth) '
      'dan DAILY.CO (46 automated tests). Sebelumnya saya juga magang di Pusdiklat BPS sebagai Database Administrator. '
      'Saya sangat antusias berkontribusi di tim Bapak/Ibu."',
    seniorTip: 'Jangan pernah membacakan ulang KTP. Fokus pada apa yang sudah pernah kamu selesaikan (impact) dan apa yang bisa kamu tawarkan ke perusahaan.',
    optionExplanations: {
      0: '❌ Terlalu bertele-tele dan tidak relevan dengan dunia kerja IT.',
      1: '✅ Tepat sekali! Menghubungkan keahlian dengan bukti proyek nyata dan sertifikasi resmi.',
      2: '❌ Klise dan memberi kesan tidak natural.',
      3: '❌ Merendahkan diri sendiri secara ekstrem, padahal kamu sudah punya portofolio nyata.',
    },
    keyKeywords: ['Elevator Pitch', 'Warung Lupi', 'Laravel', 'BNSP', 'Pusdiklat BPS'],
  ),

  Question(
    id: 'hr_2',
    category: QuestionCategory.hr,
    question: 'Pewawancara: "Apa kelemahan terbesar yang kamu miliki saat bekerja?"',
    whyAsked: 'Menguji *self-awareness* (kesadaran diri) dan kejujuran tanpa membahayakan reputasi profesional.',
    options: [
      'Menjawab: "Kelemahan saya adalah saya orangnya terlalu perfeksionis dan workaholic."',
      'Menjawab: "Saya sering malas kalau disuruh bangun pagi dan suka lupa menaruh file."',
      'Mengakui kelemahan nyata yang teknis/alur kerja, disertai tindakan konkret yang sudah kamu lakukan untuk mengatasinya.',
      'Menjawab: "Sejauh ini saya tidak memiliki kelemahan yang berarti dalam coding."',
    ],
    correctOptionIndex: 2,
    idealAnswer:
      'Akui kebiasaan yang sedang kamu perbaiki:\n'
      '"Karena terbiasa membuat proyek secara solo, dulu saya sering terlalu lama mengutak-atik kode sendiri sebelum meminta bantuan. '
      'Sekarang saya membiasakan komunikasi aktif di tim, menggunakan alur Git branch yang rapi, dan mencatat dokumentasi agar rekan kerja mudah membaca alur kode saya."',
    seniorTip: 'Kelemahan yang bagus adalah kelemahan yang diiringi dengan *action plan* perbaikan yang sudah terbukti.',
    optionExplanations: {
      0: '❌ "Perfeksionis" adalah jawaban paling dibenci rekruter karena terdengar pura-pura dan tidak tulus.',
      1: '❌ Ini adalah *red flag* fatal tentang disiplin dasar.',
      2: '✅ Jawaban jujur, dewasa, dan menunjukkan kamu terus bertumbuh (*growth mindset*).',
      3: '❌ Terdengar arogan dan tidak memiliki kesadaran diri.',
    },
    keyKeywords: ['Growth Mindset', 'Git Branch', 'Komunikasi Tim', 'Solusi Nyata'],
  ),

  Question(
    id: 'hr_3',
    category: QuestionCategory.hr,
    question: 'Pewawancara: "Bagaimana alur kerjamu dengan AI / Copilot / Agent dalam pemrograman?"',
    whyAsked: 'Mengecek apakah kamu hanya "asal prompt & copy-paste buta" atau benar-benar memahami arsitektur dan kode yang dihasilkan.',
    options: [
      'Mengatakan: "Saya tidak pernah pakai AI sama sekali, semuanya saya ketik manual 100% dari ingatan."',
      'Mengatakan: "Saya tinggal ketik prompt suruh AI bikin aplikasi utuh, kalau ada error saya lempar balik ke AI."',
      'Menjelaskan bahwa AI digunakan sebagai akselerator boilerplate, namun kamu yang memegang kendali arsitektur, membaca diff, memvalidasi keamanan, dan menguji logika.',
      'Menjawab bahwa AI berbahaya dan tidak boleh dipakai di perusahaan.',
    ],
    correctOptionIndex: 2,
    idealAnswer:
      'Posisikan dirimu sebagai engineer modern:\n'
      '"Saya memandang AI agent sebagai alat bantu efisiensi untuk menulis boilerplate code secara cepat. '
      'Namun keputusan arsitektur, validasi logika bisnis, keamanan input, dan pembacaan diff kode tetap sepenuhnya di bawah kendali saya. '
      'Saya selalu memastikan setiap baris kode diuji (unit testing) sebelum masuk ke branch utama."',
    seniorTip: 'Industri modern menghargai efisiensi tinggi, asalkan engineer-nya memiliki pemahaman mendalam tentang kode yang dimasukkan ke repositori.',
    optionExplanations: {
      0: '❌ Kurang realistis di tahun 2026 dan terkesan menutup diri dari teknologi modern.',
      1: '❌ Bahaya besar! Rekruter akan menganggap kamu tidak bisa menyelesaikan masalah saat AI memberikan halusinasi.',
      2: '✅ Jawaban sangat profesional ala Senior Engineer yang bijak memanfaatkan tools.',
      3: '❌ Terlalu kaku dan tidak relevan.',
    },
    keyKeywords: ['Boilerplate', 'Baca Diff', 'Arsitektur', 'Unit Testing', 'Kendali Logika'],
  ),

  // ─── 2. CORE PHP & OOP ──────────────────────────────────────────────────
  Question(
    id: 'php_1',
    category: QuestionCategory.corePhp,
    question: 'Di PHP, apa perbedaan mendasar antara operator perbandingan `==` dan `===`?',
    whyAsked: 'Menguji pemahaman tentang konsep Type Juggling dan pencegahan celah keamanan pada validasi logika.',
    options: [
      '`==` membandingkan tipe data saja, sedangkan `===` membandingkan nilai saja.',
      '`==` membandingkan nilai setelah konversi tipe otomatis (Type Juggling), sedangkan `===` membandingkan nilai dan tipe data secara identik tanpa konversi.',
      'Tidak ada bedanya, hanya gaya penulisan alternatif di versi PHP terbaru.',
      '`===` hanya digunakan khusus untuk perbandingan objek dan array.',
    ],
    correctOptionIndex: 1,
    idealAnswer:
      '"`==` (loose comparison) mengizinkan PHP mengubah tipe data secara implisit, misalnya `0 == "0"` bernilai true. '
      'Sedangkan `===` (strict comparison) memeriksa nilai sekaligus tipe datanya, sehingga `0 === "0"` bernilai false. '
      'Di kode produksi dan pengecekan keamanan (seperti password hash atau role token), selalu gunakan `===`."',
    seniorTip: 'Sebutkan contoh nyata bug keamanan type juggling di PHP, misalnya perbandingan `0 == "admin_text"` yang bisa tembus di sistem lama.',
    optionExplanations: {
      0: '❌ Terbalik definisinya.',
      1: '✅ Tepat! Strict comparison adalah standar keamanan di PHP 8.x modern.',
      2: '❌ Sangat keliru, dampaknya fatal pada logika kondisional.',
      3: '❌ `===` berlaku untuk semua tipe primitif maupun kompleks.',
    },
    keyKeywords: ['Type Juggling', 'Strict Comparison', 'Tipe Data', 'Identik'],
  ),

  Question(
    id: 'php_2',
    category: QuestionCategory.corePhp,
    question: 'Kapan kamu harus menggunakan blok `try-catch-finally` dalam PHP?',
    whyAsked: 'Melihat bagaimana kandidat menangani skenario error tanpa membuat server crash dengan pesan 500 mentah ke user.',
    options: [
      'Hanya boleh dipakai jika database MySQL mati.',
      'Untuk membungkus setiap baris kode di aplikasi tanpa terkecuali.',
      'Saat menjalankan operasi berisiko tinggi (misal: koneksi API pihak ketiga/Midtrans, query database kritis, parsing file) agar exception dapat ditangkap dan di-rollback.',
      'Try-catch hanya fitur lama yang sudah tidak direkomendasikan di PHP 8.',
    ],
    correctOptionIndex: 2,
    idealAnswer:
      'Gunakan try-catch untuk operasi yang rawan melempar Exception tak terduga, seperti komunikasi HTTP ke Midtrans atau manipulasi file. '
      'Blok `catch` digunakan untuk mencatat log error (`Log::error`) dan mengembalikan pesan yang aman untuk user, sedangkan `finally` untuk membersihkan resource seperti menutup stream koneksi.',
    seniorTip: 'Di wawancara, sebutkan bahwa kamu tidak menelan error begitu saja (`empty catch`), melainkan selalu mencatat error ke logging monitoring.',
    optionExplanations: {
      0: '❌ Terlalu sempit.',
      1: '❌ Membungkus seluruh kode membabi-buta membuat debugging sulit dan kode berantakan.',
      2: '✅ Jawaban tepat. Penanganan error yang defensif adalah ciri developer handal.',
      3: '❌ Try-catch adalah pilar utama penanganan Exception di semua bahasa modern.',
    },
    keyKeywords: ['Exception', 'Defensive Programming', 'Rollback', 'Logging'],
  ),

  // ─── 3. LARAVEL FRAMEWORK ───────────────────────────────────────────────
  Question(
    id: 'lar_1',
    category: QuestionCategory.laravel,
    question: 'Pewawancara: "Apa itu masalah N+1 Query di Laravel Eloquent dan bagaimana cara mengatasinya?"',
    whyAsked: 'Pertanyaan paling populer untuk menguji optimasi performa database dan pemahaman Eloquent ORM.',
    options: [
      'Masalah di mana aplikasi mengirimkan 1 query untuk mengambil data utama, lalu mengirimkan N query tambahan di dalam looping untuk mengambil relasinya. Diatasi dengan Eager Loading `with()`.',
      'Masalah saat jumlah baris data melebihi N record. Diatasi dengan menghapus data lama.',
      'Masalah koneksi database melebihi batas pool. Diatasi dengan restart web server.',
      'Kondisi di mana query SQL gagal karena foreign key tidak cocok. Diatasi dengan menonaktifkan constraint.',
    ],
    correctOptionIndex: 0,
    idealAnswer:
      '"Masalah N+1 terjadi saat kita mengambil 50 order (`1 query`), lalu saat looping `\$order->customer->name`, Laravel menjalankan query SELECT ke tabel customer satu per satu sebanyak 50 kali (`50 query tambahan`). '
      'Totalnya jadi 51 query! Solusinya adalah menggunakan Eager Loading: `Order::with(\'customer\')->get()`, sehingga Laravel hanya menjalankan 2 query efisien dengan klausa `WHERE IN`."',
    seniorTip: 'Sebutkan bahwa di Laravel 11/10 kita bisa menyalakan `Model::preventLazyLoading(!app()->isProduction())` di AppServiceProvider untuk mendeteksi N+1 secara otomatis saat development.',
    optionExplanations: {
      0: '✅ Sempurna! Penjelasan definisi dan solusi `with()` sangat jelas.',
      1: '❌ N+1 adalah masalah query explosion pada relasi looping, bukan jumlah baris data.',
      2: '❌ Keliru.',
      3: '❌ Sangat keliru dan berbahaya mematikan constraint.',
    },
    keyKeywords: ['Eager Loading', 'with()', 'Lazy Loading', 'Query Explosion'],
  ),

  Question(
    id: 'lar_2',
    category: QuestionCategory.laravel,
    question: 'Mengapa lebih disarankan menggunakan FormRequest Class di Laravel dibanding menulis `\$request->validate()` langsung di Controller?',
    whyAsked: 'Melihat pemahaman arsitektur *Single Responsibility Principle* (SRP) dan kebersihan kode.',
    options: [
      'Karena validasi di Controller tidak bisa memeriksa tipe data string.',
      'Agar Controller tetap ramping (skinny controller), aturan validasi terisolasi, dan logika otorisasi (`authorize()`) bisa dicek sebelum controller dieksekusi.',
      'FormRequest lebih cepat 100 kali lipat secara eksekusi memori.',
      'Validasi di Controller sudah dihapus di Laravel versi terbaru.',
    ],
    correctOptionIndex: 1,
    idealAnswer:
      '"FormRequest memisahkan tanggung jawab validasi dan otorisasi keluar dari Controller. '
      'Ini membuat Controller fokus pada orkestrasi logika bisnis, memudahkan pengujian unit (unit testing) aturan validasi, serta membuat aturan validasi dapat digunakan kembali di beberapa tempat."',
    seniorTip: 'Sebutkan contoh method `authorize()` dan `rules()` di FormRequest untuk menunjukkan kamu sering menggunakannya di kode nyata.',
    optionExplanations: {
      0: '❌ Validasi di Controller bisa memeriksa semua tipe data.',
      1: '✅ Tepat! Kode jadi clean, modular, dan mematuhi prinsip Single Responsibility.',
      2: '❌ Bukan karena perbedaan kecepatan memori, melainkan maintainability kode.',
      3: '❌ Fitur `\$request->validate()` masih ada, hanya kurang rapi untuk form besar.',
    },
    keyKeywords: ['Skinny Controller', 'Single Responsibility', 'authorize()', 'Clean Code'],
  ),

  Question(
    id: 'lar_3',
    category: QuestionCategory.laravel,
    question: 'Di Laravel Eloquent, apa perbedaan fungsi `\$fillable` dan `\$guarded` pada Model?',
    whyAsked: 'Menguji kepedulian terhadap keamanan celah Mass Assignment Vulnerability.',
    options: [
      '`\$fillable` untuk menentukan kolom database yang boleh diisi secara massal (`Model::create()`), sedangkan `\$guarded` adalah daftar hitam (blacklist) kolom yang dilarang diisi massal.',
      '`\$fillable` untuk mengatur password, sedangkan `\$guarded` untuk mengatur username.',
      '`\$fillable` hanya dipakai jika database menggunakan PostgreSQL.',
      'Keduanya wajib diisi bersamaan di setiap file Model Laravel.',
    ],
    correctOptionIndex: 0,
    idealAnswer:
      '"Keduanya berfungsi melindungi aplikasi dari celah Mass Assignment di mana penyerang menyelipkan field seperti `is_admin = 1` pada payload request. '
      '`\$fillable` bekerja sebagai whitelist (hanya kolom ini yang boleh diisi), sedangkan `\$guarded` adalah blacklist. '
      'Best practice keamanan adalah menggunakan `\$fillable` secara eksplisit."',
    seniorTip: 'Jelaskan bahwa membiarkan `\$guarded = []` (array kosong) tanpa FormRequest yang ketat adalah risiko keamanan serius.',
    optionExplanations: {
      0: '✅ Tepat! Whitelist vs Blacklist untuk proteksi mass-assignment.',
      1: '❌ Keliru.',
      2: '❌ Berlaku untuk semua database driver di Laravel.',
      3: '❌ Hanya perlu memilih salah satu (biasanya `\$fillable`).',
    },
    keyKeywords: ['Mass Assignment', 'Whitelist', 'Blacklist', 'Keamanan Input'],
  ),

  // ─── 4. DATABASE & SQL ──────────────────────────────────────────────────
  Question(
    id: 'db_1',
    category: QuestionCategory.database,
    question: 'Kapan kita harus menambahkan INDEX pada sebuah kolom di tabel database MySQL?',
    whyAsked: 'Mengetahui apakah kandidat paham optimasi query database saat data bertumbuh menjadi puluhan ribu baris.',
    options: [
      'Semua kolom di semua tabel wajib diberikan INDEX tanpa kecuali.',
      'Pada kolom yang sering digunakan di klausa `WHERE`, `JOIN on`, dan `ORDER BY`, terutama yang memiliki variasi nilai tinggi.',
      'INDEX hanya boleh ditambahkan pada primary key saja.',
      'INDEX ditambahkan jika ukuran harddisk server sudah hampir penuh.',
    ],
    correctOptionIndex: 1,
    idealAnswer:
      '"Index bekerja seperti daftar isi buku, mengubah pencarian dari Full Table Scan (O(N)) menjadi pencarian pohon B-Tree (O(log N)). '
      'Kita memasang index pada kolom yang sering dicari atau difilter, seperti `status_transaksi`, `customer_id`, atau `tanggal_order`. '
      'Namun jangan meng-index semua kolom karena index memperlambat proses INSERT dan UPDATE."',
    seniorTip: 'Sebutkan trade-off: Index mempercepat SELECT, tapi menambah overhead waktu pada operasi INSERT/UPDATE dan memakan kapasitas storage.',
    optionExplanations: {
      0: '❌ Memberi index ke semua kolom justru merusak performa write (INSERT/UPDATE) dan boros storage.',
      1: '✅ Tepat dan komprehensif! Paham konsep B-Tree dan kolom selektif.',
      2: '❌ Primary key memang otomatis di-index, tapi foreign key dan kolom filter juga butuh index.',
      3: '❌ Index justru menambah penggunaan storage, bukan menguranginya.',
    },
    keyKeywords: ['B-Tree', 'Full Table Scan', 'WHERE Clause', 'Trade-off Write'],
  ),

  Question(
    id: 'db_2',
    category: QuestionCategory.database,
    question: 'Mengapa transaksi perbankan atau pembayaran pulsa/kasir harus dibungkus dalam Database Transaction (ACID)?',
    whyAsked: 'Menguji integritas data saat terjadi kegagalan sistem di tengah proses transaksi.',
    options: [
      'Agar query SQL berjalan lebih cepat di background.',
      'Untuk memastikan prinsip Atomicity: semua perubahan berhasil bersamaan, atau jika salah satu gagal, seluruh transaksi di-rollback sehingga tidak ada data menggantung.',
      'Hanya untuk memenuhi syarat formalitas skripsi.',
      'Database transaction digunakan untuk mengubah database relational menjadi NoSQL.',
    ],
    correctOptionIndex: 1,
    idealAnswer:
      '"Dalam transaksi (misal pemotongan saldo kasir dan penambahan pesanan), ada beberapa query terpisah. '
      'Jika query pemotongan saldo berhasil tapi query pesanan gagal di tengah jalan, saldo user hilang tanpa pesanan! '
      'Dengan `DB::transaction(function() { ... })`, jika terjadi Exception di baris manapun, Laravel dan MySQL otomatis melakukan ROLLBACK ke kondisi semula."',
    seniorTip: 'Ceritakan pengalamanmu di proyek Gadai Enoni Cell atau Warung Lupi dalam menjaga integritas data bon/utang pelanggan.',
    optionExplanations: {
      0: '❌ Transaction menambahkan safety log (undo log), bukan untuk kecepatan murni.',
      1: '✅ Jawaban sangat tepat! Atomicity (All or Nothing) adalah fondasi transaksi finansial.',
      2: '❌ Keliru.',
      3: '❌ Keliru sama sekali.',
    },
    keyKeywords: ['ACID', 'Atomicity', 'Rollback', 'Commit', 'Integritas Saldo'],
  ),

  // ─── 5. GIT & TEAM WORKFLOW ─────────────────────────────────────────────
  Question(
    id: 'git_1',
    category: QuestionCategory.gitWorkflow,
    question: 'Apa yang kamu lakukan jika saat ingin melakukan `git pull` atau `git merge`, terminal memberi tahu terjadi "Merge Conflict"?',
    whyAsked: 'Menguji ketenangan dan kompetensi kandidat dalam bekerja di dalam tim software engineer.',
    options: [
      'Menghapus folder proyek lokal lalu clone ulang dari repository GitHub.',
      'Tenang, buka file yang berkonflik di editor, diskusikan dengan rekan tim baris kode mana yang dipertahankan, hapus marker conflict (`<<<<<<<`, `=======`, `>>>>>>>`), lalu commit ulang.',
      'Memaksa push dengan perintah `git push -f origin main` agar menimpa kodingan teman.',
      'Menyalahkan rekan tim yang melakukan push duluan.',
    ],
    correctOptionIndex: 1,
    idealAnswer:
      '"Merge conflict adalah hal wajar saat dua developer mengubah baris kode yang sama. '
      'Langkahnya: 1. Cek file terdampak lewat `git status`. 2. Buka filenya, telaah perubahan local vs incoming change (bisa pakai bantuan merge tool di VS Code). '
      '3. Komunikasi dengan rekan kerja jika ragu. 4. Hapus conflict markers, tes apakah kode tetap berjalan lancar, lalu `git add` dan `git commit`."',
    seniorTip: 'Sebutkan bahwa kamu mencegah conflict sejak dini dengan rajin melakukan pull dari branch utama dan menggunakan alur Feature-Branch yang berumur pendek.',
    optionExplanations: {
      0: '❌ Cara amatir yang membuang waktu dan berisiko menghilangkan pekerjaan lokal.',
      1: '✅ Sikap profesional dan langkah teknis yang benar.',
      2: '❌ `git push -f` di branch bersama adalah bencana besar yang bisa menghapus pekerjaan seluruh tim!',
      3: '❌ Sikap tidak profesional.',
    },
    keyKeywords: ['Conflict Markers', 'Git Status', 'Komunikasi Tim', 'Feature Branch'],
  ),
];
