import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/menu_model.dart';
import '../blocs/order_cubit.dart';

class MenuCard extends StatelessWidget {
  final MenuModel menu;
  
  const MenuCard({Key? key, required this.menu}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderCubit = context.read<OrderCubit>();

    return Card(
      elevation: 4, // Efek bayangan
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Bagian Gambar
          Expanded(
            flex: 2,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.network(
                menu.imageURL,
                fit: BoxFit.cover,
                width: double.infinity,
                // Handle error jika gambar gagal dimuat
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey.shade200,
                    child: const Center(
                      child: Icon(Icons.broken_image, color: Colors.grey, size: 40),
                    ),
                  );
                },
              ),
            ),
          ),

          // 2. Bagian Detail Teks dan Tombol
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(menu.name, 
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    maxLines: 1, 
                    overflow: TextOverflow.ellipsis),
                
                const SizedBox(height: 4),
                
                // Harga Asli (Gunakan warna/teks berbeda dan dicoret)
                if (menu.discount > 0)
                  Text(
                    'Rp${menu.price}',
                    style: const TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                
                // Harga Setelah Diskon (Gunakan warna/teks berbeda)
                Text(
                  'Rp${menu.getDiscountedPrice()}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: menu.discount > 0 ? Colors.red.shade700 : Colors.green.shade700, 
                  ),
                ),
                
                const SizedBox(height: 8),

                // Tombol untuk menambah pesanan yang memanggil addToOrder()
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      orderCubit.addToOrder(menu);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${menu.name} ditambahkan!'),
                          duration: const Duration(milliseconds: 500),
                        )
                      );
                    },
                    child: const Text('Add', style: TextStyle(fontSize: 12)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}