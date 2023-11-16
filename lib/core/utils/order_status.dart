enum OrderStatusEnum {
  orderPlaced,
  orderAccepted,
  pickupInProgress,
  onTheWay,
  arrived,
  delivered
}

extension OrderStatusEnumExt on OrderStatusEnum {
  int get rank {
    switch (this) {
      case OrderStatusEnum.orderPlaced:
        return 1;
      case OrderStatusEnum.orderAccepted:
        return 2;
      case OrderStatusEnum.pickupInProgress:
        return 3;
      case OrderStatusEnum.onTheWay:
        return 4;
      case OrderStatusEnum.arrived:
        return 5;
      case OrderStatusEnum.delivered:
        return 6;
    }
  }

  String get code {
    switch (this) {
      case OrderStatusEnum.orderPlaced:
        return 'ORDER PLACED';
      case OrderStatusEnum.orderAccepted:
        return 'ORDER ACCEPTED';
      case OrderStatusEnum.pickupInProgress:
        return 'ORDER PICK UP IN PROGRESS';
      case OrderStatusEnum.onTheWay:
        return 'ORDER ON THE WAY TO CUSTOMER';
      case OrderStatusEnum.arrived:
        return 'ORDER ARRIVED';
      case OrderStatusEnum.delivered:
        return 'ORDER DELIVERED';
    }
  }

  String get title {
    switch (this) {
      case OrderStatusEnum.orderPlaced:
        return 'Order placed';
      case OrderStatusEnum.orderAccepted:
        return 'Order accepted';
      case OrderStatusEnum.pickupInProgress:
        return 'Order pickup in progress';
      case OrderStatusEnum.onTheWay:
        return 'Order on the way';
      case OrderStatusEnum.arrived:
        return 'Order arrived';
      case OrderStatusEnum.delivered:
        return 'Order delivered';
    }
  }

  String get description {
    switch (this) {
      case OrderStatusEnum.orderPlaced:
        return 'Waiting for the vendor to accept your order.';
      case OrderStatusEnum.orderAccepted:
        return 'The vendor is preparing your order and a rider will pick up soon.';
      case OrderStatusEnum.pickupInProgress:
        return 'A rider is on the way to the vendor to pick up your order.';
      case OrderStatusEnum.onTheWay:
        return 'A rider has picked up your order and is bringing it your way.';
      case OrderStatusEnum.arrived:
        return 'Don\'t deep the rider waiting.';
      case OrderStatusEnum.delivered:
        return 'Enjoy!';
    }
  }
}
