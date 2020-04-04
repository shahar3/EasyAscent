import 'package:get_it/get_it.dart';

import './core/services/api.dart';
import './core/services/authentication.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => Auth());
  locator.registerLazySingleton(() => Api());
}
