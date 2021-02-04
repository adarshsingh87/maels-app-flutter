import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/filters';
  final Function saveFilters;
  final Map<String, bool> filters;

  FilterScreen(this.saveFilters, this.filters);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool _vegetarian;
  bool _glutenFree;
  bool _vegan;
  bool _lactoseFree;

  @override
  void initState() {
    // TODO: implement initState
    _vegetarian = widget.filters['vegetarian'];
    _glutenFree = widget.filters['gluten'];
    _vegan = widget.filters['vegan'];
    _lactoseFree = widget.filters['lactose'];
    super.initState();
  }

  Widget _buildSwitchList(
      String title, String description, bool vari, Function updateValue) {
    return SwitchListTile(
      title: Text(title),
      value: vari,
      onChanged: updateValue,
      subtitle: Text(description),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('The Filters'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                widget.saveFilters({
                  'gluten': _glutenFree,
                  'vegetarian': _vegetarian,
                  'vegan': _vegan,
                  'lactose': _lactoseFree
                });

                Navigator.of(context).pushReplacementNamed('/');
              },
            )
          ],
        ),
        drawer: MainDrawer(),
        body: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                'Adjust your meal selection',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  _buildSwitchList('Gluten-Free',
                      'Only include Gluten-Free meals', _glutenFree, (newVal) {
                    setState(() {
                      _glutenFree = newVal;
                    });
                  }),
                  _buildSwitchList('Vegetarian',
                      'Only include Vegetarian meals', _vegetarian, (newVal) {
                    setState(() {
                      _vegetarian = newVal;
                    });
                  }),
                  _buildSwitchList('Vegan', 'Only include Vegan meals', _vegan,
                      (newVal) {
                    setState(() {
                      _vegan = newVal;
                    });
                  }),
                  _buildSwitchList(
                      'Lactose-Free',
                      'Only include Lactose-Free meals',
                      _lactoseFree, (newVal) {
                    setState(() {
                      _lactoseFree = newVal;
                    });
                  }),
                ],
              ),
            )
          ],
        ));
  }
}
