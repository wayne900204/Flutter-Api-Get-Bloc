import 'package:bloc_get_api/data/model/api_result_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class RestaurantState extends Equatable {
  @override
  List<Object> get props => [];
}

class RestaurantLoadingState extends RestaurantState {

}

class RestaurantSuccessState extends RestaurantState {

  final RestaurantModel restaurantModel;

  RestaurantSuccessState({@required this.restaurantModel});

  @override
  // TODO: implement props
  List<Object> get props => [restaurantModel];
}

class RestaurantFailState extends RestaurantState {

  final String message;

  RestaurantFailState({@required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}

