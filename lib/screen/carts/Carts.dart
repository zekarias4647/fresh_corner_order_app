import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'checkout.dart';

class CartScreen extends StatefulWidget {
 @override
 _CartScreenState createState() => _CartScreenState();
}

class CartItem {
 final String name;
 final String description;
 final double price;
 final String image;
 int quantity;

 CartItem(this.name, this.description, this.price, this.image, this.quantity);

 double totalPrice() {
  return price * quantity;
 }
}

class _CartScreenState extends State<CartScreen> {
 List<CartItem> items = [
  CartItem("Product 1", "Description 1", 29.99, "asset/image/baby-carrots.jpg", 2),
  CartItem("Product 2", "Description 2", 39.99, "asset/image/slide-raw-pork-white-background.jpg", 1),
  CartItem("Product 3", "Description 3", 49.99, "asset/image/4652.jpg", 3),
 ];

 @override
 Widget build(BuildContext context) {
  return Scaffold(
   appBar: AppBar(
    title: Text('Shopping Cart'),
    centerTitle: true,
   ),
   body: Container(
    decoration: BoxDecoration(
     gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colors.white, Colors.grey.shade300],
     ),
    ),
    child: Column(
     children: [
      Expanded(
       child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
         return CartItemCard(
          cartItem: items[index],
          onRemove: () {
           removeItem(index);
          },
          onUpdateQuantity: (newQuantity) {
           updateQuantity(index, newQuantity);
          },
          onTap: () {
           _navigateToProductDetails(context, items[index]);
          },
         );
        },
       ),
      ),
      _buildTotalPrice(),
      _buildCheckoutButton(),
     ],
    ),
   ),
 
  );
 }

 Widget _buildTotalPrice() {
  double totalPrice = items.fold(0, (sum, item) => sum + item.totalPrice());
  return Container(
   padding: EdgeInsets.all(16.0),
   color: Colors.red.withOpacity(1),
   child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
     Text(
      'Total:',
      style: TextStyle(
       color: Colors.white,
       fontSize: 18.0,
       fontWeight: FontWeight.bold,
      ),
     ),
     Text(
      '\$${totalPrice.toStringAsFixed(2)}',
      style: TextStyle(
       color: Colors.white,
       fontSize: 18.0,
       fontWeight: FontWeight.bold,
      ),
     ),
    ],
   ),
  );
 }

 Widget _buildCheckoutButton() {
  return Container(
   margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
   height: 50.0,
   child: ElevatedButton(
    onPressed: () {
     Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CheckoutScreen(items: [],)));
     _showCheckoutSnackbar();
    },
    style: ElevatedButton.styleFrom(
     primary: Colors.green,
     shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25.0),
     ),
    ),
    child: Text(
     'Proceed to Checkout',
     style: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
     ),
    ),
   ),
  );
 }

 void _showCheckoutSnackbar() {
  double totalPrice = items.fold(0, (sum, item) => sum + item.totalPrice());
  ScaffoldMessenger.of(context).showSnackBar(
   SnackBar(
    content: Text('Checkout complete. Total: \$${totalPrice.toStringAsFixed(2)}'),
    duration: Duration(seconds: 2),
    action: SnackBarAction(
     label: 'Close',
     onPressed: () {},
    ),
   ),
  );
 }

 void _navigateToProductDetails(BuildContext context, CartItem cartItem) {
  Navigator.of(context).push(
   MaterialPageRoute(
    builder: (context) => ProductDetailsScreen(cartItem: cartItem),
   ),
  );
 }

 void addItem(CartItem newItem) {
  setState(() {
   items.add(newItem);
  });
 }

 void removeItem(int index) {
  setState(() {
   items.removeAt(index);
  });
 }

 void updateQuantity(int index, int newQuantity) {
  setState(() {
   items[index].quantity = newQuantity;
  });
 }
}

class CartItemCard extends StatelessWidget {
 final CartItem cartItem;
 final VoidCallback onRemove;
 final Function(int) onUpdateQuantity;
 final VoidCallback onTap;

 CartItemCard({
  required this.cartItem,
  required this.onRemove,
  required this.onUpdateQuantity,
  required this.onTap,
 });

 @override
 Widget build(BuildContext context) {
  return GestureDetector(
   onTap: onTap,
   child: Card(
    color: Colors.green,
    elevation: 5,
    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    shape: RoundedRectangleBorder(
     borderRadius: BorderRadius.circular(15.0),
    ),
    child: ListTile(
     contentPadding: EdgeInsets.all(20),
     leading: Hero(
      tag: 'product-image-${cartItem.image}',
      child: ClipRRect(
       borderRadius: BorderRadius.circular(15.0),
       child: Image.asset(
        cartItem.image, // Assuming 'cartItem.image' is the asset path
        width: 60.0,
        height: 60.0,
        fit: BoxFit.cover,
       ),
      ),
     ),
     title: Text(
      cartItem.name,
      style: TextStyle(color: Colors.white),
     ),
     subtitle: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       Text(
        cartItem.description,
        style: TextStyle(color: Colors.white),
       ),
       SizedBox(height: 5),
       Text(
        'Price: \$${cartItem.price.toStringAsFixed(2)}',
        style: TextStyle(color: Colors.red),
       ),
      ],
     ),
     trailing: SingleChildScrollView(
       child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
         Row(
          mainAxisSize: MainAxisSize.min,
          children: [
           IconButton(
            icon: Icon(Icons.remove),
            onPressed: () {
             if (cartItem.quantity > 1) {
              onUpdateQuantity(cartItem.quantity - 1);
             }
            },
           ),
           Text('${cartItem.quantity}', style: TextStyle(color: Colors.white)),
           IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
             onUpdateQuantity(cartItem.quantity + 1);
            },
           ),
          ],
         ),

         IconButton(
          icon: Icon(Icons.remove_circle),
          color: Colors.red,
          onPressed: onRemove,
         ),
        ],
       ),
     ),
    ),
   ),
  );
 }
}

class ProductDetailsScreen extends StatefulWidget {
 final CartItem cartItem;

 ProductDetailsScreen({required this.cartItem});

 @override
 State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();

}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
 @override
 Widget build(BuildContext context) {
  return Scaffold(
   appBar: AppBar(
    title: Text('Product Details'),
    centerTitle: true,
   ),
   body: Container(

    decoration: BoxDecoration(
     gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colors.green, Colors.green.shade100],
     ),
    ),
    child: Center(
     child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
       Hero(
        tag: 'product-image-${widget.cartItem.image}',
        child: ClipRRect(
         borderRadius: BorderRadius.circular(15.0),
         child: Image.asset(
          widget.cartItem.image, // Assuming 'cartItem.image' is the asset path
          width: 250.0,
          height: 250.0,
          fit: BoxFit.cover,
         ),
        ),
       ),
       SizedBox(height: 20.0),
       Text(
        widget.cartItem.name,
        style: TextStyle(
         fontSize: 24.0,
         fontWeight: FontWeight.bold,
         color: Colors.white,
        ),
       ),
       SizedBox(height: 10.0),
       Text(
        'Price: \$${widget.cartItem.price.toStringAsFixed(2)}',
        style: TextStyle(
         fontSize: 18.0,
         color: Colors.grey,
        ),
       ),
       SizedBox(height: 10.0),
       Text(
        widget.cartItem.description,
        textAlign: TextAlign.center,
        style: TextStyle(
         fontSize: 16.0,
         color: Colors.white,
        ),
       ),
      ],
     ),
    ),
   ),
  );
 }
}
class Order {
 final List<CartItem> items;
 final String branch;
 final DateTime pickupTime;

 Order({
  required this.items,
  required this.branch,
  required this.pickupTime,
 });
}
