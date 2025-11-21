import 'package:flutter/material.dart';
import '../models/menu_model.dart';
import '../widgets/menu_card.dart';

// Dummy Data untuk testing, ditambahkan imageURL
final List<MenuModel> menuList = [
  MenuModel(id: '1', name: 'Nasi Goreng', price: 25000, category: 'Makanan', discount: 0.0, 
      imageURL: 'https://asset.kompas.com/crops/VcgvggZKE2VHqIAUp1pyHFXXYCs=/202x66:1000x599/1200x800/data/photo/2023/05/07/6456a450d2edd.jpg'),
  MenuModel(id: '2', name: 'Es Teh Manis', price: 5000, category: 'Minuman', discount: 0.1, 
      imageURL: 'https://st2.depositphotos.com/1328914/8685/i/450/depositphotos_86859222-stock-photo-southern-sweet-tea.jpg'), // Diskon 10%
  MenuModel(id: '3', name: 'Mie Ayam', price: 20000, category: 'Makanan', discount: 0.0, 
      imageURL: 'https://assets.unileversolutions.com/recipes-v2/257956.jpg'),
  MenuModel(id: '4', name: 'Jus Alpukat', price: 15000, category: 'Minuman', discount: 0.0, 
      imageURL: 'https://www.shutterstock.com/image-photo/avocado-juice-milkshake-butter-fruit-600nw-2418862015.jpg'),
  MenuModel(id: '5', name: 'Puding Coklat', price: 10000, category: 'Dessert', discount: 0.0, 
      imageURL: 'https://www.shutterstock.com/image-photo/agar-coklat-chocolate-pudding-600nw-2371617107.jpg'),
  MenuModel(id: '6', name: 'Es Kopi Susu', price: 12000, category: 'Minuman', discount: 0.0, 
      imageURL: 'https://assets.unileversolutions.com/v1/2005891.jpg'),
];

class CategoryStackPage extends StatefulWidget {
  const CategoryStackPage({Key? key}) : super(key: key);

  @override
  State<CategoryStackPage> createState() => _CategoryStackPageState();
}

class _CategoryStackPageState extends State<CategoryStackPage> {
  String _activeCategory = 'Makanan'; // State lokal

  @override
  Widget build(BuildContext context) {
    final List<String> categories = ['Makanan', 'Minuman', 'Dessert'];
    final filteredMenu = menuList.where((m) => m.category == _activeCategory).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            spacing: 8.0,
            children: categories.map((cat) => _buildCategoryCard(cat)).toList(),
          ),
        ),
        
        const Divider(),

        // Daftar Menu yang Sesuai
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.1, // Dibuat lebih tinggi untuk menampung gambar
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: filteredMenu.length,
            itemBuilder: (context, index) {
              return MenuCard(menu: filteredMenu[index]);
            },
          ),
        ),
      ],
    );
  }
  
  // Widget kategori menggunakan Stack (tidak diubah dari sebelumnya)
  Widget _buildCategoryCard(String categoryName) {
    final bool isActive = categoryName == _activeCategory;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _activeCategory = categoryName; 
        });
      },
      child: Container(
        height: 80,
        width: 100,
        decoration: BoxDecoration(
          color: isActive ? Colors.blue.shade100 : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            Center(
              child: Text(
                categoryName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isActive ? Colors.blue.shade900 : Colors.black87,
                ),
              ),
            ),
            if (isActive)
              const Positioned(
                top: 4,
                right: 4,
                child: Icon(Icons.check_circle, color: Colors.blue, size: 18),
              ),
          ],
        ),
      ),
    );
  }
}