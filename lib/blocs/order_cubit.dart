import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/menu_model.dart';

// State: Map yang berisi item menu dan kuantitasnya {MenuModel: quantity}
class OrderCubit extends Cubit<Map<MenuModel, int>> {
  OrderCubit() : super({});

  // 1. Tambah pesanan (memastikan emit terjadi)
  void addToOrder(MenuModel menu) {
    // 1. Ambil state saat ini
    final Map<MenuModel, int> currentOrder = Map.from(state);
    
    // 2. Update kuantitas atau tambahkan item baru
    currentOrder.update(
      menu, 
      (value) => value + 1, 
      ifAbsent: () => 1
    );
    
    // 3. Memancarkan state baru (PENTING)
    emit(currentOrder);
    
    // Opsional: Cek di console apakah fungsi terpanggil
    print('Item ditambahkan: ${menu.name}. Total item: ${currentOrder.length}');
  }

  // 2. Hapus pesanan (semua kuantitas)
  void removeFromOrder(MenuModel menu) {
    final Map<MenuModel, int> currentOrder = Map.from(state);
    currentOrder.remove(menu);
    emit(currentOrder);
  }

  // 3. Update kuantitas item
  void updateQuantity(MenuModel menu, int qty) {
    final Map<MenuModel, int> currentOrder = Map.from(state);

    if (qty <= 0) {
      currentOrder.remove(menu);
    } else if (currentOrder.containsKey(menu)) {
      currentOrder[menu] = qty;
    }

    emit(currentOrder);
  }
  
  // 4. Hitung subtotal (total harga item setelah diskon per item)
  double getTotalPrice() {
    double total = 0.0;
    state.forEach((menu, quantity) {
      total += menu.getDiscountedPrice() * quantity;
    });
    return total;
  }
  
  // 5. Bonus: Hitung Diskon Total Transaksi (10% jika >= Rp100.000)
  double getBonusDiscountValue() {
    final double subTotal = getTotalPrice();
    if (subTotal >= 100000.0) {
      return subTotal * 0.10;
    }
    return 0.0;
  }
  
  // 6. Bonus: Hitung Harga Akhir
  double getFinalPrice() {
    final double subTotal = getTotalPrice();
    final double bonusDiscount = getBonusDiscountValue();
    return subTotal - bonusDiscount;
  }

  // 7. Menghapus semua pesanan
  void clearOrder() {
    emit({});
  }
}