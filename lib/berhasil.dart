import 'package:flutter/material.dart';
import 'h1.dart';

void main() {
  runApp(MyApps());
}

class MyApps extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Menghilangkan label debug
      home: PaymentSuccessScreen(),
    );
  }
}

class PaymentSuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyApp(),
              ),
            )
          },
        ),
      ),
      backgroundColor: Colors.grey[200], // Warna latar belakang layar
      body: Center(
        child: Container(
          width: 300, // Lebar kotak kontainer
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:
                BorderRadius.circular(15), // Membulatkan sudut kontainer
            boxShadow: [
              BoxShadow(
                color: Colors.black26, // Warna bayangan
                blurRadius: 10, // Tingkat blur untuk bayangan
                offset: Offset(0, 4), // Posisi bayangan
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Ukuran kolom menyesuaikan isi
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.red, // Warna lingkaran
                  shape: BoxShape.circle, // Membuat bentuk lingkaran
                ),
                padding: const EdgeInsets.all(20), // Padding dalam lingkaran
                child: Icon(
                  Icons.check, // Ikon centang
                  color: Colors.white,
                  size: 50, // Ukuran ikon
                ),
              ),
              const SizedBox(height: 20), // Spasi antara ikon dan teks
              Text(
                'Success !',
                style: TextStyle(
                  fontSize: 22, // Ukuran font
                  fontWeight: FontWeight.bold,
                  color: Colors.red, // Warna teks
                ),
              ),
              const SizedBox(height: 10), // Spasi antara judul dan deskripsi
              Text(
                'Your payment was successful.\nA receipt for this purchase has been sent to your email.',
                textAlign: TextAlign.center, // Teks rata tengah
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87, // Warna teks deskripsi
                ),
              ),
              const SizedBox(height: 30), // Spasi sebelum tombol
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Warna tombol
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(5), // Membulatkan sudut tombol
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                ),
                onPressed: () {
                  Navigator.pop(context); // Aksi saat tombol ditekan
                },
                child: Text(
                  'Go back',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Warna teks tombol
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
