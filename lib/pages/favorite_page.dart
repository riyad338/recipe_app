import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/models/mealsmodel.dart';
import 'package:recipe_app/pages/details_page.dart';
import 'package:recipe_app/providers/homeprovider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FavoritePage extends StatefulWidget {
  static const String routeName = '/favorite';
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  late HomePageProvider homePageProvider;

  void didChangeDependencies() {
    homePageProvider = Provider.of<HomePageProvider>(context);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text("My Favorite"),
        ),
        body: ListView.builder(
            itemCount: homePageProvider.favoriteMeals.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.all(5),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: Colors.red),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  tileColor: Colors.black12,
                  title:
                      Text("${homePageProvider.favoriteMeals[index].strMeal}"),
                ),
              );
            }));
  }
}
