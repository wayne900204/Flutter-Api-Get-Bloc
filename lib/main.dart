import 'package:bloc_get_api/bloc/restaurant_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// own import
import 'package:bloc_get_api/ui/pages/home_page.dart';

import 'data/repository/restaurant_repository.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Api-Get',
      home: BlocProvider(
        create: (context) => RestaurantBloc(restaurantRepository: RestaurantRepository()),
        child: HomePage(),
      ),
    );
  }
}
