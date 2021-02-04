import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavouritesScreen extends StatelessWidget {
  final List<Meal> favMeals;

  FavouritesScreen(this.favMeals);

  @override
  Widget build(BuildContext context) {
    if (favMeals.isEmpty) {
      return Center(
        child: Text('You have no favorites yet - start adding some!'),
      );
    } else {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return MealsItem(
              id: favMeals[index].id,
              imageUrl: favMeals[index].imageUrl,
              title: favMeals[index].title,
              affordability: favMeals[index].affordability,
              complexity: favMeals[index].complexity,
              duration: favMeals[index].duration);
          // removeItem: _removeMeal);
        },
        itemCount: favMeals.length,
      );
    }
  }
}
