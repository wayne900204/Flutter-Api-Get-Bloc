import 'package:bloc_get_api/bloc/article_state.dart';
import 'package:bloc_get_api/data/model/api_result_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// own import
import 'package:bloc_get_api/bloc/article_bloc.dart';
import 'package:bloc_get_api/bloc/article_event.dart';

import 'about_page.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  RestaurantBloc _restaurantBloc;
  Size size;
  @override
  void initState() {
    super.initState();
    _restaurantBloc = BlocProvider.of<RestaurantBloc>(context);
    _restaurantBloc.add(FetchRestaurantEvent());
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return MaterialApp(
      home: Builder(
        builder: (context) {
          return Material(
            child: Scaffold(
              appBar: AppBar(
                title: Text("Api-Get"),
                centerTitle: true,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () {
                      _restaurantBloc.add(FetchRestaurantEvent());
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.info),
                    onPressed: () {
                      navigateToAboutPage(context);
                    },
                  )
                ],
              ),
              body: Container(
                child: BlocListener<RestaurantBloc, RestaurantState>(
                  listener: (context, state) {
                    if (state is RestaurantFailState) {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                        ),
                      );
                    }
                  },
                  child: BlocBuilder<RestaurantBloc, RestaurantState>(
                    builder: (context, state) {
                      if (state is RestaurantLoadingState) {
                        return _buildLoading();
                      } else if (state is RestaurantSuccessState) {
                        return buildArticleList(state.restaurantModel);
                      } else if (state is RestaurantFailState) {
                        return _buildErrorUi(state.message);
                      }
                      return Container();
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildErrorUi(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  Widget buildArticleList(RestaurantModel restaurantModel) {
    return Container(
        child: new ListView.builder(
          padding: EdgeInsets.only(top: 30),
          itemCount: restaurantModel.data.length,
          itemBuilder: (context, int index) =>
              buildCustomItem(context, index, restaurantModel.data),
        ));
  }

  void navigateToAboutPage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AboutPage();
    }));
  }


  /// 餐廳 listView 的 Item 畫面
  Widget buildCustomItem(BuildContext context, int index, List<Datum> data) {
    return Container(
        padding:
        EdgeInsets.only(left: size.width * 0.1, right: size.width * 0.1),
        // height: 500,
        width: size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container(
            //   height: size.height * 0.3,
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.all(Radius.circular(25.0))),
            //   child: Image.network(RestaurantList[index].storeLink),
            //   // child: _ImgaeNetWorkStyle(RestaurantList[index].storeLink)
            // ),
            Padding(
              padding: EdgeInsets.only(top: 16, right: 8.0, left: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    data[index].name,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.cyan[700]),
                  ),
                  Text(
                    "最低\$" + data[index].lowestPrice.toString() + "外送",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.cyan[700]),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(data[index].description,
                  style: TextStyle(fontSize: 15, color: Colors.cyan[700])),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 16, right: 8.0, left: 8.0),
              child: Text(data[index].address,
                  style: TextStyle(fontSize: 15, color: Colors.cyan[700])),
            ),
          ],
        ));
  }
}
