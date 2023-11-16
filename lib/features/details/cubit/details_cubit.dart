import 'dart:collection';
import 'dart:convert';

import 'package:ably_flutter/ably_flutter.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:traka/core/services/ably_service.dart';
import 'package:traka/core/utils/order_status.dart';
import 'package:traka/features/details/models/order_status.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  final AblyService service;
  DetailsCubit(this.service) : super(DetailsInitial());

  subscribeToDetailsChannel(String channelName) async {
    try {
      emit(OrderStatusLoading());
      var data = await service.getChannelhistory(channelName);

      Queue<OrderStatusModel> statuses = Queue<OrderStatusModel>();
      for (var element in data.items) {
        statuses
            .add(OrderStatusModel.fromJson(jsonDecode(element.data as String)));
      }

      emit(OrderStatusSuccess(channelName: channelName, statuses: statuses));

      Stream<Message> stream = service.subscribeToChannel(channelName);
      stream.listen((message) {
        OrderStatusModel status =
            OrderStatusModel.fromJson(jsonDecode((message.data as String)));
        emit(
            UpdateOrderStatusSuccess(channelName: channelName, status: status));
      });

      if (data.items.isEmpty) {
        // create new status
        updateStatus(channelName, OrderStatusEnum.orderPlaced);
      }
    } catch (ex) {
      emit(OrderStatusError(ex.toString()));
    }
  }

  updateStatus(String channelName, OrderStatusEnum status) async {
    try {
      OrderStatusModel model =
          OrderStatusModel(date: DateTime.now(), status: status);
      emit(UpdateOrderStatusLoading());
      await service.publishToChannel(channelName, model.toJson());
    } catch (ex) {
      emit(UpdateOrderStatusError(ex.toString()));
    }
  }
}
