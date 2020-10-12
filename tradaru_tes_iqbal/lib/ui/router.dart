import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tradaru_tes_iqbal/constant/route_names.dart';
import 'package:tradaru_tes_iqbal/ui/detail_screen.dart';
import 'package:tradaru_tes_iqbal/ui/home_screen.dart';


Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomeScreenRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: HomeScreen(),
      );
    case DetailScreenRoute:
      var Data = settings.arguments;
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: DetailScreen(Data),
      );
    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
                child: Text('No route defined for ${settings.name}')),
          ));
  }
}

PageRoute _getPageRoute({String routeName, Widget viewToShow}) {
  return MaterialPageRoute(
      settings: RouteSettings(
        name: routeName,
      ),
      builder: (_) => viewToShow);
}