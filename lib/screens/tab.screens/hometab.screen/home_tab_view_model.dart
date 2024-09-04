import 'dart:convert';
import 'dart:developer';

import 'package:diploy_task/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class HomeTabViewModel extends ChangeNotifier {
  List<dynamic> products = [];
  bool productsLoader = false;
  List<dynamic> filteredProducts = [];
  final TextEditingController searchController = TextEditingController();

//To perform basic search filteration on local list of products.
  void filterProducts(String query) {
    if (query.trim().isEmpty) {
      filteredProducts.clear();
      return;
    } else {
      filteredProducts.clear();
      filteredProducts = products.where((product) {
        return product["name"].trim().toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }

//For furture references
  void disposeValues() {
    products.clear();
    productsLoader = false;
    searchController.dispose();
  }

//After search is complete, and user wants to see original list, this method can be called.
  clearSearch(BuildContext context) {
    FocusScope.of(context).unfocus();
    searchController.clear();
    filteredProducts.clear();
  }

  setProductsLoader(bool value) {
    productsLoader = value;
  }

//To load products list from the hardcoded json file
  void loadProducts(BuildContext context) async {
    setProductsLoader(true);
    try {
      final String response = await rootBundle.loadString('assets/files/products.json');
      final data = await json.decode(response);
      if (data.containsKey("products")) {
        products = data["products"];
      }
      setProductsLoader(false);
      notifyListeners();
    } catch (e) {
      setProductsLoader(false);
      notifyListeners();
      if (context.mounted) {
        Utils.flushBarErrorMessage("Snap!", "Some error occured", context);
      }
      if (kDebugMode) {
        log(e.toString());
      }
    }
  }
}
