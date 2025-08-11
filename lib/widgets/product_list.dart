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
  late String selectedCompanyFilter;
  late List<int> selectedSizeFilters;
  late List<Map<String, dynamic>> productList;
  late String searchString;

  @override
  void initState() {
    super.initState();
    selectedCompanyFilter = companyFilters[0];
    selectedSizeFilters = [];
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
      String selectedCompanyFilter = 'All',
      List<int> selectedSizeFilters = const [],
      String searchString = "",
    }) {
      List<Map<String, dynamic>> result = getproducts(
        searchString,
        selectedCompanyFilter,
        selectedSizeFilters,
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
        selectedCompanyFilter = companyFilters[0];
      });

      fetchProducts(searchString: newSearchString);
    }

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
                        fetchProducts(
                          selectedCompanyFilter: selectedCompanyFilter,
                        );
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

          // Filters
          Column(
            children: [
              // Company filter
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
                            selectedCompanyFilter = filter;
                            fetchProducts(
                              selectedCompanyFilter: selectedCompanyFilter,
                              selectedSizeFilters: selectedSizeFilters,
                              searchString: searchString,
                            );
                          });
                        },
                        child: Chip(
                          backgroundColor: selectedCompanyFilter == filter
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

              // Size filter
              SizedBox(
                height: 70,
                child: ListView.builder(
                  itemCount: sizeFilters().length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final filter = sizeFilters()[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            if (filter == -1) {
                              selectedSizeFilters = [];
                            } else if (selectedSizeFilters.contains(filter)) {
                              selectedSizeFilters.remove(filter);
                            } else {
                              selectedSizeFilters.add(filter);
                            }

                            // Add size filter to fetch
                            fetchProducts(
                              selectedCompanyFilter: selectedCompanyFilter,
                              selectedSizeFilters: selectedSizeFilters,
                              searchString: searchString,
                            );
                          });
                        },
                        child: Chip(
                          backgroundColor: selectedSizeFilters.contains(filter) || (filter ==  -1 && selectedSizeFilters.isEmpty)
                              ? Theme.of(context).colorScheme.primary
                              : Color.fromRGBO(245, 247, 249, 1),
                          side: const BorderSide(
                            color: Color.fromRGBO(245, 247, 249, 1),
                          ),
                          label: Text(
                            filter == -1 ? "All Sizes" : filter.toString(),
                          ),
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
                        "Sorry. We have no products for this search and filters",
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
