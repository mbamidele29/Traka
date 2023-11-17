import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:traka/core/models/order_item.dart';
import 'package:traka/core/models/product.dart';

import '../reader.dart';

void main() {
  final model = OrderItem(
      quantity: 5,
      id: "1700126257046",
      date: DateTime.parse('2023-11-16T10:17:37.046079'),
      product: const Product(
        name: 'Steak',
        price: 5000,
        image:
            "https://media.istockphoto.com/id/171255350/photo/grilled-beefsteak-with-french-fries.webp?b=1&s=170667a&w=0&k=20&c=nJXrVn7z90TvwP4kvwBJM4CktmGnIFw23VI5wpy-f5s=",
        addOns: ["Butter", "sauce"],
      ));
  test(
    'should be a type of FeedListModel',
    () async {
      // assert
      expect(model, isA<OrderItem>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model ',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('order_item.json'));
        // act
        final OrderItem result = OrderItem.fromJson(jsonMap);
        // assert
        expect(result.runtimeType, model.runtimeType);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // act
        final Map<String, dynamic> expectedMap =
            json.decode(fixture('order_item.json'));
        final result = model.toJson();
        expect(result, expectedMap);
      },
    );
  });
}
