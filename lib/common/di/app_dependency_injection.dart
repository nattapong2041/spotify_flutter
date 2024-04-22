import 'package:get_it/get_it.dart';

import 'app_setting_injection.dart';
import 'domain_injection.dart';
import 'data_injection.dart';
import 'presenter_injection.dart';

final GetIt injector = GetIt.instance;

/// Initialize all dependencies with injections
void initializeDependencies() {
  AppSettingInjection.inject();
  DataInjection.inject();
  DomainInjection.inject();
  PresenterInjection.inject();
}