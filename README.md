Aplikasi Kasir Mobile - Ujian Tengah Semester

Nama: Sofyan Maulana
NIM: 23552011379

1. Bagian A - Jawaban Teori (30 Poin)

1.1. State Management dengan Cubit dan Diskon Dinamis (10 Poin)

Cubit (dari pustaka Bloc) membantu pengelolaan transaksi dengan logika diskon dinamis karena:

Pemisahan Logika: Logika bisnis (perhitungan diskon per item di MenuModel dan diskon total di OrderCubit) diisolasi dari UI.

State Terpusat: Status keranjang disimpan terpusat di OrderCubit. Setiap perubahan (tambah/hapus) memicu perhitungan ulang harga total dan diskon bonus (jika total $\ge$ Rp100.000).

Pembaruan Otomatis: Widget di order_summary_page.dart menggunakan BlocBuilder untuk mendengarkan state baru, memastikan tampilan selalu mencerminkan harga akhir yang sudah dikurangi diskon dinamis.

1.2. Perbedaan Diskon per Item dan Diskon Total Transaksi (10 Poin)

Kriteria

Diskon per Item

Diskon Total Transaksi

Penerapan

Diterapkan pada harga satuan setiap item.

Diterapkan pada subtotal seluruh pesanan.

Implementasi

Logika berada di MenuModel.getDiscountedPrice().

Logika berada di OrderCubit.getBonusDiscountValue() dan getFinalPrice().

Contoh Kasus

Item A memiliki diskon 10% terlepas dari total belanja.

Total belanja $\ge$ Rp100.000, maka seluruh subtotal diskon 10%.

1.3. Manfaat Penggunaan Widget Stack pada Tampilan Kategori Menu (10 Poin)

Widget Stack di category_stack_page.dart digunakan untuk menumpuk elemen visual:

Indikator Aktif: Menempatkan ikon cek atau badge di atas kartu kategori untuk menandai kategori yang sedang aktif (dipilih), memberikan umpan balik visual yang jelas.

Overlay Visual: Memungkinkan penempatan teks atau elemen UI lain di atas gambar atau latar belakang kartu kategori.

2. Bagian B & C - Implementasi Proyek

Proyek ini diimplementasikan menggunakan Flutter dengan state management Cubit dan mengikuti struktur folder yang ditentukan.

File

Fungsi

menu_model.dart

Mendefinisikan data item menu dan metode getDiscountedPrice() (diskon per item).

order_cubit.dart

Mengelola state keranjang pesanan (Map<MenuModel, int>). Menyediakan fungsi addToOrder(), removeFromOrder(), updateQuantity(), clearOrder(), dan logika perhitungan total.

menu_card.dart

Menampilkan detail menu, harga asli/diskon, dan tombol addToOrder() yang memanggil Cubit.

category_stack_page.dart

Menampilkan kategori menu dengan Stack untuk indikator aktif dan menggunakan GridView.builder untuk menampilkan MenuCard.

order_summary_page.dart

Mendengarkan state OrderCubit menggunakan BlocBuilder dan menampilkan rincian pesanan.

Implementasi Diskon Bonus (Bagian C)

Fitur diskon total transaksi 10% jika total belanja $\ge$ Rp100.000 diimplementasikan di:

order_cubit.dart: Dua metode baru ditambahkan:

getBonusDiscountValue(): Menghitung nilai diskon 10% jika syarat terpenuhi, jika tidak, mengembalikan 0.

getFinalPrice(): Mengembalikan harga akhir (Subtotal - BonusDiscount).

order_summary_page.dart: Halaman ini menggunakan nilai dari ketiga fungsi total (getTotalPrice, getBonusDiscountValue, getFinalPrice) untuk menampilkan subtotal, baris diskon bonus, dan total akhir yang harus dibayar.
