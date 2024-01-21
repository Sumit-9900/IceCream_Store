// ignore_for_file: inference_failure_on_untyped_parameter, avoid_dynamic_calls

import 'package:store_pro/product_store/models/product.dart';

class IceCreamData {
  IceCreamData({
    this.icecreams,
  });

  IceCreamData.fromJson(Map<String, dynamic> json) {
    if (json['icecreams'] != null) {
      icecreams = <Icecreams>[];
      json['icecreams'].forEach((v) {
        icecreams!.add(Icecreams.fromJson(v as Map<String, dynamic>));
      });
    }
  }
  List<Icecreams>? icecreams;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (icecreams != null) {
      data['icecreams'] = icecreams!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Icecreams extends Product {
  Icecreams({
    this.name,
    this.price,
    this.image,
    this.description,
    this.story,
    this.ingredients,
    this.allergyInfo,
    this.dietaryCertifications,
    this.productId,
  });

  Icecreams.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String?;
    price = json['price'] as int?;
    image = json['image'] as String?;
    description = json['description'] as String?;
    story = json['story'] as String?;
    ingredients = json['ingredients'].cast<String>() as List<String>?;
    allergyInfo = json['allergy_info'] as String?;
    dietaryCertifications = json['dietary_certifications'] as String?;
    productId = json['productId'] as int?;
  }
  String? name;
  int? price;
  String? image;
  String? description;
  String? story;
  List<String>? ingredients;
  String? allergyInfo;
  String? dietaryCertifications;
  int? productId;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['price'] = price;
    data['image'] = image;
    data['description'] = description;
    data['story'] = story;
    data['ingredients'] = ingredients;
    data['allergy_info'] = allergyInfo;
    data['dietary_certifications'] = dietaryCertifications;
    data['productId'] = productId;
    return data;
  }
}
