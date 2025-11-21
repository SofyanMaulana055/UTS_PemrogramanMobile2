// lib/pages/order_home_page.dart
import 'package:flutter/material.dart';
import 'category_stack_page.dart'; // Import halaman kategori yang sudah dibuat

class OrderHomePage extends StatelessWidget {
  const OrderHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Halaman ini berfungsi sebagai kontainer utama untuk tampilan menu dan kategori
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilih Menu Pesanan'),
        automaticallyImplyLeading: false, // Karena ini mungkin di TabBar
      ),
      // Konten utama adalah tampilan kategori menu
      body: const CategoryStackPage(),
    );
  }
}