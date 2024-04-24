import 'package:flutter/material.dart';

import 'common/di/app_dependency_injection.dart';
import 'common/extension/app_theme.dart';
import 'common/routes/app_router.dart';

void main() {
  initializeDependencies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
       return GestureDetector(
         onTap: () {
           FocusManager.instance.primaryFocus?.unfocus();
         },
         child: MaterialApp.router(
           builder: (BuildContext context, Widget? child) {
             return MediaQuery(
               data: MediaQuery.of(context).copyWith(
                textScaler: const TextScaler.linear(1.0),
               ), //set desired text scale factor here
               child: child!,
             );
           },
           debugShowCheckedModeBanner: false,
           title: 'Spotify',
           // initialBinding: AppInitialBinding(),
           // getPages: AppPages.pages,
          //  locale: locale != null ? Locale(locale) : null,
          //  localizationsDelegates: AppLocalizations.localizationsDelegates,
          //  supportedLocales: AppLocalizations.supportedLocales,
           routerConfig: appRouter,
           theme: AppTheme.mainTheme,
           darkTheme: AppTheme.darkTheme,
         ),
       );
  }
}
