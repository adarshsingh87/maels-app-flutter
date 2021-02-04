import 'package:flutter/material.dart';

import './dummy_data.dart';
import './models/meal.dart';

import './screens/filters_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/tab_screen.dart';
import './screens/categories_meals_screen.dart';
import './screens/categories_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'vegetarian': false,
    'vegan': false,
    'lactose': false
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> updatedFilters) {
    setState(() {
      _filters = updatedFilters;

      _availableMeals = DUMMY_MEALS.where((e) {
        if (_filters['gluten'] && !e.isGlutenFree) {
          return false;
        }
        if (_filters['vegetarian'] && !e.isVegetarian) {
          return false;
        }
        if (_filters['vegan'] && !e.isVegan) {
          return false;
        }
        if (_filters['lactose'] && !e.isLactoseFree) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFav(String id) {
    final existingIndex = _favoriteMeals.indexWhere((e) => e.id == id);
    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(
          DUMMY_MEALS.firstWhere((e) => e.id == id),
        );
      });
    }
  }

  bool _isFav(String id) {
    return _favoriteMeals.any((e) => e.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.amber,
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline6: TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoCondenced',
                  fontWeight: FontWeight.bold))),
      initialRoute: '/',
      routes: {
        '/': (ctx) => TabsScreen(_favoriteMeals),
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(_toggleFav, _isFav),
        FilterScreen.routeName: (ctx) => FilterScreen(_setFilters, _filters),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => CategoriesPage());
      },
    );
  }
}
