import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:store_pro/product_store/models/icecream.dart';

class ProductRepo {
  static Future<List<Icecreams>> loadAllIceCreams() async {
    final res = await rootBundle.loadString('assets/icecream.json');
    final icecreams =
        IceCreamData.fromJson(jsonDecode(res) as Map<String, dynamic>);
    return icecreams.icecreams!;
  }
}
