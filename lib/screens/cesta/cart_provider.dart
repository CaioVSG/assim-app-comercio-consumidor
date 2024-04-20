import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../shared/core/models/cart_model.dart';

class CartProvider extends ChangeNotifier{

  List<CartModel> _listCart = [];

  List<CartModel> get listCart => _listCart;

  CartModel retriveCardItem(int index){
    return listCart[index];
  }

  void addCart(CartModel cartModel){
    bool isDuplicated = false;
    if(listCart.isNotEmpty){
      if(cartModel.storeId != listCart[0].storeId){
        listCart.clear();
      }
    }
    for(int i = 0; i < listCart.length; i++){
      if(cartModel.productId == listCart[i].productId){
        listCart[i].amount += 1;
        isDuplicated = true;
      }
    }
    if(isDuplicated == false){
      listCart.add(cartModel);
    }
    notifyListeners();
  }



  void removeCart(CartModel cartModel){
    listCart.remove(cartModel);
    notifyListeners();
  }

}