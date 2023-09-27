import 'package:flutter/cupertino.dart';
import 'package:recipe_app/customhttp/customhttp.dart';
import 'package:recipe_app/models/mealsmodel.dart';

class HomePageProvider with ChangeNotifier {
  MealsModel? mealsModel;

  Future<MealsModel> allMeals() async {
    mealsModel = await CustomHttpRequest.allMeals();

    return mealsModel!;
  }
}
