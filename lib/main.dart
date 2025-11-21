import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/order_cubit.dart';
import 'pages/order_home_page.dart';
import 'pages/order_summary_page.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Menyediakan OrderCubit agar dapat diakses oleh semua widget
    return BlocProvider<OrderCubit>( 
      create: (context) => OrderCubit(),
      child: MaterialApp(
        title: 'Aplikasi Kasir UTB',
        theme: ThemeData(
          // Menggunakan skema warna yang lebih modern
          primarySwatch: Colors.blue,
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(
            secondary: Colors.amber, // Warna aksen untuk diskon/penanda
          ),
          fontFamily: 'Inter',
          appBarTheme: const AppBarTheme(
            elevation: 0,
            centerTitle: true,
            titleTextStyle: TextStyle(
              color: Colors.white, 
              fontSize: 20, 
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Kasir UTB'),
          backgroundColor: Theme.of(context).colorScheme.primary,
          bottom: TabBar(
            // Gaya TabBar yang menonjolkan tab aktif
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(
                width: 4.0, 
                color: Theme.of(context).colorScheme.secondary 
              ),
            ),
            labelColor: Theme.of(context).colorScheme.secondary, 
            unselectedLabelColor: Colors.white70, 
            labelStyle: const TextStyle(fontWeight: FontWeight.bold),
            tabs: const [
              Tab(text: 'MENU PESANAN', icon: Icon(Icons.restaurant_menu)),
              Tab(text: 'RINGKASAN', icon: Icon(Icons.receipt)),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            OrderHomePage(),       
            OrderSummaryPage(),
          ],
        ),
      ),
    );
  }
}