
import 'package:flutter/material.dart';
import 'package:tradaru_tes_iqbal/managers/dialog_managers.dart';
import 'package:tradaru_tes_iqbal/services/dialog_service.dart';
import 'package:tradaru_tes_iqbal/services/navigation_service.dart';
import 'package:tradaru_tes_iqbal/ui/home_screen.dart';
import 'package:tradaru_tes_iqbal/ui/router.dart';
import 'package:tradaru_tes_iqbal/utilities/style.dart';
import 'locator.dart';
void main() {
  setupLocator();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) => Navigator(
        key: locator<DialogService>().dialogNavigationKey,
        onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => DialogManager(child: child)),
      ),
      navigatorKey: locator<NavigationService>().navigationKey,
      theme: ThemeData(
        primaryColor: primaryColor,
        textTheme: Theme.of(context).textTheme.apply(
          fontFamily: 'Open Sans',
        ),
      ),
      home: HomeScreen(),
      onGenerateRoute: generateRoute,
    );
  }
}