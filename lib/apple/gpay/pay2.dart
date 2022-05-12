import 'package:api/apple/gpay/pay.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';

class Pays2 extends StatefulWidget {
  @override
  State<Pays2> createState() => _Pays2State();
}

class _Pays2State extends State<Pays2> {
  final _paymentItems = <PaymentItem>[
    PaymentItem(
      label: 'Total',
      amount: '${num.parse(amount)}',
      status: PaymentItemStatus.final_price,
    )
  ];
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            Row(
              children: [
                const Text(
                  "Amount : ",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Text(
                  amount,
                  style: const TextStyle(
                      fontSize: 25,
                      color: Colors.red,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            const Spacer(),
            Row(
              children: [
                ApplePayButton(
                  paymentConfigurationAsset: 'applepay.json',
                  paymentItems: _paymentItems,
                  width: 150,
                  height: 50,
                  style: ApplePayButtonStyle.black,
                  type: ApplePayButtonType.buy,
                  margin: const EdgeInsets.only(top: 15.0),
                  onPaymentResult: (data) {
                    print(data);
                  },
                  loadingIndicator: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                GooglePayButton(
                  paymentConfigurationAsset: 'gpay.json',
                  paymentItems: _paymentItems,
                  width: 150,
                  height: 50,
                  style: GooglePayButtonStyle.black,
                  type: GooglePayButtonType.pay,
                  margin: const EdgeInsets.only(top: 15.0),
                  onPaymentResult: (data) {
                    print(data);
                  },
                  loadingIndicator: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
        const SizedBox(
          height: 35,
        )
      ]),
    );
  }
}
