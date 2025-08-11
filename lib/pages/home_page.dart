import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoe_shop_app/pages/cart_page.dart';
import 'package:shoe_shop_app/widgets/product_list.dart';
import 'package:shoe_shop_app/providers/cart_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 0;

  List<Widget> pages = [ProductList(), CartPage()];

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>().cart;

    return Scaffold(
      body: IndexedStack(index: currentPage, children: pages),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 35,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        onTap: (value) {
          setState(() {
            currentPage = value;
          });
        },
        currentIndex: currentPage,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(Icons.shopping_cart),
                if (cart.isNotEmpty)
                  Positioned(
                    top: -3,
                    right: -3,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        cart.length.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
