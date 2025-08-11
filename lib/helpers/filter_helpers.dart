List<Map<String, dynamic>> filterProducts(
  String selectedFilter,
  List<Map<String, dynamic>> productList,
) {
  if (selectedFilter == "All") {
    return productList;
  } else {
    List<Map<String, dynamic>> filteredResult = productList
        .where((product) => product["company"] == selectedFilter)
        .toList();

    return filteredResult;
  }
}
