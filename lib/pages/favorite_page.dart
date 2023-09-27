import 'package:flutter/material.dart';
import 'package:recipe_app/models/mealsmodel.dart';
import 'package:recipe_app/pages/details_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritePage extends StatefulWidget {
  static const String routeName = '/favorite';
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  bool _favorite = false;
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: favoriteMeals.length,
        itemBuilder: (context, index) {
          // You can use the favoriteMeals list to retrieve meal details
          final mealId = favoriteMeals[index];

          // Replace this with your own logic to fetch meal details based on mealId
          final mealDetails = getMealDetailsById(mealId);

          return ListTile(
            leading: Image.network("${mealDetails.strMealThumb}"),
            title: Text("${mealId}"),
            // Add more widgets to display meal details as needed
          );
        },
      ),
    );
  }

  Meals getMealDetailsById(String mealId) {
    // Implement your logic to fetch meal details by ID
    // You might need to use your data source or API to retrieve details.
    // For demonstration purposes, I'm returning a dummy meal object.
    return Meals(
      idMeal: mealId,
      strMeal: 'Dummy Meal',
      strMealThumb: 'https://example.com/dummy-image.jpg',

      // Add more details here
    );
  }
}
