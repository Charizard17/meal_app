import 'package:flutter/material.dart';

import '../widget/main_drawer.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = '/settings';

  final Function saveSettings;
  final Map<String, bool> currentSettings;

  SettingsScreen(this.currentSettings, this.saveSettings);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _glutenFree = false;
  bool _lactoseFree = false;
  bool _vegan = false;
  bool _vegetarian = false;

  @override
  initState() {
    _glutenFree = widget.currentSettings['gluten'];
    _lactoseFree = widget.currentSettings['lactose'];
    _vegan = widget.currentSettings['vegan'];
    _vegetarian = widget.currentSettings['vegetarian'];
    super.initState();
  }

  Widget _buildSwitchListTile(
    String title,
    String description,
    bool currentValue,
    Function updateValue,
  ) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(description),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final selectedSettings = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegetarian': _vegetarian,
              };
              widget.saveSettings(selectedSettings);
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
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          Expanded(
              child: ListView(
            children: <Widget>[
              _buildSwitchListTile(
                'Gluten-free',
                'Only include gluten-free meals.',
                _glutenFree,
                (newValue) {
                  setState(
                    () {
                      _glutenFree = newValue;
                    },
                  );
                },
              ),
              _buildSwitchListTile(
                'Lactose-free',
                'Only include lactose-free meals.',
                _lactoseFree,
                (newValue) {
                  setState(
                    () {
                      _lactoseFree = newValue;
                    },
                  );
                },
              ),
              _buildSwitchListTile(
                'Vegetarian',
                'Only include vegetarian meals.',
                _vegetarian,
                (newValue) {
                  setState(
                    () {
                      _vegetarian = newValue;
                    },
                  );
                },
              ),
              _buildSwitchListTile(
                'Vegan',
                'Only include vegan meals.',
                _vegan,
                (newValue) {
                  setState(
                    () {
                      _vegan = newValue;
                    },
                  );
                },
              ),
            ],
          )),
        ],
      ),
    );
  }
}
