import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyBagScreen(),
    );
  }
}

class MyBagScreen extends StatefulWidget {
  @override
  _MyBagScreenState createState() => _MyBagScreenState();
}

class _MyBagScreenState extends State<MyBagScreen> {
  List<CartItem> cartItems = [
    CartItem(
      name: 'Shoes',
      price: 100,
      quantity: 1,
      imageUrl: 'https://fastly.picsum.photos/id/21/3008/2008.jpg?hmac=T8DSVNvP-QldCew7WD4jj_S3mWwxZPqdF0CNPksSko4',
    ),
    CartItem(
      name: 'Sunglasses',
      price: 20,
      quantity: 1,
      imageUrl: 'https://fastly.picsum.photos/id/64/4326/2884.jpg?hmac=9_SzX666YRpR_fOyYStXpfSiJ_edO3ghlSRnH2w09Kg',
    ),
    CartItem(
      name: 'Camera',
      price: 300,
      quantity: 1,
      imageUrl: 'https://fastly.picsum.photos/id/628/2509/1673.jpg?hmac=TUdtbj7l4rQx5WGHuFiV_9ArjkAkt6w2Zx8zz-aFwwY',
    ),
  ];

  int totalAmount = 420;

  void updateTotalAmount() {
    int total = 0;
    for (var item in cartItems) {
      total += item.price * item.quantity;
    }
    setState(() {
      totalAmount = total;
    });
  }

  void increaseQuantity(int index) {
    setState(() {
      cartItems[index].quantity++;
      updateTotalAmount();
    });
  }

  void decreaseQuantity(int index) {
    if (cartItems[index].quantity > 1) {
      setState(() {
        cartItems[index].quantity--;
        updateTotalAmount();
      });
    }
  }

  void checkout() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Congratulations! Your order has been placed.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Bag'),
      ),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.network(cartItems[index].imageUrl),
            title: Text(cartItems[index].name),
            subtitle: Text('\$${cartItems[index].price}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () => decreaseQuantity(index),
                ),
                Text(cartItems[index].quantity.toString()),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => increaseQuantity(index),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total: \$${totalAmount.toString()}'),
              ElevatedButton(
                onPressed: checkout,
                child: Text('CHECK OUT'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CartItem {
  final String name;
  final int price;
  int quantity;
  final String imageUrl;

  CartItem({
    required this.name,
    required this.price,
    required this.quantity,
    required this.imageUrl,
  });
}
