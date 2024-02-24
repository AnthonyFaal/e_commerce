import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  final List<Product> cartProducts;

  CartPage({required this.cartProducts});

  @override
  _CartPageState createState() => _CartPageState();
}

class Product {
  final String name;
  final double price;
  int quantity;

  Product({required this.name, required this.price, this.quantity = 1});
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    double totalAmount = 0;
    for (var product in widget.cartProducts) {
      totalAmount += product.price * product.quantity;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: ListView.builder(
        itemCount: widget.cartProducts.length,
        itemBuilder: (context, index) {
          Product product = widget.cartProducts[index];
          return Card(
            child: ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text(product.name),
              subtitle: Text('Price: \$${product.price.toStringAsFixed(2)}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        if (product.quantity > 1) {
                          product.quantity--;
                        }
                      });
                    },
                  ),
                  Text(product.quantity.toString()),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        product.quantity++;
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16.0),
        color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total: \$${totalAmount.toStringAsFixed(2)}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Implement the checkout logic here
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Order Placed'),
                    content: Text('Your order has been placed.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          // Close the dialog and navigate back to previous screen
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                        child: Text('OK'),
                      ),
                    ],
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                'Checkout',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
