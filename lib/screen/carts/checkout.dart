import 'package:flutter/material.dart';
import 'package:freshcornersample/screen/order/OrderScreen.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

import 'package:freshcornersample/screen/carts/Carts.dart';


class CheckoutScreen extends StatefulWidget {
  final List<CartItem> items;

  CheckoutScreen({required this.items});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String selectedBranch = 'Branch A'; // Default selection
  bool isFinished = false;
  final List<String> branches = ['Branch A', 'Branch B', 'Branch C'];
  final Map<String, String> branchImages = {
    'Branch A': 'asset/image/AF1QipN_R_JQVqgsd0QYe9p2-BLKJ0Fm.jpg',
    'Branch B': 'asset/image/AF1QipNVNYlTl4Pt5T8HiQhmxDfZYMZ7.jpg',
    'Branch C': 'asset/image/AF1QipOXeVWvm8rfbqxY-dZhcXBhd9zP.jpg',
  };
  DateTime? selectedPickupTime;

  @override
  Widget build(BuildContext context) {
    double totalPrice = widget.items.fold(0, (sum, item) => sum + item.totalPrice());

    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(widget.items[index].image),
                  ),
                  title: Text(widget.items[index].name),
                  subtitle: Text('Quantity: ${widget.items[index].quantity}'),
                  trailing: Text('\$${widget.items[index].totalPrice().toStringAsFixed(2)}'),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Select Branch:',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () => _showBranchSelectionDialog(context),
                  child: Text('Select', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text('Pickup Time'),
            subtitle: selectedPickupTime != null
                ? Text('${selectedPickupTime!.toLocal()}'.split(' ')[1])
                : Text('Not Set'),
            trailing: Icon(Icons.calendar_today, color: Colors.green),
            onTap: () => _selectPickupTime(context),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.green,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
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
          ),
          SizedBox(height: 10),
          SwipeableButtonView(
            buttonText: 'SLIDE TO PAYMENT',
            buttonWidget: Container(
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.grey,
              ),
            ),
            activeColor: Color(0xFF009C41),
            isFinished: isFinished,
            onWaitingProcess: () {
              Future.delayed(Duration(seconds: 2), () {
                setState(() {
                  isFinished = true;
                });
              });
            },
            onFinish: () async {
              await Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: OrdersScreen(orders: [], items: [],),
                ),
              );

              // TODO: For reverse ripple effect animation
              setState(() {
                isFinished = false;
              });
            },
          ),

          SizedBox(height: 10),
        ],
      ),
    );
  }

  Future<void> _selectPickupTime(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 7)), // You can change the range as needed
    );

    if (picked != null) {
      final TimeOfDay? timePicked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (timePicked != null) {
        setState(() {
          selectedPickupTime = DateTime(picked.year, picked.month, picked.day, timePicked.hour, timePicked.minute);
        });
      }
    }
  }

  Future<void> _showBranchSelectionDialog(BuildContext context) async {
    String? result = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Select Branch'),
          children: branches.map((String branch) {
            return SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, branch);
              },
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Row(
                  children: [
                    Image.asset(
                      branchImages[branch]!,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 10),
                    Text(branch),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );

    if (result != null) {
      setState(() {
        selectedBranch = result;
      });
    }
  }
}
