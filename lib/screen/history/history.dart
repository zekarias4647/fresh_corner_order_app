import 'package:flutter/material.dart';
import 'package:freshcornersample/screen/carts/Carts.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderHistoryScreen extends StatelessWidget {
  final List<Order> orders;

  OrderHistoryScreen({required this.orders});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          'Order History',
          style: GoogleFonts.poppins(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Card(
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.2),
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Order ${index + 1}',
                                  style: GoogleFonts.poppins(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                                Icon(
                                  Icons.shopping_bag,
                                  color: Colors.green,
                                ),
                              ],
                            ),
                            SizedBox(height: 16.0),
                            Text(
                              'Branch: ${orders[index].branch}',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.grey[600],
                              ),
                            ),
                            Text(
                              'Pickup Time: ${orders[index].pickupTime.toLocal()}',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.grey[600],
                              ),
                            ),
                            Text(
                              'Total Items: ${orders[index].items.length}',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Text(
                              'Items:',
                              style: GoogleFonts.poppins(
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                            SizedBox(height: 12.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: orders[index].items.map((item) {
                                return ListTile(
                                  contentPadding: EdgeInsets.only(left: 16.0),
                                  title: Text(
                                    '${item.name} x${item.quantity}',
                                    style: GoogleFonts.poppins(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(
                                    '\$${item.totalPrice().toStringAsFixed(2)}',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            SizedBox(height: 20.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total Price:',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                                Text(
                                  '\$${orders[index].calculateTotalPrice().toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Points Earned:',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                                Text(
                                  '${orders[index].calculatePointsEarned()} points',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
