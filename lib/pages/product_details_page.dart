import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoe_shop_app/providers/cart_provider.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key, required this.product});

  final Map<String, dynamic> product;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  late int selectedSize = 0;

  void onTap() {
    final Map<String, dynamic> product = widget.product;
    if (selectedSize != 0) {
      Provider.of<CartProvider>(context, listen: false).addProduct({
        'id': product['id'],
        'company': product['company'],
        'title': product['title'],
        'price': product['price'],
        'size': selectedSize,
        'imageUrl': product["imageUrl"],
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(
            SnackBar(
              showCloseIcon: true,
              content: Center(
                child: SizedBox(
                  height: 120,
                  child: Center(
                    child: Text(
                      "${product['title']} Size: $selectedSize\nAdded successfully",
                    ),
                  ),
                ),
              ),
            ),
          )
          .closed
          .whenComplete(() {
            setState(() {
              selectedSize = 0;
            });
          });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          showCloseIcon: true,
          content: Center(
            child: SizedBox(
              height: 120,
              child: Center(child: Text("Please select a size!")),
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Details")),
      body: Column(
        children: [
          Text(
            widget.product["title"] as String,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(
              widget.product["imageUrl"] as String,
              height: 450,
              fit: BoxFit.contain, // Added fit for better image scaling
            ),
          ),
          const Spacer(flex: 2),
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(245, 247, 249, 1),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '£${widget.product["price"]}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: (widget.product['sizes'] as List<int>).length,
                      itemBuilder: (context, index) {
                        final size =
                            (widget.product['sizes'] as List<int>)[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedSize = size;
                              });
                            },
                            child: Chip(
                              backgroundColor: selectedSize == size
                                  ? Theme.of(context).colorScheme.primary
                                  : null,
                              label: Text(size.toString()),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ElevatedButton(
                      onPressed: () {
                        onTap();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        fixedSize: const Size(400, 50),
                      ),
                      child: const Text(
                        'Add To Cart',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
