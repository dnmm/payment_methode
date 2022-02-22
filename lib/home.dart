import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  late Razorpay razorpay;
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    var razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSucess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlePaymentWallet);
  }

  @override
  void deactivate() {
    super.deactivate();
    razorpay.clear();
  }

  void openCheckout() {
    var options = {
      "key": "rzp_test_mz2tkRFghVdYF7",
      "amount": textEditingController.text,
      "name": "Compony Name",
      "description": "Payment for Purchase",
      "prefill": {
        "contact": "9793953764",
        "Email": "dnm.dpm@gmail.com",
      },
      "external": {
        "wallets": ["paytm"] // use function
      }
    };

    try {
      razorpay.open(options);
    } catch (e) {
      e.toString();
    }
  }

  void handlePaymentSucess() {
    ("Payment Sucecss");
  }

  void handlePaymentError() {
    ("Payment Error");
  }

  void handlePaymentWallet() {
    ("Payment Wallet");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Payment"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            TextField(
              controller: textEditingController,
              decoration: const InputDecoration(hintText: "Amount to Pay"),
            ),
            const SizedBox(
              height: 12.0,
            ),
            ElevatedButton(
              onPressed: () {
                openCheckout();
              },
              child: const Text("Pay"),
            )
          ],
        ),
      ),
    );
  }
}
