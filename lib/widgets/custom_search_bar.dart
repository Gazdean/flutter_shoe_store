import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  CustomSearchBar({
    super.key,
    required this.border,
    required this.setSearchString,
  });

  final OutlineInputBorder border;
  final void Function(String) setSearchString;

  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: myController,
      autocorrect: false,
      decoration: InputDecoration(
        hintText: 'Search',
        prefixIcon: GestureDetector(
          onTap: () {
            setSearchString(myController.text);
          },
          child: Icon(Icons.search),
        ),
        border: border,
        enabledBorder: border,
        focusedBorder: border,
      ),
    );
  }
}
