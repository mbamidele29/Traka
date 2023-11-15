part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class CreateOrderLoading extends HomeState {}

final class CreateOrderSuccess extends HomeState {
  final OrderItem order;

  const CreateOrderSuccess(this.order);
}

final class CreateOrderError extends HomeState {
  final String message;

  const CreateOrderError(this.message);
}

final class GetOrdersLoading extends HomeState {}

final class GetOrdersSuccess extends HomeState {
  final Queue<OrderItem> orders;

  const GetOrdersSuccess(this.orders);
}

final class GetOrdersError extends HomeState {
  final String message;

  const GetOrdersError(this.message);
}
