import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:virtual_store/models/product.dart';
import 'package:virtual_store/models/user.dart';
import 'package:virtual_store/models/user_manager.dart';

import 'cart_product.dart';

class CartManager{

    List<CartProduct> items =[];
    User user;

    void addToCart(Product product){
      items.add(CartProduct.fromProduct(product));
    }

    void updateUser(UserManager userManager){
      user = userManager.user;
      items.clear();

      if(user != null){
        _loadCartItems();
      }
    }

   Future<void> _loadCartItems()async{
     final QuerySnapshot cartSnap = await user.cartRef.getDocuments();

     items = cartSnap.documents.map((d) => CartProduct.fromDocument(d)).toList();
    }
}