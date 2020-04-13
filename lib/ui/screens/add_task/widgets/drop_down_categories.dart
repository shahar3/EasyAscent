import 'package:easy_ascent/core/models/category.dart';
import 'package:flutter/material.dart';

import '../../../../constants.dart';

class DropDownCategories extends StatefulWidget {
  final Function updateCategory;

  DropDownCategories({@required this.updateCategory});

  @override
  _DropDownCategoriesState createState() => _DropDownCategoriesState();
}

class _DropDownCategoriesState extends State<DropDownCategories> {
  final List<Category> _categories = Category.getCategories();
  List<DropdownMenuItem<Category>> _dropDownMenuItems;
  Category _selectedCategory;

  void onChangeDropdownItem(Category value) {
    widget.updateCategory(value);
    setState(() {
      _selectedCategory = value;
    });
  }

  List<DropdownMenuItem<Category>> _buildDropDownMenuItems(
      List<Category> categories) {
    List<DropdownMenuItem<Category>> items = List();
    for (Category category in categories) {
      items.add(
        DropdownMenuItem(
          value: category,
          child: Container(
            child: Row(
              children: <Widget>[
                Icon(
                  category.icon,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(category.name),
              ],
            ),
          ),
        ),
      );
    }
    return items;
  }

  @override
  void initState() {
    _dropDownMenuItems = _buildDropDownMenuItems(_categories);
    _selectedCategory = _dropDownMenuItems[0].value;
    widget.updateCategory(_selectedCategory);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      iconEnabledColor: Colors.white,
      focusColor: Colors.pinkAccent,
      style: Constants.FORM_INPUT_TEXT_STYLE,
      value: _selectedCategory,
      items: _dropDownMenuItems,
      onChanged: onChangeDropdownItem,
    );
  }
}
