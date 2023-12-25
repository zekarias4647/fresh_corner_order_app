import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

import '../carts/Carts.dart';

class ProductScreen extends StatefulWidget {
  final String productName;
  final String categoryName;
  final String productImage;
  final double initialProductPrice; // Assuming you have an initial product price
  final double Kilogram; // Assuming you have an initial product price

  ProductScreen({
    required this.initialProductPrice,
    required this.productName,
    required this.productImage,
    required this.Kilogram,
    required this.categoryName,
  });



  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  double kilograms = 1;
  late double currentProductPrice;
  ProductScreen({required double initialProductPrice}) {
    currentProductPrice = initialProductPrice;
  }
  @override
  void initState() {
    super.initState();
    currentProductPrice = widget.initialProductPrice;
  }


  List<Map<String, dynamic>> products = [
    {
      'name': 'Product 1',
      'kg': '1 kg',
      'price': 10.0,
      'image': 'asset/image/chopped-raw-meat-process-preparing-forcemeat-by-means-meat-grinder-homemade-sausage-ground-beef-top-view.jpg', // Add the image path for Product 1
    },
    {
      'name': 'Product 2',
      'kg': '0.5 kg',
      'price': 5.0,
      'image': 'asset/image/front-view-cinnamon-mint-alogn-with-fresh-tea-white-ingredients-spices-color.jpg', // Add the image path for Product 2
    },
    {
      'name': 'Product 2',
      'kg': '0.5 kg',
      'price': 5.0,
      'image': 'asset/image/baby-carrots.jpg', // Add the image path for Product 2
    },
    // Add more products as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          widget.categoryName,
          style: TextStyle(fontFamily: 'YourCustomFont', fontSize: 24, fontWeight: FontWeight.bold),

        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search,color: Colors.white,),
            onPressed: () {
              // Handle search action
            },
          ),
          IconButton(
            icon: Icon(Icons.sort,color: Colors.white,),
            onPressed: () {
              // Handle sort action
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart,color: Colors.white,),
            onPressed: () {
              // Navigate to the cart screen
              Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen())); 
            },
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.green,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildSubCategoryRow(),
          ),
          _buildProductList(),
        ],
      ),
    );
  }

  Widget _buildSubCategoryRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildSubCategoryButton('All Category', Icons.category, Colors.blue),
          _buildSubCategoryButton('Vegetable', Icons.local_florist, Colors.green),
          _buildSubCategoryButton('Fruits', Icons.local_florist, Colors.orange),
          _buildSubCategoryButton('Fruits', Icons.local_florist, Colors.orange),
        ],
      ),
    );
  }

  Widget _buildSubCategoryButton(String subCategoryName, IconData iconData, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: () {
          // Handle sub-category selection
          // You can filter the products based on the selected sub-category
        },
        child: Hero(
          tag: subCategoryName,
          child: GlassmorphicContainer(
            width: 120.0,
            height: 100.0,
            borderRadius: 10.0,
            blur: 20,
            alignment: Alignment.center,
            border: 2,
            linearGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white.withOpacity(0.1), Colors.white.withOpacity(0.05)],
            ),
            borderGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [color.withOpacity(0.5), color.withOpacity(0.2)],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  iconData,
                  color: color,
                  size: 36,
                ),
                SizedBox(height: 8.0),
                Text(
                  subCategoryName,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
                    fontFamily: 'YourCustomFont',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductList() {
    return Expanded(
      child: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return FadeInAnimation(
            delay: Duration(milliseconds: 200 * index),
            child: _buildProductCard(products[index]),
          );
        },
      ),
    );
  }
  Widget _buildProductCard(Map<String, dynamic> product) {
    int quantity = product['quantity'] ?? 0; // Use null-aware operator to handle null

    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        color: Color(0xFF4CAF50),
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.all(16.0),
          title: Text(
            product['name'] ?? '',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            'Price: \$${currentProductPrice.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              product['image'] ?? 'asset/image/basket-full-vegetables.jpg',
              width: 80.0,
              height: 80.0,
              fit: BoxFit.cover,
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  setState(() {
                    kilograms++;
                    currentProductPrice =
                        widget.initialProductPrice * kilograms;
                  });
                },
              ),
            ],
          ),
          onTap: () {
            // Handle product tap
            // You can navigate to a product details screen or show a dialog
          },
        ),
      ),
    );
  }


  void _updateTotal(Map<String, dynamic> product, int quantity) {
    double totalPrice = product['price'] * quantity;
    print('Total Price for ${product['name']}: \$${totalPrice.toStringAsFixed(2)}');
    // You can use the totalPrice as needed, for example, updating a shopping cart total.
  }


}

class FadeInAnimation extends StatelessWidget {
  final Widget child;
  final Duration delay;

  const FadeInAnimation({Key? key, required this.child, required this.delay})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      key: ValueKey(delay),
      // Use ValueKey to uniquely identify each animation
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 500),
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0.0, (1.0 - value) * 20),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
