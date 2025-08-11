import 'package:flutter/material.dart';
import 'package:shoe_shop_app/data/api/get_products.dart';
import 'package:shoe_shop_app/data/global_variables.dart';
import 'package:shoe_shop_app/widgets/custom_search_bar.dart';
import 'package:shoe_shop_app/widgets/home_page_title.dart';
import 'package:shoe_shop_app/pages/product_details_page.dart';
import 'package:shoe_shop_app/widgets/product_item.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  late String selectedFilter;
  late List<Map<String, dynamic>> productList;
  late String searchString;

  @override
  void initState() {
    super.initState();
    selectedFilter = companyFilters[0];
    productList = products;
    searchString = "";
  }

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromRGBO(225, 225, 225, 1)),
      borderRadius: BorderRadius.horizontal(left: Radius.circular(50)),
    );

    void fetchProducts({
      String selectedFilter = 'All',
      String searchString = "",
    }) {
      List<Map<String, dynamic>> result = getproducts(
        searchString,
        selectedFilter,
      );

      setState(() {
        productList = result;
      });
    }

    void setSearchString(String newSearchString) {
      setState(() {
        searchString = newSearchString.trim();
      });
      setState(() {
        selectedFilter = companyFilters[0];
      });

      fetchProducts(searchString: newSearchString);
    }

    print(sizeFilters);

    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              Padding(padding: EdgeInsets.all(20.0), child: HomePageTitle()),
              Expanded(
                child: CustomSearchBar(
                  border: border,
                  setSearchString: setSearchString,
                ),
              ),
            ],
          ),
          if (searchString.isNotEmpty)
            Center(
              child: Row(
                children: [
                  Spacer(),
                  Text(searchString),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        searchString = "";
                        fetchProducts(selectedFilter: selectedFilter);
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(6.0, 0, 0, 0),
                      child: Icon(Icons.cancel),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
          Column(
            children: [
              SizedBox(
                height: 80,
                child: ListView.builder(
                  itemCount: companyFilters.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final filter = companyFilters[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedFilter = filter;
                            fetchProducts(
                              selectedFilter: selectedFilter,
                              searchString: searchString,
                            );
                          });
                        },
                        child: Chip(
                          backgroundColor: selectedFilter == filter
                              ? Theme.of(context).colorScheme.primary
                              : Color.fromRGBO(245, 247, 249, 1),
                          side: const BorderSide(
                            color: Color.fromRGBO(245, 247, 249, 1),
                          ),
                          label: Text(filter),
                          labelStyle: const TextStyle(fontSize: 16),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 15,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              SizedBox(
                height: 70,
                child: ListView.builder(
                  itemCount: sizeFilters.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final filter = sizeFilters[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedFilter = filter as String;
                            fetchProducts(
                              selectedFilter: selectedFilter,
                              searchString: searchString,
                            );
                          });
                        },
                        child: Chip(
                          backgroundColor: selectedFilter == filter
                              ? Theme.of(context).colorScheme.primary
                              : Color.fromRGBO(245, 247, 249, 1),
                          side: const BorderSide(
                            color: Color.fromRGBO(245, 247, 249, 1),
                          ),
                          label: Text(filter as String),
                          labelStyle: const TextStyle(fontSize: 13),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),

          productList.isEmpty
              ? Expanded(
                  child: Column(
                    children: [
                      Spacer(),
                      Text(
                        "Sorry. We have no products for $selectedFilter",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Spacer(),
                    ],
                  ),
                )
              : Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return GridView.builder(
                        itemCount: productList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: constraints.maxWidth >= 1080
                              ? 3
                              : constraints.maxWidth >= 650
                              ? 2
                              : 1,
                          mainAxisExtent: 500,
                        ),
                        itemBuilder: (context, index) {
                          final product = productList[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return ProductDetails(product: product);
                                  },
                                ),
                              );
                            },
                            child: ProductItem(
                              key: ValueKey(
                                DateTime.now().millisecondsSinceEpoch,
                              ),
                              title: product["title"] as String,
                              price: product["price"] as double,
                              imageUrl: product["imageUrl"] as String,
                              backgroundColor: index.isEven
                                  ? Color.fromRGBO(216, 240, 253, 1)
                                  : Color.fromRGBO(245, 247, 249, 1),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
