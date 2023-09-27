import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';
import 'package:recipe_app/pages/details_page.dart';
import 'package:recipe_app/pages/favorite_page.dart';
import 'package:recipe_app/pages/home_page.dart';
import 'package:recipe_app/providers/homeprovider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => HomePageProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(415, 860),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            theme: ThemeData(appBarTheme: AppBarTheme(color: Colors.redAccent)),
            debugShowCheckedModeBanner: false,
            home: HomePage(),
            // home: SplashScreenPage(),
            routes: {
              DetailsPage.routeName: (context) => DetailsPage(),
              FavoritePage.routeName: (context) => FavoritePage(),
            },
          );
        });
  }
}
