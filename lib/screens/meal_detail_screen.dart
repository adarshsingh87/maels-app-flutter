import 'package:flutter/material.dart';

import '../dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-detail';

  final Function favMeal;
  final Function isFav;

  MealDetailScreen(this.favMeal, this.isFav);

  Widget buildSectionTitle(String text, BuildContext context) {
    return Container(
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline6,
      ),
      margin: EdgeInsets.symmetric(vertical: 10),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      height: 150,
      width: 325,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;

    final mealId = routeArgs['id'];

    final selectedMeal = DUMMY_MEALS.firstWhere((e) => e.id == mealId);
    return Scaffold(
        appBar: AppBar(
          title: Text(selectedMeal.title),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 20),
              height: 300,
              width: double.infinity,
              child: Image.network(selectedMeal.imageUrl),
            ),
            buildSectionTitle('Ingredients', context),
            buildContainer(
              ListView.builder(
                itemBuilder: (ctx, index) => Card(
                  color: Theme.of(context).accentColor,
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Text(
                        selectedMeal.ingredients[index],
                      )),
                ),
                itemCount: selectedMeal.ingredients.length,
              ),
            ),
            buildSectionTitle('Steps', context),
            buildContainer(
              ListView.builder(
                itemBuilder: (ctx, index) => Column(children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                      child: Text('# ${(index + 1)}'),
                    ),
                    title: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Text(
                          selectedMeal.steps[index],
                        )),
                  ),
                  Divider()
                ]),
                itemCount: selectedMeal.steps.length,
              ),
            ),
          ],
        )),
        floatingActionButton: FloatingActionButton(
          child: Icon(isFav(mealId) ? Icons.star : Icons.star_border),
          onPressed: () {
            favMeal(mealId);
          },
        ));
  }
}
