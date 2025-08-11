import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoe_shop_app/providers/cart_provider.dart';

class CartItemDeleteDialog extends StatelessWidget {
  const CartItemDeleteDialog({super.key, required this.cartItem});

  final Map<String, dynamic> cartItem;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Delete item",
        style: Theme.of(context).textTheme.titleMedium,
      ),
      content: Text(
        "Are you sure you want to delete\n${cartItem["title"]} size: ${cartItem["size"]}\nfrom your cart?",
        style: Theme.of(context).textTheme.titleSmall,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            "No",
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
        ),
        TextButton(
          onPressed: () {
            context
              .read<CartProvider>()
              .removeProduct(cartItem);
            Navigator.of(context).pop();
          },
          child: Text(
            "Yes",
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
