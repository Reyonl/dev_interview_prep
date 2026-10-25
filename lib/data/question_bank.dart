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
    whyAsked: 'Menguji self-awareness (kesadaran diri) dan kejujuran tanpa membahayakan reputasi profesional.',
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
    seniorTip: 'Kelemahan yang bagus adalah kelemahan yang diiringi dengan action plan perbaikan yang sudah terbukti.',
    optionExplanations: {
      0: '❌ "Perfeksionis" adalah jawaban paling dibenci rekruter karena terdengar pura-pura dan tidak tulus.',
      1: '❌ Ini adalah red flag fatal tentang disiplin dasar.',
      2: '✅ Jawaban jujur, dewasa, dan menunjukkan kamu terus bertumbuh (growth mindset).',
      3: '❌ Terdengar arogan dan tidak memiliki kesadaran diri.',
    },
    keyKeywords: ['Growth Mindset', 'Git Branch', 'Komunikasi Tim', 'Solusi Nyata'],
  ),

  Question(
    id: 'hr_3',
    category: QuestionCategory.hr,
    question: 'Pewawancara: "Bagaimana sikapmu terhadap penggunaan AI Coding Assistant (seperti Copilot atau ChatGPT)?"',
    whyAsked: 'Mengetahui apakah kandidat paham batasan etika, validasi kode, dan integritas kerja teknis.',
    options: [
      'Mengatakan bahwa kamu tidak pernah menyentuh AI sama sekali karena programmer sejati menulis semuanya manual.',
      'Mengakui menggunakan AI untuk boilerplate dan brainstorming, namun selalu memvalidasi logika, menulis automated test, dan memahami setiap baris sebelum commit.',
      'Mengatakan kamu menyalin 100% kode dari AI tanpa perlu membaca ulang karena AI lebih pintar.',
      'Menolak menjawab karena takut dianggap curang.',
    ],
    correctOptionIndex: 1,
    idealAnswer:
      '"Saya memandang AI sebagai amplifier produktivitas. Saya memanfaatkannya untuk mempercepat pembuatan regex, boilerplate, atau unit test. '
      'Namun tanggung jawab kebenaran logika, keamanan sistem, dan performa tetap ada pada saya. Saya wajib memahami setiap baris dan menjalankannya melalui automated tests sebelum masuk ke repository tim."',
    seniorTip: 'Tekankan bahwa AI adalah alat pendukung (copilot), sedangkan kamu adalah pilot utamanya yang memegang kendali arsitektur dan kualitas kode.',
    optionExplanations: {
      0: '❌ Di era sekarang, menolak AI sepenuhnya justru dianggap kurang efisien dan ketinggalan zaman.',
      1: '✅ Sikap profesional seorang engineer modern: memanfaatkan teknologi secara bijak dengan verifikasi ketat.',
      2: '❌ Red flag besar! Menandakan kandidat tidak paham kode yang dikirimnya.',
      3: '❌ Menunjukkan ketidakjujuran.',
    },
    keyKeywords: ['Amplifier Produktivitas', 'Verifikasi Logika', 'Automated Test', 'Tanggung Jawab'],
  ),

  // ─── 2. CORE PHP & OOP ───────────────────────────────────────────────────
  Question(
    id: 'php_1',
    category: QuestionCategory.corePhp,
    question: 'Apa perbedaan mendasar antara operator perbandingan `==` dan `===` di PHP?',
    whyAsked: 'Menguji pemahaman tentang Type Juggling (konversi tipe data otomatis) yang sering memicu bug keamanan di PHP.',
    options: [
      '`==` membandingkan nilai setelah type coercion (type juggling), sedangkan `===` membandingkan nilai DAN tipe data secara identik (strict).',
      'Tidak ada bedanya, hanya gaya penulisan programmer baru.',
      '`===` digunakan khusus untuk membandingkan array saja.',
      '`==` hanya berlaku di PHP 5 ke bawah.',
    ],
    correctOptionIndex: 0,
    idealAnswer:
      '"Di PHP, operator `==` melakukan type juggling, contohnya string `"0"` atau string kosong `""` bisa bernilai true saat dibandingkan dengan `false` atau `0`. '
      'Hal ini sangat berbahaya pada validasi otentikasi atau hashing. Operator `===` adalah strict comparison yang memeriksa nilai dan tipe data tanpa konversi otomatis."',
    seniorTip: 'Sebutkan contoh nyata: `if ("0" == false)` bernilai TRUE, tetapi `if ("0" === false)` bernilai FALSE. Senior dev selalu mewajibkan `===`.',
    optionExplanations: {
      0: '✅ Tepat sekali! Pemahaman mendalam tentang loose vs strict comparison.',
      1: '❌ Fatal! Keduanya memiliki perilaku logika yang sangat berbeda.',
      2: '❌ Keliru, berlaku untuk semua tipe data primitif dan objek.',
      3: '❌ Keliru.',
    },
    keyKeywords: ['Type Juggling', 'Type Coercion', 'Strict Comparison', 'Identik Nilai & Tipe'],
  ),

  Question(
    id: 'php_2',
    category: QuestionCategory.corePhp,
    question: 'Kapan sebaiknya kita menggunakan `try-catch` block dalam aplikasi PHP?',
    whyAsked: 'Mengetahui apakah kandidat mampu menulis kode yang tangguh (defensive programming) saat terjadi kegagalan eksternal.',
    options: [
      'Membungkus semua baris kode dari baris pertama sampai terakhir dengan satu try-catch besar.',
      'Pada proses yang rawan mengalami kegagalan tak terduga (I/O, network call, query database transaksi, atau pemanggilan third-party API) agar aplikasi tidak crash dan error tercatat rapi.',
      'Try-catch hanya digunakan jika server kehabisan memori.',
      'Tidak perlu try-catch, cukup matikan display_errors di php.ini.',
    ],
    correctOptionIndex: 1,
    idealAnswer:
      '"Try-catch digunakan di operasi yang bergantung pada faktor eksternal di luar kendali kode kita, seperti HTTP call ke Payment Gateway, koneksi database, atau manipulasi file server. '
      'Dengan try-catch, kita bisa melakukan fallback, me-rollback transaksi database, mencatat error ke log via logger, dan mengembalikan pesan respons yang ramah ke user."',
    seniorTip: 'Hindari empty catch block (`catch (Exception \$e) {}`). Selalu log exception tersebut atau kembalikan user-friendly error response.',
    optionExplanations: {
      0: '❌ Praktik buruk (anti-pattern) yang menyembunyikan akar masalah.',
      1: '✅ Tepat! Menangani proses rentan secara elegan dan defensif.',
      2: '❌ Fatal error memori tidak dapat ditangkap oleh try-catch standar.',
      3: '❌ Sangat berbahaya di aplikasi produksi.',
    },
    keyKeywords: ['Defensive Programming', 'Third-party API', 'Database Transaction', 'Logging'],
  ),

  // ─── 3. LARAVEL FRAMEWORK ────────────────────────────────────────────────
  Question(
    id: 'lar_1',
    category: QuestionCategory.laravel,
    question: 'Apa itu masalah "N+1 Query Problem" di Laravel Eloquent dan bagaimana cara mengatasinya?',
    whyAsked: 'Pertanyaan paling populer untuk mengukur pemahaman kandidat terhadap optimasi performa backend.',
    options: [
      'Masalah di mana aplikasi mengirim N+1 notifikasi email sekaligus; diatasi dengan cron job.',
      'Kondisi di mana query database dieksekusi 1 kali untuk data induk, lalu N kali untuk setiap data relasi di dalam loop; diatasi dengan Eager Loading `with()`.',
      'Masalah penomoran tabel di phpMyAdmin; diatasi dengan auto-increment.',
      'Kondisi di mana server kehabisan port koneksi database.',
    ],
    correctOptionIndex: 1,
    idealAnswer:
      '"N+1 Query terjadi saat kita mengambil 50 data User, lalu di dalam perulangan kita memanggil `\$user->profile->avatar`. '
      'Laravel akan menjalankan 1 query untuk mengambil users, ditambah 50 query tambahan untuk masing-masing profile—total 51 query! '
      'Solusinya adalah menggunakan Eager Loading: `User::with(\'profile\')->get()`, sehingga Laravel hanya menjalankan 2 query database yang efisien via `WHERE IN`."',
    seniorTip: 'Sebutkan bahwa kamu bisa mencegah N+1 di fase development dengan mengaktifkan `Model::preventLazyLoading(!app()->isProduction())` di `AppServiceProvider`. Pewawancara senior akan sangat terkesan!',
    optionExplanations: {
      0: '❌ Konsep keliru.',
      1: '✅ Jawaban sempurna! Paham akar masalah dan mekanisme Eager Loading.',
      2: '❌ Sama sekali tidak relevan.',
      3: '❌ Keliru.',
    },
    keyKeywords: ['N+1 Query', 'Eager Loading', 'with()', 'preventLazyLoading', 'WHERE IN'],
  ),

  Question(
    id: 'lar_2',
    category: QuestionCategory.laravel,
    question: 'Apa perbedaan antara properti `\$fillable` dan `\$guarded` di Model Eloquent Laravel?',
    whyAsked: 'Menguji kesadaran keamanan terhadap celah Mass Assignment Vulnerability.',
    options: [
      '`\$fillable` menentukan kolom yang diizinkan untuk mass-assignment (whitelist), sedangkan `\$guarded` menentukan kolom yang dilarang (blacklist).',
      '`\$fillable` untuk database MySQL, sedangkan `\$guarded` untuk PostgreSQL.',
      '`\$fillable` otomatis membuat kolom di tabel database saat migration.',
      '`\$fillable` dan `\$guarded` wajib diisi keduanya pada setiap model.',
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
    question: 'Mengapa transaksi perbankan atau pembayaran kasir harus dibungkus dalam Database Transaction (ACID)?',
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

  Question(
    id: 'git_2',
    category: QuestionCategory.gitWorkflow,
    question: 'Mengapa developer senior melarang commit langsung ke branch `main`/`master` (Direct Commit)?',
    whyAsked: 'Mengetahui pemahaman kandidat mengenai pipeline CI/CD, review kode, dan stabilitas server produksi.',
    options: [
      'Karena branch main hanya boleh diakses oleh CEO perusahaan.',
      'Untuk menjaga branch main selalu dalam kondisi stabil (deployable). Setiap perubahan harus melewati feature branch, automated testing, dan code review sebelum dimerge.',
      'Hanya tradisi lama yang tidak wajib diikuti jika proyeknya buru-buru.',
      'Agar commit history terlihat lebih panjang dan ramai di GitHub.',
    ],
    correctOptionIndex: 1,
    idealAnswer:
      '"Branch main mencerminkan kondisi kode yang berjalan di server produksi. '
      'Dengan Feature-Branch workflow (misal `feat/checkout-flow`), developer dapat bekerja secara terisolasi tanpa mengganggu rekan lain. '
      'Sebelum dimerge ke main via PR/Merge Request, kode wajib lolos static analysis dan unit test agar bug tidak bocor ke user live."',
    seniorTip: 'Ceritakan bagaimana kamu menerapkan perlindungan branch (`Branch Protection Rules`) dan Git merge non-fast-forward (`--no-ff`) untuk transparansi commit history.',
    optionExplanations: {
      0: '❌ Tidak benar.',
      1: '✅ Sangat tepat! Fondasi continuous integration dan kehandalan rilis produksi.',
      2: '❌ Kebiasaan langsung commit ke main saat buru-buru adalah penyebab utama server produksi down.',
      3: '❌ Bukan tujuan teknis yang benar.',
    },
    keyKeywords: ['Feature Branch', 'Production Stability', 'Code Review', 'Quality Gate'],
  ),

  // ─── 6. SYSTEM DESIGN & SCALE ────────────────────────────────────────────
  Question(
    id: 'sd_1',
    category: QuestionCategory.systemDesign,
    question: 'Bagaimana alur kerja pola "Cache-Aside" dengan Redis untuk mempercepat response time query berat?',
    whyAsked: 'Mengetahui apakah kandidat paham strategi caching, masa kedaluwarsa (TTL), dan cache invalidation.',
    options: [
      'Semua data database dipindahkan permanen ke Redis tanpa menyimpan ke MySQL lagi.',
      'Aplikasi memeriksa data di Redis terlebih dahulu (Cache Hit); jika tidak ada (Cache Miss), ambil dari database SQL, simpan ke Redis dengan TTL, lalu kembalikan ke client.',
      'Redis hanya digunakan saat server MySQL sedang restart.',
      'Cache disimpan di localStorage browser pengguna sehingga server tidak perlu memory sama sekali.',
    ],
    correctOptionIndex: 1,
    idealAnswer:
      '"Pada pola Cache-Aside: Ketika ada request, backend cek ke Redis dulu. '
      'Jika data ada (Cache Hit), langsung kirim ke client dalam hitungan milidetik. '
      'Jika belum ada (Cache Miss), backend query ke MySQL, simpan hasilnya ke Redis dengan waktu kedaluwarsa (misal TTL 1 jam), baru kirim ke user. '
      'Saat terjadi update data di database, kita lakukan Cache Invalidation (`Cache::forget`) agar data tidak basi (stale data)."',
    seniorTip: 'Sebutkan trade-off: Caching meningkatkan kecepatan hingga 10x lipat, namun tantangan terbesarnya adalah menjaga konsistensi data antara cache dan persistent storage.',
    optionExplanations: {
      0: '❌ Redis adalah in-memory data store yang volatil, bukan pengganti relational database utama.',
      1: '✅ Jawaban standar arsitektur backend industri! Cache-Aside dengan TTL dan Invalidation.',
      2: '❌ Keliru.',
      3: '❌ LocalStorage browser tidak bisa dibagi antar user dan tidak menyelesaikan beban query server.',
    },
    keyKeywords: ['Cache-Aside', 'Redis', 'TTL', 'Cache Invalidation', 'Cache Hit / Miss'],
  ),

  Question(
    id: 'sd_2',
    category: QuestionCategory.systemDesign,
    question: 'Mengapa proses berat seperti kirim email notifikasi atau generate invoice PDF tidak boleh dijalankan langsung di Controller request?',
    whyAsked: 'Menguji pemahaman kandidat mengenai Asynchronous processing, Queue Workers, dan HTTP Timeout.',
    options: [
      'Karena PHP tidak memiliki library untuk membuat file PDF.',
      'Koneksi SMTP email atau pembuatan PDF memakan waktu 3-10 detik. Jika dijalankan di Controller, user harus menunggu loading lama dan berisiko terkena HTTP Gateway Timeout (504). Solusinya adalah mendelegasikannya ke Asynchronous Queue Worker (Job).',
      'Hanya agar kode controller terlihat lebih sedikit barisnya.',
      'Email hanya boleh dikirim oleh frontend JavaScript, bukan backend.',
    ],
    correctOptionIndex: 1,
    idealAnswer:
      '"HTTP request-response cycle harus secepat mungkin (idealnya di bawah 200ms). '
      'Proses I/O eksternal seperti SMTP atau rendering PDF sangat rawan latency dan network failure. '
      'Dengan Laravel Queue (didukung Redis atau Database driver), kita cukup dispatch job: `SendInvoiceJob::dispatch(\$order)`. '
      'User langsung mendapatkan respons sukses dalam sekejap, sementara pengiriman sebenarnya dieksekusi oleh worker process di background."',
    seniorTip: 'Jelaskan fitur retry logic dan failed jobs: Jika server email down, queue worker bisa otomatis mencoba ulang 3 kali (`tries = 3`) tanpa membuat order user gagal.',
    optionExplanations: {
      0: '❌ PHP punya library populer seperti DomPDF dan Snappy.',
      1: '✅ Pemahaman arsitektur backend yang sangat matang! Asynchronous Queue mencegah bottleneck.',
      2: '❌ Alasan estetika bukan pertimbangan arsitektur.',
      3: '❌ Sangat keliru, email rahasia dan kredensial SMTP wajib ada di backend.',
    },
    keyKeywords: ['Asynchronous', 'Queue Worker', 'Job Dispatch', 'HTTP Timeout 504', 'Retry Logic'],
  ),

  // ─── 7. WEB & API SECURITY ───────────────────────────────────────────────
  Question(
    id: 'sec_1',
    category: QuestionCategory.securityOwasp,
    question: 'Bagaimana cara kerja serangan SQL Injection dan apa solusi mutlak untuk mencegahnya?',
    whyAsked: 'Menguji pemahaman fundamental OWASP Top 10 dan validasi input database.',
    options: [
      'SQL Injection terjadi saat hacker mencuri password wifi kantor; solusinya menggunakan VPN.',
      'Penyerang menyisipkan karakter SQL berbahaya (seperti `\' OR 1=1 --`) ke input form yang digabung langsung (string concatenation) dengan query SQL. Solusi mutlaknya adalah Prepared Statements / Parameterized Queries.',
      'Cukup mematikan koneksi internet database saat malam hari.',
      'Menghapus database MySQL dan menggantinya dengan file Excel.',
    ],
    correctOptionIndex: 1,
    idealAnswer:
      '"SQL Injection terjadi saat data input pengguna langsung disambung (`SELECT * FROM users WHERE email = \'\' . \$email`) tanpa sanitasi. '
      'Penyerang dapat memanipulasi logika query untuk bypass login atau menghapus tabel. '
      'Pencegahan mutlak adalah Prepared Statements (yang otomatis digunakan oleh PDO dan Eloquent Laravel). '
      'Prepared statements memisahkan struktur query dari nilai input data, sehingga input berbahaya hanya dianggap sebagai string biasa, bukan perintah SQL."',
    seniorTip: 'Jelaskan bahwa di Laravel, query Eloquent standar aman dari SQLi. Namun jika menggunakan raw query (`DB::raw(\$input)`), developer wajib memakai binding parameter `DB::select(\'...\', [\$input])`.',
    optionExplanations: {
      0: '❌ Konsep keliru sama sekali.',
      1: '✅ Tepat sekali! Menjelaskan mekanisme concatenation dan Prepared Statement PDO.',
      2: '❌ Tidak masuk akal.',
      3: '❌ Sangat keliru.',
    },
    keyKeywords: ['SQL Injection', 'Prepared Statements', 'PDO Parameter Binding', 'OWASP Top 10'],
  ),

  Question(
    id: 'sec_2',
    category: QuestionCategory.securityOwasp,
    question: 'Mengapa algoritma hashing MD5 atau SHA-1 dilarang keras untuk menyimpan password pengguna?',
    whyAsked: 'Menguji pemahaman kriptografi praktis dan perlindungan kredensial user.',
    options: [
      'Karena MD5 terlalu lambat sehingga membuat login lemot.',
      'MD5 dan SHA-1 dirancang cepat untuk checksum file, bukan untuk password. Kecepatannya memudahkan peretas melakukan Brute-force miliaran kombinasi per detik via GPU atau Rainbow Tables. Password wajib menggunakan Adaptive KDF (seperti Bcrypt atau Argon2id) dengan salt otomatis.',
      'MD5 hanya bekerja di sistem operasi Linux, tidak bisa di Windows.',
      'Karena lisensi MD5 sudah habis masa berlakunya.',
    ],
    correctOptionIndex: 1,
    idealAnswer:
      '"MD5 dan SHA-256 adalah general cryptographic hash yang sangat cepat. Hardware GPU modern bisa menebak miliaran hash MD5 per detik. '
      'Selain itu, tanpa salt unik, hash mudah dibongkar dengan Rainbow Table database. '
      'Standar industri saat ini (seperti `Hash::make()` di Laravel) menggunakan Bcrypt atau Argon2id yang merupakan slow adaptive hashing algorithm. '
      'Kita bisa menaikkan work factor (cost) seiring bertambah kuatnya komputer peretas."',
    seniorTip: 'Sebutkan bahwa Bcrypt otomatis menghasilkan salt cryptographically-secure yang disertakan di dalam string hash (dimulai dengan `\$2y\$`), sehingga dua password yang sama menghasilkan hash berbeda.',
    optionExplanations: {
      0: '❌ Terbalik! MD5 justru terlalu cepat, bukan lambat.',
      1: '✅ Jawaban sangat komprehensif! Paham perbedaan fast hashing vs adaptive password hashing.',
      2: '❌ Keliru.',
      3: '❌ Tidak benar.',
    },
    keyKeywords: ['Adaptive KDF', 'Bcrypt', 'Argon2id', 'Salt', 'Rainbow Tables', 'Brute-force'],
  ),
];
