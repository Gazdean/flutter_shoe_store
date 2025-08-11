import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoe_shop_app/widgets/cart_item_delete_dialog.dart';
import 'package:shoe_shop_app/providers/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>().cart;
    // final cart = Provider.of<CartProvider>(context).cart;

    void onTap(cartItem) {
      showDialog(
        context: context,
        builder: (context) {
          return CartItemDeleteDialog(cartItem: cartItem);
        },
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Cart")),
      body: cart.isEmpty
          ? Center(
              child: Text(
                "Your cart is empty",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            )
          : ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final cartItem = cart[index];

                return Center(
                  child: SizedBox(
                    width: 500,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(
                          cartItem['imageUrl'] as String,
                        ),
                        radius: 30,
                      ),
                      title: Text(
                        cartItem["title"].toString(),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      subtitle: Text('Size: ${cartItem['size']}'),
                      trailing: IconButton(
                        onPressed: () {
                          onTap(cartItem);
                        },
                        icon: const Icon(Icons.delete, color: Colors.red),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
