import 'package:flutter/material.dart';
import 'h1.dart';

class PayPage extends StatelessWidget {
  final List<Map<String, dynamic>> cartItemsA;
  final int totalPrice;

  const PayPage({
    Key? key,
    required this.cartItemsA,
    required this.totalPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PaymentPage(cartItems: cartItemsA, totalPrice: totalPrice),
    );
  }
}

class PaymentPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  final int totalPrice;

  const PaymentPage({
    Key? key,
    required this.cartItems,
    required this.totalPrice,
  }) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String? selectedPaymentMethod = "Credit card";
  bool saveCardDetails = false;

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
        title: Text(
          "Order Summary",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Order Summary",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              ...widget.cartItems.map((item) => buildSummaryRow(
                    "${item['name']} x${item['quantity']}",
                    "Rp.${item['price'] * item['quantity']}",
                  )),
              Divider(),
              buildSummaryRow(
                "Total",
                "Rp.${widget.totalPrice}",
                textStyle: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text("Estimated delivery time: 15-30mins",
                  style: TextStyle(color: Colors.grey)),
              SizedBox(height: 16),
              Text(
                "Payment methods",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              buildPaymentMethod("Credit card", "5156 ** ** 8496"),
              SizedBox(height: 8),
              buildPaymentMethod("QRIS", ""),
              SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(
                    value: saveCardDetails,
                    onChanged: (value) {
                      setState(() {
                        saveCardDetails = value ?? false;
                      });
                    },
                  ),
                  Expanded(
                    child: Text("Save card details for future payments"),
                  )
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total price",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Rp.${widget.totalPrice}",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  ),
                ],
              ),
              SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    print("Selected payment method: $selectedPaymentMethod");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ConfirmationPage(
                          paymentMethod: selectedPaymentMethod ?? "None",
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[800],
                    padding: EdgeInsets.all(16),
                  ),
                  child: Text("Pay now"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSummaryRow(String title, String value, {TextStyle? textStyle}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: textStyle),
          Text(value, style: textStyle),
        ],
      ),
    );
  }

  Widget buildPaymentMethod(String method, String details) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.red,
      ),
      child: ListTile(
        leading: Icon(
          method == "Credit card" ? Icons.credit_card : Icons.qr_code,
          color: Colors.white,
        ),
        title: Text(method, style: TextStyle(color: Colors.white)),
        subtitle: details.isNotEmpty
            ? Text(details, style: TextStyle(color: Colors.white))
            : null,
        trailing: Radio<String>(
          value: method,
          groupValue: selectedPaymentMethod,
          onChanged: (value) {
            setState(() {
              selectedPaymentMethod = value;
            });
          },
        ),
      ),
    );
  }
}

class ConfirmationPage extends StatelessWidget {
  final String paymentMethod;

  const ConfirmationPage({
    Key? key,
    required this.paymentMethod,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Confirmation"),
      ),
      body: Center(
        child: Text(
          "Payment successful with $paymentMethod",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
