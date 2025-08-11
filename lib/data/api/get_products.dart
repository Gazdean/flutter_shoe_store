import 'package:shoe_shop_app/data/global_variables.dart';
import 'package:shoe_shop_app/helpers/filter_helpers.dart';
import 'package:shoe_shop_app/helpers/search_helpers.dart';

List<Map<String, dynamic>> getproducts(
  String searchString,
  String selectedFilter,
) {
  List<Map<String, dynamic>> productList = products;

  String normalisedSearchString = normaliseString(searchString);

  if (selectedFilter != "All") {
    productList = filterProducts(selectedFilter, productList);
  }

  if (normalisedSearchString.isNotEmpty) {
    List<Map<String, dynamic>> scoredProducts = [];

    for (var product in productList) {
      String normailisedProductTitle = normaliseString(product["title"]);
      int searchScore = createSearchScore(
        normalisedSearchString,
        normailisedProductTitle,
      );
      if (searchScore > 0) {
        scoredProducts.add({...product, 'searchScore': searchScore});
      }
    }

    scoredProducts.sort((a, b) => (b["searchScore"] as int ).compareTo(a["searchScore"] as int));

    return scoredProducts;
  } else {
    return productList;
  }
}
