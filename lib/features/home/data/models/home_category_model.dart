import 'item_model.dart';

class HomeCategoryModel{
  final String categoryId;
  final String categoryName;
  final List<ItemModel> itemsList;

//<editor-fold desc="Data Methods">
  const HomeCategoryModel({
    required this.categoryId,
    required this.categoryName,
    required this.itemsList,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HomeCategoryModel &&
          runtimeType == other.runtimeType &&
          categoryId == other.categoryId &&
          categoryName == other.categoryName &&
          itemsList == other.itemsList);

  @override
  int get hashCode => categoryName.hashCode ^ itemsList.hashCode;

  @override
  String toString() {
    return 'HomeCategoryModel{' +
        ' categoryId: $categoryId,' +
        ' categoryName: $categoryName,' +
        ' itemsList: $itemsList,' +
        '}';
  }

  HomeCategoryModel copyWith({
    String? categoryId,
    String? categoryName,
    List<ItemModel>? itemsList,
  }) {
    return HomeCategoryModel(
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      itemsList: itemsList ?? this.itemsList,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'categoryId': this.categoryId,
      'categoryName': this.categoryName,
      'itemsList': this.itemsList.map((e) => e.toMap()).toList(),
    };
  }

  factory HomeCategoryModel.fromMap(Map<String, dynamic> map) {
    return HomeCategoryModel(
      categoryId: map['categoryId'] as String,
      categoryName: map['categoryName'] as String,
      itemsList: (map['itemsList'] as List<dynamic>)
          .map((e) => ItemModel.fromMap(e))
          .toList(),
    );
  }

//</editor-fold>
}