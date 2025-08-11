import 'package:flutter/material.dart';

class HomePageTitle extends StatelessWidget {
  const HomePageTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'Shoes\nCollection',
      style: Theme.of(context).textTheme.titleLarge,
    );
  }
}
