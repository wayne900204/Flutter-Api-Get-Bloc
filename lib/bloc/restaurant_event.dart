import 'package:equatable/equatable.dart';

abstract class RestaurantEvent extends Equatable{

  @override
  List<Object> get props =>[];
}

class FetchRestaurantEvent extends RestaurantEvent {}