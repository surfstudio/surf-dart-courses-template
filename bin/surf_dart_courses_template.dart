final listProduct = [
  RawProductItem(
    name: 'Персик',
    categoryName: 'Растительная пища',
    subcategoryName: 'Фрукты',
    expirationDate: DateTime(2023, 12, 22),
    qty: 5,
  ),
  RawProductItem(
    name: 'Молоко',
    categoryName: 'Молочные продукты',
    subcategoryName: 'Напитки',
    expirationDate: DateTime(2022, 12, 22),
    qty: 5,
  ),
  RawProductItem(
    name: 'Кефир',
    categoryName: 'Молочные продукты',
    subcategoryName: 'Напитки',
    expirationDate: DateTime(2022, 12, 22),
    qty: 5,
  ),
  RawProductItem(
    name: 'Творог',
    categoryName: 'Молочные продукты',
    subcategoryName: 'Не напитки',
    expirationDate: DateTime(2022, 12, 22),
    qty: 0,
  ),
  RawProductItem(
    name: 'Творожок',
    categoryName: 'Молочные продукты',
    subcategoryName: 'Не напитки',
    expirationDate: DateTime(2022, 12, 22),
    qty: 0,
  ),
  RawProductItem(
    name: 'Творог',
    categoryName: 'Молочные продукты',
    subcategoryName: 'Не напитки',
    expirationDate: DateTime(2022, 12, 22),
    qty: 0,
  ),
  RawProductItem(
    name: 'Гауда',
    categoryName: 'Молочные продукты',
    subcategoryName: 'Сыры',
    expirationDate: DateTime(2022, 12, 22),
    qty: 3,
  ),
  RawProductItem(
    name: 'Маасдам',
    categoryName: 'Молочные продукты',
    subcategoryName: 'Сыры',
    expirationDate: DateTime(2022, 12, 22),
    qty: 2,
  ),
  RawProductItem(
    name: 'Яблоко',
    categoryName: 'Растительная пища',
    subcategoryName: 'Фрукты',
    expirationDate: DateTime(2022, 12, 4),
    qty: 4,
  ),
  RawProductItem(
    name: 'Морковь',
    categoryName: 'Растительная пища',
    subcategoryName: 'Овощи',
    expirationDate: DateTime(2022, 12, 23),
    qty: 51,
  ),
  RawProductItem(
    name: 'Черника',
    categoryName: 'Растительная пища',
    subcategoryName: 'Ягоды',
    expirationDate: DateTime(2022, 12, 25),
    qty: 0,
  ),
  RawProductItem(
    name: 'Курица',
    categoryName: 'Мясо',
    subcategoryName: 'Птица',
    expirationDate: DateTime(2022, 12, 18),
    qty: 2,
  ),
  RawProductItem(
    name: 'Говядина',
    categoryName: 'Мясо',
    subcategoryName: 'Не птица',
    expirationDate: DateTime(2022, 12, 17),
    qty: 0,
  ),
  RawProductItem(
    name: 'Телятина',
    categoryName: 'Мясо',
    subcategoryName: 'Не птица',
    expirationDate: DateTime(2022, 12, 17),
    qty: 0,
  ),
  RawProductItem(
    name: 'Индюшатина',
    categoryName: 'Мясо',
    subcategoryName: 'Птица',
    expirationDate: DateTime(2022, 12, 17),
    qty: 0,
  ),
  RawProductItem(
    name: 'Утка',
    categoryName: 'Мясо',
    subcategoryName: 'Птица',
    expirationDate: DateTime(2022, 12, 18),
    qty: 2,
  ),
  RawProductItem(
    name: 'Гречка',
    categoryName: 'Растительная пища',
    subcategoryName: 'Крупы',
    expirationDate: DateTime(2022, 12, 22),
    qty: 8,
  ),
  RawProductItem(
    name: 'Свинина',
    categoryName: 'Мясо',
    subcategoryName: 'Не птица',
    expirationDate: DateTime(2022, 12, 23),
    qty: 5,
  ),
  RawProductItem(
    name: 'Груша',
    categoryName: 'Растительная пища',
    subcategoryName: 'Фрукты',
    expirationDate: DateTime(2022, 12, 25),
    qty: 5,
  ),
];

void main(List<String> arguments) {
  sort(listProduct);
}

// интерфейс
abstract class Filter {
  bool apply(RawProductItem products);
}

class CategoryFilter implements Filter {
  final String categoryName;

  CategoryFilter(this.categoryName);

  @override
  bool apply(RawProductItem products) {
    return products.categoryName == categoryName;
  }
}

class SubcategoryFilter implements Filter {
  final String subcategoryName;

  SubcategoryFilter(this.subcategoryName);

  @override
  bool apply(RawProductItem products) {
    return products.subcategoryName == subcategoryName;
  }
}

void sort(List<RawProductItem> products) {
  var productFinish;
  final productExpirationDates = getProductsWithExpirationDates(products);
  final productsStock = productsInStock(productExpirationDates);
  final productCategoryName =
      productsStock.map<String>((e) => e.categoryName).toSet().toList();
  final productsubcategoryName =
      productsStock.map<String>((e) => e.subcategoryName).toSet().toList();

  // for(int i = 0; i <= productCategoryName.length; i++){
  //   for(int j = 0; j <= productsubcategoryName.length; j ++){
  //     for(int p = 0; p < productsStock.length; p++){
  //         if()
  //     }
  //   }
  // }

  for (var category in productCategoryName) {
    var productIteration = productsStock
        .where((product) => CategoryFilter(category).apply(product))
        .toSet()
        .toList();
    for (var subcategory in productsubcategoryName) {
      // productFinish = productIteration
      //     .where((product) => SubcategoryFilter(subcategory).apply(product))
      //     .toList()
      //     .map<Map<String, Map<String, List<String>>>>((e) => {
      //           e.categoryName: {
      //             e.subcategoryName: [e.name]
      //           }
      //         });
      print(productIteration
          .where((product) => SubcategoryFilter(subcategory).apply(product))
          .toSet()
          .toList()
          .map<Map<String, Map<String, List<String>>>>((e) => {
                e.categoryName: {
                  e.subcategoryName: [e.name]
                }
              })
          .toSet()
          .toList());
    }
  }
}

List<RawProductItem> getProductsWithExpirationDates(
        List<RawProductItem> products) =>
    products
        .where(
            (element) => element.expirationDate.isAfter(DateTime(2021, 12, 21)))
        .toList();

List<RawProductItem> productsInStock(List<RawProductItem> products) =>
    products.where((element) => element.qty > 0).toList();

class RawProductItem {
  final String name;
  final String categoryName;
  final String subcategoryName;
  final DateTime expirationDate;
  final int qty;

  const RawProductItem({
    required this.name,
    required this.categoryName,
    required this.subcategoryName,
    required this.expirationDate,
    required this.qty,
  });

  @override
  String toString() {
    return name;
  }
}
