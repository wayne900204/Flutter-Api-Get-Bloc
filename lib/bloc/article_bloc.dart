import 'package:bloc/bloc.dart';
import 'package:bloc_get_api/data/model/api_result_model.dart';
import 'package:bloc_get_api/data/repository/article_repository.dart';

import 'package:meta/meta.dart';

import 'article_event.dart';
import 'article_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {

  RestaurantRepository restaurantRepository;

  RestaurantBloc({@required this.restaurantRepository}) : super(RestaurantLoadingState());
  
  RestaurantState get initialState => RestaurantLoadingState();

  @override
  Stream<RestaurantState> mapEventToState(RestaurantEvent event) async* {
    if (event is FetchRestaurantEvent) {
      yield RestaurantLoadingState();
      try {

        RestaurantModel restaurantModel = await restaurantRepository.getRestaurantData();
        print("Bloc Success");
        yield RestaurantSuccessState(restaurantModel: restaurantModel);
      } catch (e) {
        print(  await restaurantRepository.getRestaurantData());
        yield RestaurantFailState(message: "???");
      }
    }
  }

}