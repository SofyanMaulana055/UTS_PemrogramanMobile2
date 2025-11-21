import 'package:equatable/equatable.dart';

class MenuModel extends Equatable {
  final String id;
  final String name;
  final int price;
  final String category;
  final double discount; // 0.0 sampai 1.0
  final String imageURL; // Properti baru untuk URL gambar

  MenuModel({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.imageURL, // Wajib diisi
    this.discount = 0.0,
  });

  // Metode B.2: Mengembalikan harga setelah diskon per item
  int getDiscountedPrice() {
    double discountedPrice = price * (1.0 - discount);
    return discountedPrice.round(); 
  }

  @override
  // Tambahkan imageURL ke props
  List<Object?> get props => [id, name, price, category, discount, imageURL];
}