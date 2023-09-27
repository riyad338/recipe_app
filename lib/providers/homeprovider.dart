import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:recipe_app/customhttp/customhttp.dart';
import 'package:recipe_app/models/mealsmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageProvider with ChangeNotifier {
  MealsModel? mealsModel;
  List<Meals> favoriteMeals = [];

  Future<MealsModel> allMeals() async {
    mealsModel = await CustomHttpRequest.allMeals();
    return mealsModel!;
  }

  void loadFavoriteMeals() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteMealsJson = prefs.getStringList('favoriteMeals') ?? [];

    favoriteMeals = favoriteMealsJson
        .map((mealJson) => Meals.fromJson(json.decode(mealJson)))
        .toList();

    notifyListeners();
  }

  bool isFavorite(Meals meal) {
    return favoriteMeals
        .any((favoriteMeal) => favoriteMeal.idMeal == meal.idMeal);
  }

  void toggleFavorite(Meals meal) {
    final isCurrentlyFavorite = isFavorite(meal);

    if (isCurrentlyFavorite) {
      favoriteMeals.removeWhere((element) => element.idMeal == meal.idMeal);
    } else {
      favoriteMeals.add(meal);
    }

    final favoriteMealsJson =
        favoriteMeals.map((meal) => json.encode(meal.toJson())).toList();
    _saveFavoriteMealsToSharedPreferences(favoriteMealsJson);
    notifyListeners();
  }

  void _saveFavoriteMealsToSharedPreferences(List<String> mealsJson) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('favoriteMeals', mealsJson);
  }
}
