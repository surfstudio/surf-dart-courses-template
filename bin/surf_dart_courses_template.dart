import 'moks.dart';

class RawProductItem {
  final String name;
  final String categoryName;
  final String subcategoryName;
  final DateTime expirationDate;
  final int qty;

  RawProductItem(
      {required this.name,
      required this.categoryName,
      required this.subcategoryName,
      required this.expirationDate,
      required this.qty});
}

Map<String, Map<String, List<String>>> moks(List<RawProductItem> items) {
  final result = <String, Map<String, List<String>>>{};
  final now = DateTime.now();
  for (final item in items) {
    if (item.qty == 0 || now.isAfter(item.expirationDate)) {
      continue;
    }
    if (!result.containsKey(item.categoryName)) {
      result[item.categoryName] = {};
    }
    if (!result[item.categoryName]!.containsKey(item.subcategoryName)) {
      result[item.categoryName]![item.subcategoryName] = [];
    }
    result[item.categoryName]![item.subcategoryName]!.add(item.name);
  }
  return result;
}

void main() {
  print(moks(moks1));
}
