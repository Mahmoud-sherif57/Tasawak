import 'package:tasawak/model/categories/base_model.dart';
import 'package:tasawak/model/categories/categories_model.dart';
import 'package:tasawak/view_model/utils/categories_keys.dart';

/// edit the category data to have [men, women, children,hats,shoes,trousers,shirts]
List<CategoriesModel> categoriesData = [
  CategoriesModel(imageUrl: CategoriesKeys.hat, title: "Hat"),
  CategoriesModel(imageUrl: CategoriesKeys.bags, title: "Bags"),
  CategoriesModel(imageUrl: CategoriesKeys.shoes, title: "Shoes"),
  CategoriesModel(imageUrl: CategoriesKeys.blazer, title: "Blazer"),
  CategoriesModel(imageUrl: CategoriesKeys.womenShoes, title: "womenShoes"),
  CategoriesModel(imageUrl: CategoriesKeys.sportsShoes, title: "sport Shoes"),
  CategoriesModel(imageUrl: CategoriesKeys.trendyShirt, title: "TrendyShirt"),
  CategoriesModel(imageUrl: CategoriesKeys.sweatShirt, title: "SweatShirt"),
  CategoriesModel(imageUrl: CategoriesKeys.greenShirt, title: "GreenShirt"),
  CategoriesModel(imageUrl: CategoriesKeys.casualShirt, title: "CasualShirt"),
  CategoriesModel(imageUrl: CategoriesKeys.blueShoes, title: "Blue shoes"),
];


List<BaseModel> mainListData = [
  BaseModel(
    imageUrl: CategoriesKeys.sweatShirt,
    name: "SweatShirt",
    price: 113.99,
    review: 3.1,
    star: 4.8,
    id: 1,
    value: 1,
  ),
  BaseModel(
    imageUrl: CategoriesKeys.bags,
    name: "Bags",
    price: 95.55,
    review: 4.2,
    star: 4.7,
    id: 2,
    value: 1,
  ),
  BaseModel(
    imageUrl: CategoriesKeys.shoes,
    name: "shoes",
    price: 143.99,
    review: 5.6,
    star: 5.0,
    id: 2,
    value: 1,
  ),
  BaseModel(
    imageUrl: CategoriesKeys.sportsShoes ,
    name: "sport shoes",
    price: 188.99,
    review: 4.6,
    star: 5.0,
    id: 3,
    value: 1,
  ),

  BaseModel(
    imageUrl: CategoriesKeys.hat,
    name: "hat",
    price: 212.99,
    review: 2.6,
    star: 3.7,
    id: 4,
    value: 1,
  ),
  BaseModel(
    imageUrl: CategoriesKeys.blazer,
    name: "blazer",
    price: 432.99,
    review: 1.4,
    star: 2.4,
    id: 5,
    value: 1,
  ),
  BaseModel(
    imageUrl: CategoriesKeys.casualShirt,
    name: "casualShirt",
    price: 112.99,
    review: 4.2,
    star: 1.8,
    id: 6,
    value: 1,
  ),
  BaseModel(
    imageUrl: CategoriesKeys.greenShirt,
    name: "greenShirt",
    price: 320.99,
    review: 2.1,
    star: 3.1,
    id: 7,
    value: 1,
  ),
  BaseModel(
    imageUrl: CategoriesKeys.sweatShirt,
    name: "sweatShirt",
    price: 113.99,
    review: 3.1,
    star: 4.8,
    id: 8,
    value: 1,
  ),
  BaseModel(
    imageUrl: CategoriesKeys.blueShoes,
    name: "blueShoes",
    price: 113.99,
    review: 3.1,
    star: 4.8,
    id: 9,
    value: 1,
  ),
  BaseModel(
    imageUrl: CategoriesKeys.trendyShirt,
    name: "trendyShirt",
    price: 155.99,
    review: 3.6,
    star: 4.8,
    id: 10,
    value: 1,
  ),
  BaseModel(
    imageUrl: CategoriesKeys.womenShoes,
    name: "womenShoes",
    price: 113.99,
    review: 3.1,
    star: 4.8,
    id: 11,
    value: 1,
  ),
  BaseModel(
    imageUrl: CategoriesKeys.airJordanShoes,
    name: "air_j Shoes",
    price: 113.99,
    review: 3.1,
    star: 4.8,
    id: 12,
    value: 1,
  ),
];

List<BaseModel> itemsOnSearch = [];
List<BaseModel> itemsOnFavourite = [];
List<String> sizesList = ["S", "M", "L", "XL", "XXL"];
