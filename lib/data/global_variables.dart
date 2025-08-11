final List<Map<String, dynamic>> products = [
  {
    'id': 0,
    'company': "Nike",
    'title': "Men's Nike Air Jordan",
    'price': 67.49,
    'sizes': [4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15],
    'imageUrl': "assets/images/nike_air_jordan.png",
  },
  {
    'id': 1,
    'company': "Adidas",
    'title': "Men's Adidas Samba",
    'price': 75.00,
    'sizes': [8, 9, 11, 12],
    'imageUrl': "assets/images/adidas_samba.png",
  },
  {
    'id': 2,
    'company': "Nike",
    'title': "Men's Nike Air Max",
    'price': 174.99,
    'sizes': [7, 8, 9, 10, 11],
    'imageUrl': "assets/images/nike_air_max.png",
  },
  {
    'id': 3,
    'company': "Nike",
    'title': "Women's Nike Dunk Low",
    'price': 54.99,
    'sizes': [4, 5, 7, 8],
    'imageUrl': "assets/images/nike_dunk_low.png",
  },
  {
    'id': 4,
    'company': "Adidas",
    'title': "Women's Superstar Jelly Pink",
    'price': 19.99,
    'sizes': [6, 7, 8],
    'imageUrl': "assets/images/adidas_superstar_jelly_pink.png",
  },
  {
    'id': 4,
    'company': "Adidas",
    'title': "Men's Adidas AS520",
    'price': 30.99,
    'sizes': [6, 7, 8, 10, 12],
    'imageUrl': "assets/images/adidas_as520.png",
  },
];

final List<String> companyFilters = [
  'All',
  ...products.map((product) => product["company"] as String).toSet(),
];

