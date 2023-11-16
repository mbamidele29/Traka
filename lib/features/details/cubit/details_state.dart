part of 'details_cubit.dart';

sealed class DetailsState extends Equatable {
  const DetailsState();

  @override
  List<Object> get props => [];
}

final class DetailsInitial extends DetailsState {}

final class OrderStatusLoading extends DetailsState {}

final class OrderStatusSuccess extends DetailsState {
  final String channelName;
  final Queue<OrderStatusModel> statuses;

  const OrderStatusSuccess({required this.channelName, required this.statuses});
}

final class OrderStatusError extends DetailsState {
  final String message;

  const OrderStatusError(this.message);
}

final class UpdateOrderStatusLoading extends DetailsState {}

final class UpdateOrderStatusSuccess extends DetailsState {
  final String channelName;
  final OrderStatusModel status;

  const UpdateOrderStatusSuccess(
      {required this.channelName, required this.status});

  @override
  List<Object> get props => [channelName, status.status];
}

final class UpdateOrderStatusError extends DetailsState {
  final String message;

  const UpdateOrderStatusError(this.message);
}
