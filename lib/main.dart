import 'package:flutter/material.dart';
import 'package:tabby_flutter_inapp_sdk/tabby_flutter_inapp_sdk.dart';

void main() {
  TabbySDK().setup(
    withApiKey: 'hvyub bu  iununuiniun iiunuiniu',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TestScreen(),
    );
  }
}

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);

  checkoutSession(BuildContext context) async {
    final mockPayload = Payment(
      amount: '340',
      currency: Currency.aed,
      buyer: Buyer(
        email: 'id.card.success@tabby.ai',
        phone: '500000001',
        name: 'Yazan Khalid',
        dob: '2019-08-24',
      ),
      buyerHistory: BuyerHistory(
        loyaltyLevel: 0,
        registeredSince: '2019-08-24T14:15:22Z',
        wishlistCount: 0,
      ),
      shippingAddress: const ShippingAddress(
        city: 'string',
        address: 'string',
        zip: 'string',
      ),
      order: Order(referenceId: 'id123', items: [
        OrderItem(
          title: 'Jersey',
          description: 'Jersey',
          quantity: 1,
          unitPrice: '10.00',
          referenceId: 'uuid',
          productUrl: 'http://example.com',
          category: 'clothes',
        )
      ]),
      orderHistory: [
        OrderHistoryItem(
          purchasedAt: '2019-08-24T14:15:22Z',
          amount: '10.00',
          paymentMethod: OrderHistoryItemPaymentMethod.card,
          status: OrderHistoryItemStatus.newOne,
        )
      ],
    );

    final session = await TabbySDK().createSession(TabbyCheckoutPayload(
      merchantCode: 'ae',
      lang: Lang.en,
      payment: mockPayload,
    ));
    TabbyWebView.showWebView(
      context: context,
      webUrl: session.availableProducts.installments!.webUrl,
      onResult: (WebViewResult resultCode) {
        print(resultCode.name);
        // TODO: Process resultCode
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          child: const Text('test'),
          onPressed: ()=> checkoutSession(context),
        ),
      ),
    );
  }
}
