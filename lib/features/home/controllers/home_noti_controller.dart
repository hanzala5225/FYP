import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_app/core/enums/rent_type_enum.dart';
import 'package:rental_app/features/home/data/models/item_model.dart';
import 'package:uuid/uuid.dart';

import '../../../commons/common_functions/search_tags_handler.dart';
import '../data/apis/home_apis.dart';
import '../data/models/home_category_model.dart';
import '../data/models/search_parameters_model.dart';

final homeNotiController = ChangeNotifierProvider((ref) {
  final homeApi = ref.watch(homeApis);
  return HomeNotiController(iHomeApis: homeApi);
});

final fetchAllCategoriesController = StreamProvider((ref) {
  final homeCtr = ref.watch(homeNotiController);
  return homeCtr.getAllCategories();
});

final fetchAllItemsController = StreamProvider.family((ref, SearchParametersModel searchParametersModel) {
  final homeCtr = ref.watch(homeNotiController);
  return homeCtr.getAllItems(
    descendingRating: searchParametersModel.descendingRating,
    descendingPrice: searchParametersModel.desscendingPrice,);
});

final searchAllItemsController = StreamProvider.family((ref, SearchParametersModel searchParametersModel) {
  final homeCtr = ref.watch(homeNotiController);
  return homeCtr.getAllSearchedItems(
      itemName: searchParametersModel.searchWord,
      descendingRating: searchParametersModel.descendingRating,
      descendingPrice: searchParametersModel.desscendingPrice,
  );
});

class HomeNotiController extends ChangeNotifier {
  IHomeApis _iHomeApis;
  HomeNotiController({required IHomeApis iHomeApis})
      : _iHomeApis = iHomeApis,
        super();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  setLoading(bool stat) {
    _isLoading = stat;
    notifyListeners();
  }

  bool _price = false;
  bool get price => _price;
  setPrice(bool val){
    _price = val;
    notifyListeners();
  }

  bool _rating = false;
  bool get rating => _rating;
  setRating(bool val){
    _rating = val;
    notifyListeners();
  }

  Stream<List<HomeCategoryModel>> getAllCategories(){
    return _iHomeApis.fetchAllCategories().map((snapshots) {
      return snapshots.docs.map((snapshot) {
        return HomeCategoryModel.fromMap(snapshot.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  Stream<List<ItemModel>> getAllItems({required bool descendingPrice, required bool descendingRating}) {
    return _iHomeApis.fetchAllItems().map((categories) {
      List<ItemModel> allitems = [];
      for (var category in categories.docs) {
        Map<String, dynamic> data = category.data();
        for (var item in data['itemsList']) {
          ItemModel model = ItemModel.fromMap(item);
          allitems.add(model);
        }
      }
      allitems.sort((a, b) {
        if (descendingPrice) {
          return b.itemPrice.compareTo(a.itemPrice);
        } else {
          return a.itemPrice.compareTo(b.itemPrice);
        }
      });
      if (descendingRating) {
        allitems.sort((a, b) {
          return b.rating.compareTo(a.rating);
        });
      }
      return allitems;
    });
  }



  Future categoryUpload({required HomeCategoryModel homeCategoryModel})async{
    await _iHomeApis.uploadCategories(homeCategoryModel: homeCategoryModel);
  }

  Future uploadAllCategories()async{
    _homeCategories.forEach((category)async {
      await categoryUpload(homeCategoryModel: category);
    });
  }

  Stream<List<ItemModel>> getAllSearchedItems({required String itemName, required bool descendingPrice, required bool descendingRating}) {
    String query = itemName.trim().toLowerCase();
    List<String> filters = query.split(' ');
    print("Descending Price: ${descendingPrice}");
    print("Descending Rating: ${descendingRating}");

    return _iHomeApis.getSearchedItems().map((categories) {
      List<ItemModel> allitems = [];

      for (var category in categories.docs) {
        Map<String, dynamic> data = category.data();

        for (var item in data['itemsList']) {
          print("Data: ${item['searchTags']}");
          bool matchesQuery = filters.every((field) => item['searchTags'][field] == true);

          if (matchesQuery) {
            ItemModel model = ItemModel.fromMap(item);
            allitems.add(model);
          }
        }
      }

      // Sort the list based on parameters
      allitems.sort((a, b) {
        // Sorting by price
        if (descendingPrice) {
          return b.itemPrice.compareTo(a.itemPrice);
        } else {
          return a.itemPrice.compareTo(b.itemPrice);
        }
      });

      // If ratings should be considered for sorting
      if (descendingRating) {
        allitems.sort((a, b) {
          return b.rating.compareTo(a.rating);
        });
      }

      return allitems;
    });
  }


  final List<HomeCategoryModel> _homeCategories = [
    HomeCategoryModel(
      categoryName: "AC",
      categoryId: Uuid().v4(),
      itemsList: [
        ItemModel(
          itemName: "Central Air Conditioner",
          itemPrice: 25,
          itemImages: [
            "https://hughesairco.com/wp-content/uploads/2018/11/Depositphotos_142395460_s-2015-1.jpg",
          ],
          rentTypeEnum: RentTypeEnum.day,
          isAvailable: true,
          rating: 0.0,
          ownerName: "Martin Luther King",
          itemDescription:
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry'Lorem Ipsum has been the industry' Lorem Ipsum has",
          searchTags: searchTagsHandler(
            name: "Central Air Conditioner",
            description:
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry'Lorem Ipsum has been the industry' Lorem Ipsum has",
            ownerName: "Martin Luther King",
          ),
        ),
        ItemModel(
          itemName: "Window Air Conditioner",
          itemPrice: 50,
          itemImages: [
            "https://images.jdmagicbox.com/rep/b2b/ac-unit/ac-unit-4.jpg",
          ],
          rentTypeEnum: RentTypeEnum.day,
          isAvailable: true,
          rating: 0.0,
          ownerName: "Martin Luther King",
          itemDescription:
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry'Lorem Ipsum has been the industry' Lorem Ipsum has",
          searchTags: searchTagsHandler(
            name: "Window Air Conditioner",
            description:
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry'Lorem Ipsum has been the industry' Lorem Ipsum has",
            ownerName: "Martin Luther King",
          ),
        ),
        ItemModel(
          itemName: "Smart Air Conditioner",
          itemPrice: 150,
          itemImages: [
            "https://www.thespruce.com/thmb/1Gcs5LiPWqv6SaA_pVwmu5EphZs=/6720x0/filters:no_upscale():max_bytes(150000):strip_icc()/how-types-of-air-conditioning-systems-work-1824734-hero-740003052ebb4bebb5dd9b42e441c118.jpg",
          ],
          rentTypeEnum: RentTypeEnum.day,
          isAvailable: true,
          rating: 0.0,
          ownerName: "Martin Luther King",
          itemDescription:
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry'Lorem Ipsum has been the industry' Lorem Ipsum has",
          searchTags: searchTagsHandler(
            name: "Smart Air Conditioner",
            description:
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry'Lorem Ipsum has been the industry' Lorem Ipsum has",
            ownerName: "Martin Luther King",
          ),
        ),
        ItemModel(
          itemName: "Ductless Mini-Split Air Conditioner.",
          itemPrice: 40,
          itemImages: [
            "https://smartacsolutions.com/wp-content/uploads/2023/05/0705062f7d37431693ae2a0698ef295f.jpg",
          ],
          rentTypeEnum: RentTypeEnum.day,
          isAvailable: true,
          rating: 0.0,
          ownerName: "Martin Luther King",
          itemDescription:
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry'Lorem Ipsum has been the industry' Lorem Ipsum has",
          searchTags: searchTagsHandler(
            name: "Ductless Mini-Split Air Conditioner.",
            description:
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry'Lorem Ipsum has been the industry' Lorem Ipsum has",
            ownerName: "Martin Luther King",
          ),
        ),
      ],
    ),
    HomeCategoryModel(
      categoryId: Uuid().v4(),
      categoryName: "Frifge & DeepFreezer",
      itemsList: [
        ItemModel(
          itemName: "Chest Freezers",
          itemPrice: 100,
          itemImages: [
            "https://learncompact.wpenginepowered.com/wp-content/uploads/2014/02/chest_freezer.jpg",
          ],
          rentTypeEnum: RentTypeEnum.week,
          isAvailable: true,
          rating: 0.0,
          ownerName: "Martin Luther King",
          itemDescription:
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry'Lorem Ipsum has been the industry' Lorem Ipsum has",
          searchTags: searchTagsHandler(
            name: "Chest Freezers",
            description:
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry'Lorem Ipsum has been the industry' Lorem Ipsum has",
            ownerName: "Martin Luther King",
          ),
        ),
        ItemModel(
          itemName: "Drawer Freezers",
          itemPrice: 160,
          itemImages: [
            "https://learncompact.wpenginepowered.com/wp-content/uploads/2014/02/drawer_freezer.jpg",
          ],
          rentTypeEnum: RentTypeEnum.day,
          isAvailable: true,
          rating: 0.0,
          ownerName: "Martin Luther King",
          itemDescription:
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry'Lorem Ipsum has been the industry' Lorem Ipsum has",
          searchTags: searchTagsHandler(
            name: "Drawer Freezers",
            description:
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry'Lorem Ipsum has been the industry' Lorem Ipsum has",
            ownerName: "Martin Luther King",
          ),
        ),
        ItemModel(
          itemName: "Upright Freezers",
          itemPrice: 500,
          itemImages: [
            "https://learncompact.wpenginepowered.com/wp-content/uploads/2014/02/upright_freezer.jpg",
          ],
          rentTypeEnum: RentTypeEnum.month,
          isAvailable: true,
          rating: 0.0,
          ownerName: "Martin Luther King",
          itemDescription:
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry'Lorem Ipsum has been the industry' Lorem Ipsum has",
          searchTags: searchTagsHandler(
            name: "Upright Freezers",
            description:
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry'Lorem Ipsum has been the industry' Lorem Ipsum has",
            ownerName: "Martin Luther King",
          ),
        ),
        ItemModel(
          itemName: "Portable Freezers",
          itemPrice: 1000,
          itemImages: [
            "https://learncompact.wpenginepowered.com/wp-content/uploads/2013/08/portable_freezer.jpg",
          ],
          rentTypeEnum: RentTypeEnum.week,
          isAvailable: true,
          rating: 0.0,
          ownerName: "Martin Luther King",
          itemDescription:
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry'Lorem Ipsum has been the industry' Lorem Ipsum has",
          searchTags: searchTagsHandler(
            name: "Portable Freezers",
            description:
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry'Lorem Ipsum has been the industry' Lorem Ipsum has",
            ownerName: "Martin Luther King",
          ),
        ),
      ],
    ),
    HomeCategoryModel(
      categoryId: Uuid().v4(),
      categoryName: "Oven",
      itemsList: [
        ItemModel(
          itemName: "GAS OR ELECTRIC",
          itemPrice: 25,
          itemImages: [
            "https://blog-cdn.el.olx.com.pk/wp-content/uploads/2022/04/20220004/oven-electric.jpg",
          ],
          rentTypeEnum: RentTypeEnum.day,
          isAvailable: true,
          rating: 0.0,
          ownerName: "Martin Luther King",
          itemDescription:
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry'Lorem Ipsum has been the industry' Lorem Ipsum has",
          searchTags: searchTagsHandler(
            name: "GAS OR ELECTRIC",
            description:
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry'Lorem Ipsum has been the industry' Lorem Ipsum has",
            ownerName: "Martin Luther King",
          ),
        ),
        ItemModel(
          itemName: "CONVECTION OR CONVENTIONAL OVENS",
          itemPrice: 300,
          itemImages: [
            "https://blog-cdn.el.olx.com.pk/wp-content/uploads/2022/04/20215631/oven-kitchen.jpg",
          ],
          rentTypeEnum: RentTypeEnum.day,
          isAvailable: true,
          rating: 0.0,
          ownerName: "Martin Luther King",
          itemDescription:
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry'Lorem Ipsum has been the industry' Lorem Ipsum has",
          searchTags: searchTagsHandler(
            name: "CONVECTION OR CONVENTIONAL OVENS",
            description:
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry'Lorem Ipsum has been the industry' Lorem Ipsum has",
            ownerName: "Martin Luther King",
          ),
        ),
        ItemModel(
          itemName: "Steam Oven for Baking",
          itemPrice: 250,
          itemImages: [
            "https://blog-cdn.el.olx.com.pk/wp-content/uploads/2022/04/20221213/oven-stove-multiple-layers.jpg",
          ],
          rentTypeEnum: RentTypeEnum.day,
          isAvailable: true,
          rating: 0.0,
          ownerName: "Martin Luther King",
          itemDescription:
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry'Lorem Ipsum has been the industry' Lorem Ipsum has",
          searchTags: searchTagsHandler(
            name: "Steam Oven for Baking",
            description:
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry'Lorem Ipsum has been the industry' Lorem Ipsum has",
            ownerName: "Martin Luther King",
          ),
        ),
      ],
    ),
    HomeCategoryModel(
      categoryName: "Juicer",
      categoryId: Uuid().v4(),
      itemsList: [
        ItemModel(
          itemName: "Breville Juice Fountain Cold Plus",
          itemPrice: 600,
          itemImages: [
            "https://juicernet.com/wp-content/uploads/2021/03/Screen-Shot-2021-03-11-at-3.40.26-PM.png",
          ],
          rentTypeEnum: RentTypeEnum.day,
          isAvailable: true,
          rating: 0.0,
          ownerName: "Martin Luther King",
          itemDescription:
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry'Lorem Ipsum has been the industry' Lorem Ipsum has",
          searchTags: searchTagsHandler(
            name: "Breville Juice Fountain Cold Plus",
            description:
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry'Lorem Ipsum has been the industry' Lorem Ipsum has",
            ownerName: "Martin Luther King",
          ),
        ),
        ItemModel(
          itemName: "Cold-Press Juicers",
          itemPrice: 154,
          itemImages: [
            "https://www.shutterstock.com/image-photo/fresh-juice-juicer-photo-on-260nw-435420460.jpg",
          ],
          rentTypeEnum: RentTypeEnum.week,
          isAvailable: true,
          rating: 0.0,
          ownerName: "Martin Luther King",
          itemDescription:
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry'Lorem Ipsum has been the industry' Lorem Ipsum has",
          searchTags: searchTagsHandler(
            name: "Cold-Press Juicers",
            description:
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry'Lorem Ipsum has been the industry' Lorem Ipsum has",
            ownerName: "Martin Luther King",
          ),
        ),
      ],
    ),
  ];
  List<HomeCategoryModel> get homeCategories => _homeCategories;
}
