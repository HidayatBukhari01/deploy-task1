import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartViewModel extends ChangeNotifier {
  List<dynamic> cartItems = [];

  //This method can be called when user logs out (for future implementations)
  void disposeValues() {
    cartItems.clear();
  }

//This function is get all cart items from local storage
  void getCartItems() async {
    final localStorage = await SharedPreferences.getInstance();
    final response = localStorage.getString('cartItems');
    if (response != null) {
      final data = jsonDecode(response);
      cartItems = data; //Assigning fetched items to local list.
    } else {
      cartItems.clear();
    }
    notifyListeners();
  }

//This function is to add any product to cart, increase its count both locally and in device storage as well
  void addToCart(dynamic product, int count) async {
    final localStorage = await SharedPreferences.getInstance();
    final index = cartItems.indexWhere((item) => item['id'] == product['id']);
    if (index != -1) {
      cartItems[index]['count'] += count;
    } else {
      final payload = {...product, "count": count};
      cartItems.add(payload);
    }
    localStorage.setString('cartItems', jsonEncode(cartItems));
    notifyListeners();
  }

//This is to dynamically show the Add To Cart Button in product description
  bool checkIfAdded(String id) {
    if (cartItems.isEmpty) {
      return false;
    } else {
      final index = cartItems.indexWhere((item) => item['id'] == id);
      if (index != -1) {
        return true;
      }
      return false;
    }
  }

//This method is to get total count of each product based on its id, so that it can be displayed and maniupulated accordingly
  int getCount(String id) {
    if (cartItems.isEmpty) {
      return 0;
    } else {
      final index = cartItems.indexWhere((item) {
        return item['id'] == id;
      });
      if (index != -1) {
        return cartItems[index]['count'];
      } else {
        return 0;
      }
    }
  }

//This is to get total quantity, so that it can be displayed as a badge in cart icon
  int getTotalCount() {
    int totalCount = 0;
    for (int i = 0; i < cartItems.length; i++) {
      totalCount += cartItems[i]["count"] as int;
    }
    return totalCount;
  }

//This function is to remove any product to cart, decrease its count both locally and in device storage as well
//In case count becomes 0 after decrement, it will be removed from local list.
  void removeFromCart(dynamic product) async {
    final localStorage = await SharedPreferences.getInstance();
    final index = cartItems.indexWhere((item) => item['id'] == product['id']);
    if (index != -1) {
      cartItems[index]['count'] -= 1;
      if (cartItems[index]['count'] == 0) {
        cartItems.removeAt(index);
      }
      localStorage.setString('cartItems', jsonEncode(cartItems));
      notifyListeners();
    }
  }

//To calculate total amount of the order for cart screen.
  double calculateTotal() {
    double totalAmount = 0;
    for (int i = 0; i < cartItems.length; i++) {
      totalAmount += (cartItems[i]["count"] * cartItems[i]["price"]);
    }
    return totalAmount;
  }
}
