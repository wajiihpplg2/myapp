import 'package:flutter/material.dart';
import 'logins.dart'; // Pastikan file logins.dart ada

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Proyek Kustom',
      debugShowCheckedModeBanner: false, // Menonaktifkan debug banner
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 1, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              width: 250,
              height: 250,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'FOODGO',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              child: const Text('Get Started'),
            ),
          ],
        ),
      ),
    );
  }
}

class Product {
  final String name;
  final String description;
  final String imageUrl;
  final List<String> sizes;
  final double price;
  final double rating;
  int quantity;
  double totalPrice;
  bool isSelected;
  bool isCheckBoxCart;
  Map<String, int> sizeQuantities;

  Product({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.sizes,
    required this.price,
    required this.rating,
    this.quantity = 1,
    this.isSelected = false,
    this.isCheckBoxCart = false,
    Map<String, int>? sizeQuantities,
  })  : assert(sizes.isNotEmpty, 'Sizes list cannot be empty'),
        sizeQuantities = sizeQuantities ?? {sizes.first: 1},
        totalPrice = price * (sizeQuantities?[sizes.first] ?? 1);

  void updateQuantity(String size, int newQuantity) {
    if (sizeQuantities.containsKey(size)) {
      sizeQuantities[size] = newQuantity;
      recalculateTotalPrice();
    }
  }

  void recalculateTotalPrice() {
    totalPrice = sizeQuantities.entries
        .map((entry) => price * entry.value)
        .reduce((a, b) => a + b);
  }
}
