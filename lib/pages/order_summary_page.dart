import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/order_cubit.dart';
import '../models/menu_model.dart'; // Pastikan model diimpor untuk tipe data

class OrderSummaryPage extends StatelessWidget {
  const OrderSummaryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // PENTING: Menggunakan BlocBuilder untuk merebuild UI saat state berubah
    return BlocBuilder<OrderCubit, Map<MenuModel, int>>(
      builder: (context, state) {
        final orderCubit = context.read<OrderCubit>();
        final subTotal = orderCubit.getTotalPrice();
        final bonusDiscount = orderCubit.getBonusDiscountValue();
        final finalPrice = orderCubit.getFinalPrice();

        if (state.isEmpty) {
          return const Center(child: Text('Keranjang kosong. Silakan pesan!'));
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Detail Pesanan:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              
              // Daftar Item Pesanan
              Expanded(
                child: ListView.builder(
                  // Mengambil key (MenuModel) dari state Map
                  itemCount: state.keys.length,
                  itemBuilder: (context, index) {
                    final menu = state.keys.elementAt(index);
                    final quantity = state[menu]!;
                    
                    return ListTile(
                      title: Text('${menu.name} x $quantity'),
                      subtitle: Text('Harga/item: Rp${menu.getDiscountedPrice()}'),
                      trailing: Text('Rp${menu.getDiscountedPrice() * quantity}'),
                    );
                  },
                ),
              ),

              const Divider(),
              
              // Ringkasan Harga
              _buildPriceRow('Subtotal (setelah diskon item)', subTotal, Colors.black),
              
              // C. Bonus: Diskon Total Transaksi
              _buildPriceRow(
                'Diskon Bonus (10% jika > Rp100.000)',
                -bonusDiscount, // Tampilkan nilai negatif
                Colors.red
              ),
              
              const Divider(thickness: 2),
              
              // Total Akhir
              _buildPriceRow('Total Akhir', finalPrice, Colors.green.shade700, isBold: true),

              const SizedBox(height: 16),
              
              // Tombol Clear Order
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: orderCubit.clearOrder,
                  icon: const Icon(Icons.delete_forever),
                  label: const Text('Clear Order'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  
  Widget _buildPriceRow(String label, double amount, Color color, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
          ),
          Text(
            // Menggunakan .round() untuk menampilkan harga sebagai integer
            'Rp${amount.round()}', 
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}