import 'package:flutter/material.dart';
import 'package:oxyboots/provoder/cart_provider.dart';
import 'package:oxyboots/provoder/shopping_info.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  final String image;
  final String sellerText;
  final String nikeJordanText;
  final String priceText;

  const DetailPage({
    Key? key,
    required this.image,
    required this.sellerText,
    required this.nikeJordanText,
    required this.priceText,
  }) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  String selectedSize = '';
  bool isItemAdded = false;

  @override
  Widget build(BuildContext context) {
    ShoppingCart shoppingCart = Provider.of<ShoppingCart>(context);
    return Scaffold(
      floatingActionButton: Container(
        height: 50,
        width: 100,
        decoration: BoxDecoration(
          color: const Color(0xff5B9EE1),
          borderRadius: BorderRadius.circular(20),
        ),
        child:  Center(
          child: InkWell(
            child: const Text(
              "Add to cart",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: (){
              int? size = int.tryParse(selectedSize ?? "");
              if ( size != null){
              CartItem items = CartItem(name:  widget.nikeJordanText, price: double.parse(widget.priceText!), imageUrl: widget.image,size: size ) ;
              shoppingCart.addToCard(items);
               isItemAdded = true;

              }
              if(isItemAdded){
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Item added to cart"),
                    duration: Duration(seconds: 2),
                    behavior: SnackBarBehavior.floating,

                  ),
                );
              }

            },
          ),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Men’s Shoes"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const ShoppingInfo()));
            },
            icon:  Stack(
                children:[
                  const Icon(Icons.shopping_bag_outlined),
                  shoppingCart.cartItems.isEmpty?const SizedBox():Container(
                   height: 12,
                   width: 12,
                   decoration:  const BoxDecoration(
                       color:  Colors.red,
                     shape: BoxShape.circle
                   ),
                   child: Center(child: Text(
                     shoppingCart.cartItems.length.toString(),style: const TextStyle(
                     fontSize: 8,
                     color: Colors.white
                   ),)),
                 ),
                ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 200,
              width: 400,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  widget.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              widget.sellerText,
              style: const TextStyle(fontSize: 16, color: Color(0xff5B9EE1)),
            ),
            const SizedBox(height: 10),
            Text(
              widget.nikeJordanText,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              widget.priceText,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
                "Air Jordan is an American brand of basketball shoes athletic, casual, and style clothing produced by Nike...."),
            const SizedBox(height: 10),
            const Text(
              "Size",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Row(

              children: [
                buildSizeOption('38'),
                buildSizeOption('39'),
                buildSizeOption('40'),
                buildSizeOption('41'),
                buildSizeOption('42'),
                buildSizeOption('43'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSizeOption(String size) {
    bool isSelected = selectedSize == size;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedSize = size;
        });
      },
      child: Container(

        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: isSelected ?const Color(0xff5B9EE1) : Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Text(
          size,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xff707B81),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}


