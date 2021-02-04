import 'package:flutter/material.dart';

import '../widgets/meal_item.dart';
import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-name';

  final List<Meal> availableMeals;

  CategoryMealsScreen(this.availableMeals);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle;
  String categoryId;
  List<Meal> categoryMeals;
  var _loadedInitDate = false;

  @override

  //* Tip: initState didn't work cuz it initilizes b4 widget build and context creation
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (!_loadedInitDate) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;

      categoryTitle = routeArgs['title'];
      final categoryId = routeArgs['id'];
      categoryMeals = widget.availableMeals.where((e) {
        return e.categories.contains(categoryId);
      }).toList();
      _loadedInitDate = true;
    }
    super.didChangeDependencies();
  }

  void _removeMeal(String removeId) {
    setState(() {
      categoryMeals.removeWhere((e) => e.id == removeId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealsItem(
              id: categoryMeals[index].id,
              imageUrl: categoryMeals[index].imageUrl,
              title: categoryMeals[index].title,
              affordability: categoryMeals[index].affordability,
              complexity: categoryMeals[index].complexity,
              duration: categoryMeals[index].duration,
              removeItem: _removeMeal);
        },
        itemCount: categoryMeals.length,
      ),
    );
  }
}
