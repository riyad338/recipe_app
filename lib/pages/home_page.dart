import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/models/mealsmodel.dart';
import 'package:recipe_app/pages/details_page.dart';
import 'package:recipe_app/pages/favorite_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:recipe_app/providers/homeprovider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomePageProvider homePageProvider;
  String _searchQuery = '';

  @override
  void didChangeDependencies() {
    homePageProvider = Provider.of<HomePageProvider>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            Container(
              width: 100.w,
              child: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, FavoritePage.routeName);
                  },
                  icon: Column(
                    children: [
                      Icon(Icons.favorite),
                      Text(
                        "Favorite",
                        style: TextStyle(fontSize: 12.sp),
                      )
                    ],
                  )),
            )
          ],
          title: Text("Recipe App"),
          elevation: 0,
        ),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              expandedHeight: 50.h,
              backgroundColor: Colors.white,
              floating: true,
              title: Padding(
                padding: EdgeInsets.only(left: 10.0.w),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r)),
                  elevation: 10,
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.grey.shade200,
                      filled: false,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(color: Colors.grey)),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(color: Colors.grey)),
                      suffixIcon: Icon(
                        Icons.search,
                      ),
                      hintText: 'Search recipe',
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                  child: Column(
                    children: [
                      _searchQuery.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              itemCount: _searchQuery.isEmpty
                                  ? 0
                                  : homePageProvider.mealsModel!.meals!.length,
                              itemBuilder: (context, index) {
                                final recipe =
                                    homePageProvider.mealsModel!.meals![index];
                                if (recipe.strMeal!
                                    .toLowerCase()
                                    .contains(_searchQuery.toLowerCase())) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, DetailsPage.routeName,
                                          arguments: [recipe]);
                                    },
                                    child: Card(
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          backgroundColor: Colors.black12,
                                          backgroundImage: NetworkImage(
                                            "${recipe.strMealThumb}",
                                          ),
                                        ),
                                        title: Text("${recipe.strMeal}"),
                                      ),
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            )
                          : FutureBuilder<MealsModel>(
                              future: homePageProvider.allMeals(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                    child: SpinKitFadingCircle(
                                      color: Colors.greenAccent,
                                    ),
                                  );
                                } else if (snapshot.hasError) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                } else if (snapshot.data == null) {
                                  return Text("snapshot data are null");
                                }
                                return GridView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                      crossAxisCount: 2,
                                      childAspectRatio: 1.1,
                                    ),
                                    itemCount: homePageProvider
                                        .mealsModel!.meals!.length,
                                    itemBuilder: (context, index) {
                                      final meals = homePageProvider
                                          .mealsModel!.meals![index];

                                      return InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, DetailsPage.routeName,
                                              arguments: [
                                                meals,
                                              ]);
                                        },
                                        child: Column(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15.0.r),
                                              child: Stack(
                                                children: [
                                                  Image.network(
                                                    "${meals.strMealThumb}",
                                                    height: 150.h,
                                                    width: double.infinity,
                                                    fit: BoxFit.fill,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            FittedBox(
                                              fit: BoxFit.contain,
                                              child: Text(
                                                "${meals.strMeal}",
                                                maxLines: 1,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.sp,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              }),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
