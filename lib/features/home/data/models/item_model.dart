import 'package:rental_app/core/enums/rent_type_enum.dart';

class ItemModel{
  final String itemName;
  final dynamic itemPrice;
  final List<dynamic> itemImages;
  final RentTypeEnum rentTypeEnum;
  final bool isAvailable;
  final dynamic rating;
  final String ownerName;
  final String itemDescription;
  final Map<String, dynamic> searchTags;

//<editor-fold desc="Data Methods">
  const ItemModel({
    required this.itemName,
    required this.itemPrice,
    required this.itemImages,
    required this.rentTypeEnum,
    required this.isAvailable,
    required this.rating,
    required this.ownerName,
    required this.itemDescription,
    required this.searchTags,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ItemModel &&
          runtimeType == other.runtimeType &&
          itemName == other.itemName &&
          itemPrice == other.itemPrice &&
          itemImages == other.itemImages &&
          rentTypeEnum == other.rentTypeEnum &&
          isAvailable == other.isAvailable &&
          rating == other.rating &&
          searchTags == other.searchTags &&
          ownerName == other.ownerName &&
          itemDescription == other.itemDescription);

  @override
  int get hashCode =>
      itemName.hashCode ^
      itemPrice.hashCode ^
      itemImages.hashCode ^
      rentTypeEnum.hashCode ^
      isAvailable.hashCode ^
      rating.hashCode ^
      ownerName.hashCode ^
      searchTags.hashCode ^
      itemDescription.hashCode;

  @override
  String toString() {
    return 'ItemModel{' +
        ' itemName: $itemName,' +
        ' itemPrice: $itemPrice,' +
        ' itemImages: $itemImages,' +
        ' rentTypeEnum: $rentTypeEnum,' +
        ' isAvailable: $isAvailable,' +
        ' rating: $rating,' +
        ' ownerName: $ownerName,' +
        ' searchTags: $searchTags,' +
        ' itemDescription: $itemDescription,' +
        '}';
  }

  ItemModel copyWith({
    String? itemName,
    dynamic itemPrice,
    List<dynamic>? itemImages,
    RentTypeEnum? rentTypeEnum,
    bool? isAvailable,
    dynamic rating,
    String? ownerName,
    String? itemDescription,
    Map<String, dynamic>? searchTags,
  }) {
    return ItemModel(
      itemName: itemName ?? this.itemName,
      itemPrice: itemPrice ?? this.itemPrice,
      itemImages: itemImages ?? this.itemImages,
      rentTypeEnum: rentTypeEnum ?? this.rentTypeEnum,
      isAvailable: isAvailable ?? this.isAvailable,
      rating: rating ?? this.rating,
      ownerName: ownerName ?? this.ownerName,
      searchTags: searchTags ?? this.searchTags,
      itemDescription: itemDescription ?? this.itemDescription,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'itemName': this.itemName,
      'itemPrice': this.itemPrice,
      'itemImages': this.itemImages,
      'rentTypeEnum': this.rentTypeEnum.type,
      'isAvailable': this.isAvailable,
      'rating': this.rating,
      'ownerName': this.ownerName,
      'itemDescription': this.itemDescription,
      'searchTags': this.searchTags,
    };
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      itemName: map['itemName'] as String,
      itemPrice: map['itemPrice'] as dynamic,
      itemImages: map['itemImages'] as List<dynamic>,
      rentTypeEnum: (map['rentTypeEnum'] as String).toRentTypeEnum(),
      isAvailable: map['isAvailable'] as bool,
      rating: map['rating'] as dynamic,
      ownerName: map['ownerName'] as String,
      searchTags: map['searchTags'] as Map<String, dynamic>,
      itemDescription: map['itemDescription'] as String,
    );
  }

//</editor-fold>
}