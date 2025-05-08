import 'package:flutter/material.dart';

void main() {
  runApp(MobileStoreApp());
}

class MobileStoreApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Phone Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.grey.shade100,
      ),
      home: PhoneListPage(),
    );
  }
}

// Updated phone list with image paths
final List<Map<String, dynamic>> phones = [
  { 'name': 'iPhone 15 Pro', 'price': 1349.00, 'image': 'assets/images/iphone15pro.jpg' },
  { 'name': 'Samsung Galaxy S24', 'price': 1249.99, 'image': 'assets/images/samsungs24.jpg' },
  { 'name': 'Google Pixel 8', 'price': 999.49, 'image': 'assets/images/googlepixel8.jpg' },
  { 'name': 'OnePlus 12R', 'price': 749.00, 'image': 'assets/images/oneplus12r.jpg' },
  { 'name': 'Nothing Phone (2)', 'price': 799.00, 'image': 'assets/images/nothingphone2.jpg' },
  { 'name': 'Asus ROG Phone 7', 'price': 1099.00, 'image': 'assets/images/asusrog7.jpg' },
  { 'name': 'Xiaomi 13 Pro', 'price': 899.00, 'image': 'assets/images/xiomi13pro.jpg' },
  { 'name': 'Huawei P60 Pro', 'price': 999.00, 'image': 'assets/images/huaweipro.jpg' },
];

List<Map<String, dynamic>> cartItems = [];

class PhoneListPage extends StatefulWidget {
  const PhoneListPage({Key? key}) : super(key: key);

  @override
  State<PhoneListPage> createState() => _PhoneListPageState();
}

class _PhoneListPageState extends State<PhoneListPage> {
  void addToCart(Map<String, dynamic> phone) {
    setState(() {
      cartItems.add(phone);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${phone['name']} added to cart"),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void openCart() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CartPage()),
    ).then((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Phone Point "),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: openCart,
          )
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: phones.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, i) {
          final phone = phones[i];
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 5,
                  color: Colors.black12,
                  offset: Offset(0, 2),
                )
              ],
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  phone['image'],
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                phone['name'],
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "\$${phone['price']}",
                style: const TextStyle(color: Colors.grey),
              ),
              trailing: ElevatedButton(
                onPressed: () => addToCart(phone),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue, // Light blue color here
                ),
                child: const Text("Add"),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  void removeFromCart(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  double getTotal() {
    return cartItems.fold(0.0, (sum, item) => sum + (item['price'] as double));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Cart")),
      body: cartItems.isEmpty
          ? const Center(child: Text("Your cart is empty."))
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, i) {
                final item = cartItems[i];
                return ListTile(
                  title: Text(item['name']),
                  subtitle: Text("\$${item['price']}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => removeFromCart(i),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              "Total: \$${getTotal().toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
