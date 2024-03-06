import 'package:flutter/material.dart';

class ShoppingCart extends ChangeNotifier {
  final List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  void addToCard (CartItem item){
    _cartItems.add(item);
    notifyListeners();
  }
  void removeFromCard (CartItem item){
    _cartItems.remove(item);
    notifyListeners();
  }
  double calculateSubtotal() {
    return _cartItems.fold(0.0, (total, item) => total + item.price * item.quantity);
  }

  double calculateShipping() {

    return 110.0;
  }

  double calculateTotal() {
    return calculateSubtotal() + calculateShipping();
  }
  bool isItemInCart(String image){
    return _cartItems.any((item)=>item.imageUrl==image);
  }
  void clearCart(){
    _cartItems.clear();
    notifyListeners();
  }
}
class CartItem{
  final String name;
  final double price;

  int quantity;
  late String imageUrl;
  int size;

  CartItem(  {
    required this.name, required this.price,this.quantity=1,required this.imageUrl ,this.size=38

});

}
