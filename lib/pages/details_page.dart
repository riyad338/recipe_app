import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/models/mealsmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<String> favoriteMeals = [];

class DetailsPage extends StatefulWidget {
  static const String routeName = '/details';
  const DetailsPage({Key? key}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late Meals meals;
  bool _favorite = false;

  void didChangeDependencies() {
    final argList = ModalRoute.of(context)!.settings.arguments as List;
    meals = argList[0];

    super.didChangeDependencies();
  }

  Future<void> _toggleFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (_favorite) {
        favoriteMeals.remove(meals.idMeal);
      } else {
        favoriteMeals.add("${meals.idMeal}");
      }
      _favorite = !_favorite;
    });

    // Save updated favorites list to SharedPreferences
    await prefs.setStringList('favoriteMeals', favoriteMeals);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${meals.strMeal} Details"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0.r),
                child: Stack(
                  children: [
                    Image.network(
                      "${meals.strMealThumb}",
                      height: 220.h,
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: IconButton(
                          icon: Icon(_favorite
                              ? Icons.favorite
                              : Icons.favorite_border_outlined),
                          color: _favorite ? Colors.red : null,
                          onPressed: () {
                            _toggleFavorite();
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  Text(
                    "Category : ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("${meals.strCategory}"),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Area :",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("${meals.strArea}"),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Ingredient1 :",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("${meals.strIngredient1}"),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Ingredient2 :",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("${meals.strIngredient2}"),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Ingredient3 :",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("${meals.strIngredient3}"),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Ingredient4 :",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("${meals.strIngredient4}"),
                ],
              ),
              Text(
                "Instructions: ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text("${meals.strInstructions}"),
            ],
          ),
        ),
      ),
    );
  }
}
