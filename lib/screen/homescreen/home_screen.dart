import 'package:carousel_slider/carousel_slider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'package:glassmorphism/glassmorphism.dart';

import '../Products/category.dart';
import '../Products/products.dart';
import '../Scan & Pick/Scan_&_Pick.dart';
import '../carts/Carts.dart';
import '../orders/Orders.dart';
import '../profile/profile.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    HomeScreenContent(),
    ProductScreen(categoryName: '', initialProductPrice: 12, productName: '', productImage: '', Kilogram: 12,),
    CartScreen(),
    Orders(),
    ProfileScreen(),
    QRScanScreen(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: _buildCurvedNavigationBar(),
    );
  }


  Widget _buildCurvedNavigationBar() {
    return CurvedNavigationBar(
      index: _currentIndex,
      height: 65.0,
      items: <Widget>[
        Icon(Icons.home, size: 30,color: Colors.white,),
        Icon(Icons.explore, size: 30,color: Colors.white,),
        Icon(Icons.shopping_cart, size: 30,color: Colors.white,),
        Icon(Icons.request_quote_outlined, size: 30,color: Colors.white,),
        Icon(Icons.person, size: 30,color: Colors.white,),
        Icon(Icons.qr_code_scanner, size: 30,color: Colors.white,),
      ],
      color: Color(0xFF4CAF50),
      buttonBackgroundColor: Color(0xFF4CAF50),
      backgroundColor: Colors.white,
      animationCurve: Curves.easeInOutQuint,
      animationDuration: Duration(milliseconds: 300),
      onTap: (index) {
        if (index == 0) {}
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }
}


class HomeScreenContent extends StatefulWidget {
  const HomeScreenContent({Key? key}) : super(key: key);

  @override
  _HomeScreenContentState createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<HomeScreenContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [ // Top Row with Search Bar and Notification Icon
            _buildTopRow(),
            SizedBox(height: 30.0),
            // Carousel Image Slide
            _buildCarouselSlider(),
            SizedBox(height: 30.0),
            Text("Category",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),// Categories of Products
            _buildCategories(),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProductScreen(categoryName: '', initialProductPrice: 0, productName: '', productImage: '', Kilogram: 0,)),
                  );    // Your onPressed logic here
                },
                style: TextButton.styleFrom(
                  backgroundColor: Color(0xFF4CAF50), // Change the background color to your desired color
                  padding: EdgeInsets.symmetric(horizontal: 16.0), // Adjust the padding as needed
                  alignment: Alignment.center, // Align text to the right
                ),
                child: Text(
                  "View All",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                    color: Colors.white, // Change the text color to your desired color
                  ),
                ),
              ),
            ),
            Text("Products",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),// Products and Prices
            _buildProductRow(),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {
                  // Your onPressed logic here
                },
                style: TextButton.styleFrom(
                  backgroundColor: Color(0xFF4CAF50), // Change the background color to your desired color
                  padding: EdgeInsets.symmetric(horizontal: 16.0), // Adjust the padding as needed
                  alignment: Alignment.center, // Align text to the right
                ),
                child: Text(
                  "View All",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                    color: Colors.white, // Change the text color to your desired color
                  ),
                ),
              ),
            ),
            // Promo Container
            _buildPromoContainer(),
          ],
        ),
      ),
    );
  }

  Widget _buildTopRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Search Bar (You can customize the TextField as needed)
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search...',
              filled: true,
              fillColor: Colors.grey[200],
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),

        // Notification Icon
        IconButton(
          icon: Icon(Icons.notifications, color: Color(0xFF4CAF50),),
          onPressed: () {
            // Handle notification action
          },
        ),
      ],
    );
  }

  Widget _buildCarouselSlider() {
    // Replace the image URLs with your own images
    List<String> imageAsset = [
      'asset/image/banner/photo_2023-12-09_11-41-07.jpg',
      'asset/image/banner/photo_2023-12-09_11-41-29.jpg',
      'asset/image/banner/photo_2023-12-11_15-29-29.jpg',
      'asset/image/banner/photo_2023-12-15_11-27-02.jpg',
      'asset/image/banner/photo_2023-12-16_14-58-52.jpg',
    ];

    return CarouselSlider(
      options: CarouselOptions(
        height: 200.0,
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: Duration(milliseconds: 800),
      ),
      items: imageAsset.map((asset) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(asset),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildCategories() {
    List<Map<String, dynamic>> categories = [
      {'name': 'Fruits & Vegetable', 'image': 'asset/image/Mix fruits -4.jpg'},
      {'name': 'meats a', 'image': 'asset/image/front-view-cinnamon-mint-alogn-with-fresh-tea-white-ingredients-spices-color.jpg'},
      {'name': 'Dairy Products', 'image': 'asset/image/banner/14600.jpg'},
    ];

    return SizedBox(
      height: 130.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return  GlassmorphicContainer(
            width: 150.0,
            height: 180.0,
            borderRadius: 16.0,
            blur: 10,
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
              colors: [Color(0xFF4CAF50), Color(0xFF2E7D32)],
            ),
            child: SingleChildScrollView(
              child: Container(
                width: 150.0,
                height: 150.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: AssetImage(categories[index]['image']),
                    fit: BoxFit.cover,
                    opacity: .7,

                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        categories[index]['name'],
                        style: TextStyle(
                          backgroundColor: Colors.white,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        '\$${categories[index]['price']}',
                        style: TextStyle(
                          backgroundColor: Colors.white,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductRow() {
    List<Map<String, dynamic>> products = [
      {'name': 'Carrot ', 'image': 'asset/image/baby-carrots.jpg', 'price': 10.0},
      {'name': 'Fish Meat', 'image': 'asset/image/slide-raw-pork-white-background.jpg', 'price': 10.0},
      {'name': 'Avocado', 'image': 'asset/image/4652.jpg', 'price': 15.0},
      {'name': 'Avocado', 'image': 'asset/image/4652.jpg', 'price': 15.0},
      {'name': 'Avocado', 'image': 'asset/image/4652.jpg', 'price': 15.0},
      {'name': 'Avocado', 'image': 'asset/image/4652.jpg', 'price': 15.0},
      // Add more products as needed
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: products.map((product) {
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: GlassmorphicContainer(
              width: 150.0,
              height: 180.0,
              borderRadius: 16.0,
              blur: 10,
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
                colors: [Color(0xFF4CAF50), Color(0xFF2E7D32)],
              ),
              child: SingleChildScrollView(
                child: Container(
                  width: 120.0,
                  height: 150.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: AssetImage(product['image']),
                      fit: BoxFit.cover,
                      opacity: .7,

                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          product['name'],
                          style: TextStyle(
                            backgroundColor: Colors.white,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          '\$${product['price']}',
                          style: TextStyle(
                            backgroundColor: Colors.white,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }


  Widget _buildPromoContainer() {
    // Replace the promo content with your own
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Icon(Icons.star, color: Colors.white),
          SizedBox(width: 8.0),
          Expanded(
            child: Text(
              'Don\'t miss our special promotion! Limited time offer. Shop now!',
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(width: 8.0),
          ElevatedButton(
            onPressed: () {
              // Handle promo button action
            },
            child: Text('Shop Now'),
          ),
        ],
      ),
    );
  }
}