import 'package:get_it/get_it.dart';
import 'package:tradaru_tes_iqbal/services/dialog_service.dart';
import 'services/navigation_service.dart';
GetIt locator = GetIt.instance;
void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
}