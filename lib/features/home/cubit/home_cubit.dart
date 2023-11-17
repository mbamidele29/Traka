import 'dart:collection';
import 'dart:convert';
import 'dart:math';

import 'package:ably_flutter/ably_flutter.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:traka/core/models/order_item.dart';
import 'package:traka/core/models/product.dart';
import 'package:traka/core/notification/local_notification_manager.dart';
import 'package:traka/core/services/ably_service.dart';
import 'package:traka/core/utils/constants.dart';
import 'package:flutter/services.dart' as root_bundle;

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final AblyService service;

  List<Product>? products;
  HomeCubit(this.service) : super(HomeInitial()) {
    _loadProducts();
  }

  _loadProducts() async {
    try {
      String data =
          await root_bundle.rootBundle.loadString(AppConstants.productsJson);
      products =
          (jsonDecode(data) as List).map((e) => Product.fromJson(e)).toList();
    } catch (_) {}
  }

  createOrder(String channelName) async {
    try {
      if (products == null) await _loadProducts();
      if (products == null) return;
      if (products!.isEmpty) {
        emit(const CreateOrderError('products are out of stock'));
        return;
      }
      int index = Random().nextInt(100) % products!.length;
      Product product = products![index];

      int quantity = Random().nextInt(6);
      if (quantity == 0) quantity = 1;
      OrderItem orderItem = OrderItem(
        product: product,
        quantity: quantity,
        date: DateTime.now(),
        id: DateTime.now().millisecondsSinceEpoch.toString(),
      );

      emit(CreateOrderLoading());
      await service.publishToChannel(channelName, orderItem.toJson());
      products!.removeAt(index);
    } catch (ex) {
      emit(CreateOrderError(ex.toString()));
    }
  }

  subscribeToOrdersChannel(String channelName) async {
    try {
      emit(GetOrdersLoading());
      var data = await service.getChannelhistory(channelName);
      Queue<OrderItem> orders = Queue<OrderItem>();

      for (var element in data.items) {
        orders.add(OrderItem.fromJson(jsonDecode(element.data as String)));
      }
      emit(GetOrdersSuccess(orders));

      Stream<Message> stream = service.subscribeToChannel(channelName);
      stream.listen((message) {
        OrderItem order =
            OrderItem.fromJson(jsonDecode((message.data as String)));
        emit(CreateOrderSuccess(order));
        LocalNotificationManager.showNotification(
            title: 'New Order', body: 'Order #${order.id} has been created');
      });

      // create new order if order is empty
      if (data.items.isEmpty) createOrder(channelName);
    } catch (ex) {
      emit(GetOrdersError(ex.toString()));
    }
  }
}
