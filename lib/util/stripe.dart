import 'dart:html' as html;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// constant
import 'package:botob/constant/strings.dart';

// stripePriceIdのEnum
enum StripePrice {
  price_100,
  price_1000,
}

extension StripePriceExtension on StripePrice {
  static final ids = {
    StripePrice.price_100: "price_1NwuASIMWjAXzwjskYPjLBpB",
    StripePrice.price_1000: "price_1NwuBFIMWjAXzwjsWUj15U9v",
  };

  String get id => ids[this]!;
}

Future<String> createCheckoutSession({
  required String userUid,
  required StripePrice stripePrice,
}) async {
  try {
    final docRef = await FirebaseFirestore.instance
        .collection(customersFieldKey)
        .doc(userUid)
        .collection(sessionsFieldKey)
        .add({
      "client": "web",
      "mode": "payment",
      "price": stripePrice.id,
      "success_url": 'http://localhost:8080/success',
      "cancel_url": 'http://localhost:8080/cancel'
    });
    return docRef.id;
  } catch (e) {
    print(e);
    return "";
  }
}

Stream<Widget> openCheckoutWithWidget({
  required String userUid,
  required String sessionId,
}) async* {
  var counterStream =
      Stream<int>.periodic(const Duration(seconds: 1), (i) => i);
  await for (var _ in counterStream.take(10)) {
    DocumentSnapshot<Map<String, dynamic>> docRef = await FirebaseFirestore
        .instance
        .collection(customersFieldKey)
        .doc(userUid)
        .collection(sessionsFieldKey)
        .doc(sessionId)
        .get();
    Map<String, dynamic> data = docRef.data()!;
    if (data.containsKey('sessionId') && data.containsKey('url')) {
      // open the new window with Stripe Checkout Page URL
      html.window.location.href = data['url'] as String;
      yield const CircularProgressIndicator();
    } else if (data.containsKey('error')) {
      yield Text(
        data['error']['message'] as String? ?? 'Error processing payment.',
      );
    } else {
      yield const Center(child: CircularProgressIndicator());
    }
  }
}
