List<Map<String, dynamic>> filterProducts(
  String selectedCompanyFilter,
  List<int> selectedSizeFilters,
  List<Map<String, dynamic>> productList,
) {

  Iterable<Map<String, dynamic>> filteredProductList = productList;

  if (selectedCompanyFilter != "All") {
    filteredProductList = productList
        .where((product) => product["company"] == selectedCompanyFilter);
        
  }

   if (selectedSizeFilters.isNotEmpty) { // <-- Changed condition: only check if list is NOT empty
    filteredProductList = filteredProductList.where(
      (product) {
        // Ensure product["sizes"] is treated as a List<int>
        final List<int> productSizes = product["sizes"] as List<int>;
        // Check if any of the product's sizes are in the selectedSizeFilters
        return productSizes.any((size) => selectedSizeFilters.contains(size));
      },
    );
  }

  return filteredProductList.toList();
}
