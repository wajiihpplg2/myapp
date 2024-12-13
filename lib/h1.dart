import 'package:flutter/material.dart';
import 'package:myapp/pay.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FoodGo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Order Your Favourite Food'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Map<String, dynamic>> _menuItems = [
    {
      'name': 'Sate Seafood',
      'category': 'MAKANAN',
      'rating': '4.9',
      'price': 10000,
      'image': 'assets/sateseafood.png'
    },
    {
      'name': 'Tempe Bacem Tahu Balem',
      'category': 'MAKANAN',
      'rating': '4.7',
      'price': 10000,
      'image': 'assets/tahubacemtempebacemnew.png'
    },
    {
      'name': 'Es Teh dan Es Jeruk',
      'category': 'MINUMAN',
      'rating': '4.8',
      'price': 5000,
      'image': 'assets/estehdanesjeruk.png'
    },
    {
      'name': 'Wedang Jahe',
      'category': 'MINUMAN',
      'rating': '4.5',
      'price': 5000,
      'image': 'assets/wedangjahe.png'
    },
  ];

  List<Map<String, dynamic>> _filteredItems = [];
  Map<String, int> _itemQuantities = {};
  List<Map<String, dynamic>> _cartItems = [];
  bool _isSelecting = false; // To toggle select mode for deleting items

  @override
  void initState() {
    super.initState();
    _filteredItems = _menuItems; // Start with all items visible
  }

  void _filterMenuItems(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredItems = _menuItems;
      } else {
        _filteredItems = _menuItems
            .where((item) =>
                item['name']!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  void _filterByCategory(String category) {
    setState(() {
      if (category == 'ALL') {
        _filteredItems = _menuItems;
      } else {
        _filteredItems =
            _menuItems.where((item) => item['category'] == category).toList();
      }
    });
  }

  void _increaseQuantity(String itemName) {
    setState(() {
      _itemQuantities[itemName] = (_itemQuantities[itemName] ?? 0) + 1;
    });
  }

  void _decreaseQuantity(String itemName) {
    setState(() {
      if ((_itemQuantities[itemName] ?? 0) > 0) {
        _itemQuantities[itemName] = (_itemQuantities[itemName] ?? 0) - 1;
      }
    });
  }

  void _addToCart(String itemName, int price) {
    setState(() {
      if (_itemQuantities[itemName] != null && _itemQuantities[itemName]! > 0) {
        _cartItems.add({
          'name': itemName,
          'quantity': _itemQuantities[itemName],
          'price': price,
          'isSelected': false, // Add a field for selection
        });
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$itemName added to cart')),
    );
  }

  void _toggleSelectItem(int index) {
    setState(() {
      _cartItems[index]['isSelected'] = !_cartItems[index]['isSelected'];
    });
  }

  // void _deleteSelectedItems() {
  //   setState(() {
  //     // Menghapus item yang isSelected == true
  //     _cartItems.removeWhere((item) => item['isSelected'] == true);
  //   });

  //   ScaffoldMessenger.of(context).showSnackBar(
  //     const SnackBar(content: Text('Selected items removed from cart')),
  //   );
  // }

  int get _cartItemCount {
    int count = 0;
    for (var item in _cartItems) {
      count += item['quantity'] != null ? item['quantity'] as int : 0;
    }
    return count;
  }

  int get _totalCartPrice {
    int total = 0;
    for (var item in _cartItems) {
      final int price = item['price'] ?? 0;
      final int quantity = item['quantity'] ?? 0;
      total += price * quantity;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              // Add functionality for user profile
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Text(
                  _cartItemCount.toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(
                    width: 4), // Add spacing between quantity and price
                Text(
                  ' - \$${_totalCartPrice}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: _showCart, // Show cart when clicked
          ),
          IconButton(
            icon: Icon(
                _isSelecting ? Icons.check_box : Icons.check_box_outline_blank),
            onPressed: () {
              setState(() {
                _isSelecting = !_isSelecting;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _isSelecting
                ? _deleteSelectedItems
                : null, // hanya aktif saat mode seleksi
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    onChanged: _filterMenuItems,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Search',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () => _filterByCategory('ALL'),
                      child: const Text('ALL'),
                    ),
                    ElevatedButton(
                      onPressed: () => _filterByCategory('MAKANAN'),
                      child: const Text('MAKANAN'),
                    ),
                    ElevatedButton(
                      onPressed: () => _filterByCategory('MINUMAN'),
                      child: const Text('MINUMAN'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return _buildMenuItem(
                  _filteredItems[index]['name']!,
                  _filteredItems[index]['rating']!,
                  _filteredItems[index]['image']!,
                  _filteredItems[index]['price']!,
                );
              },
              childCount: _filteredItems.length,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Jumlah kolom
              childAspectRatio: 0.8, // Rasio lebar/tinggi untuk setiap item
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
      String title, String rating, String imagePath, int price) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              imagePath,
              height: 100, // Kurangi tinggi gambar untuk memberi ruang
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              maxLines: 1, // Batasi jumlah baris teks
              overflow:
                  TextOverflow.ellipsis, // Teks yang panjang akan terpotong
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14, // Kurangi ukuran font
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 4.0), // Kurangi padding
            child: Text('Rating: $rating'),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 4.0), // Kurangi padding
            child: Text('Price: \$${price}'),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () => _decreaseQuantity(title),
                ),
                Text(
                  _itemQuantities[title]?.toString() ?? '0',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => _increaseQuantity(title),
                ),
                IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  onPressed: () => _addToCart(title, price),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _removeFromCart(String itemName) {
    setState(() {
      _cartItems.removeWhere((item) => item['name'] == itemName);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$itemName removed from cart')),
    );
  }

  void _showCart() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Your Cart'),
        content: _cartItems.isEmpty
            ? const Text('Your cart is empty.')
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min, // Menyesuaikan tinggi dialog
                children: _cartItems.map((cartItem) {
                  int price = cartItem['price'] ?? 0;
                  int quantity = cartItem['quantity'] ?? 0;
                  int totalPrice = price * quantity;

                  return ListTile(
                    leading: Checkbox(
                      value: cartItem['isSelected'] ?? false,
                      onChanged: (bool? selected) {
                        setState(() {
                          cartItem['isSelected'] = selected!;
                        });
                      },
                    ),
                    title: Text('${cartItem['name']} x$quantity'),
                    subtitle: Text('Price: \$${price}'),
                    trailing: Text('Total: \$${totalPrice}'),
                  );
                }).toList(),
              ),
        actions: [
          // Tombol Beli (di pojok kiri bawah)
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Thank you for your purchase!')),
              );
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PayPage(
                      cartItemsA: _cartItems, totalPrice: _totalCartPrice),
                ),
              );
            },
            child: const Text(
              'Buy',
              style: TextStyle(color: Colors.green),
            ),
          ),
          // Tombol Hapus (ikon sampah)
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _cartItems.any((item) => item['isSelected'] == true)
                ? _deleteSelectedItems
                : null, // Aktif hanya jika ada item yang dipilih
          ),
          // Tombol Tutup
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close'),
          ),
        ],
        actionsAlignment: MainAxisAlignment.spaceBetween, // Atur posisi tombol
      ),
    );
  }

// Fungsi untuk menghapus item yang dipilih (checkbox dicentang)
  void _deleteSelectedItems() {
    setState(() {
      // Menghapus item yang isSelected == true
      _cartItems.removeWhere((item) => item['isSelected'] == true);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Selected items removed from cart')),
    );

    // Menjaga dialog tetap terbuka
    // Dialog akan secara otomatis memperbarui karena kita memanggil setState
  }

// Fungsi untuk menghapus item yang dipilih (checkbox dicentang)
}
