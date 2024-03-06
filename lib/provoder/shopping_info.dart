import 'package:flutter/material.dart';
import 'package:oxyboots/checkout/checkout_page.dart';
import 'package:provider/provider.dart';

import 'cart_provider.dart';

class ShoppingInfo extends StatefulWidget {
  const ShoppingInfo({super.key});

  @override
  State<ShoppingInfo> createState() => _ShoppingInfoState();
}

class _ShoppingInfoState extends State<ShoppingInfo> {
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
              "Checkout",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const CheckOutPage()));
            },
          ),
        ),

      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("My Cart"),
      ),
      body: shoppingCart.cartItems.isEmpty? const Center(child: Text("No item select")):
           Padding(
             padding: const EdgeInsets.all(20.0),
             child: SingleChildScrollView(
               child: Column(
                 children: [
                   Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: shoppingCart.cartItems.map(  ( item){
                       return Card(
                         child: ListTile(
                           leading: Image.network(item.imageUrl),

                           title: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text(item.name,style: const TextStyle(
                                 fontSize: 16,
                                 fontWeight: FontWeight.w600
                               ),),
                               Text(item.price.toString(),style: const TextStyle(
                                   fontSize: 16,
                                   fontWeight: FontWeight.w600
                               ),)
                             ],
                           ),
                           subtitle: Row(
                             children: [
                               IconButton(onPressed: (){
                                 setState(() {
                                   if(item.quantity>1){
                                     item.quantity--;
                                   }

                                 });
                               },

                                   icon: const CircleAvatar(
                                     radius: 15,
                                     backgroundColor: Color(0xff5B9EE1),
                                       child: Icon(Icons.remove,color: Colors.white,))),
                               Text(item.quantity.toString()),
                               IconButton(onPressed: (){
                                 setState(() {
                                   item.quantity++;
                                 });
                               },
                                   icon: const CircleAvatar(
                                     radius: 15,
                                     backgroundColor: Color(0xff5B9EE1),
                                       child: Icon(Icons.add,color: Colors.white,)))
                             ],
                           ),
                           trailing: Column(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Text(item.size.toString()),
                               InkWell(
                                 child: const Icon(Icons.delete),
                                 onTap: () {
                                   showDialog(
                                     context: context,
                                     builder: (BuildContext context) {
                                       return AlertDialog(
                                         title: const Text("Confirm Delete"),
                                         content: const Text("Are you sure you want to delete this item?"),
                                         actions: [
                                           TextButton(
                                             onPressed: () {
                                               Navigator.of(context).pop(); // Close the dialog
                                             },
                                             child: const Text("No"),
                                           ),
                                           TextButton(
                                             onPressed: () {
                                               shoppingCart.removeFromCard(item);
                                               Navigator.of(context).pop(); // Close the dialog
                                             },
                                             child: const Text("Yes"),
                                           ),
                                         ],
                                       );
                                     },
                                   );
                                 },
                               ),

                             ],
                           ),

                         ),
                       );
                    }).toList()
                             ),

                   const SizedBox(height: 10),
                   Column(
                     children: [
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           const Text("Subtotal:",style: TextStyle(
                             fontSize: 18,
                             fontWeight: FontWeight.bold,
                           )),
                           Text(shoppingCart.calculateSubtotal().toString(),style: const TextStyle(
                             fontSize: 18,
                             fontWeight: FontWeight.bold,
                           )),
                         ],
                       ),
                       const SizedBox(height: 10),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           const Text("Shipping:",style: TextStyle(
                             fontSize: 18,
                             fontWeight: FontWeight.bold,
                           )),
                           Text(shoppingCart.calculateShipping().toString(),style: const TextStyle(
                             fontSize: 18,
                             fontWeight: FontWeight.bold,
                           )),
                         ],
                       ),
                       const SizedBox(height: 10),
                       const Divider(),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           const Text("Total:",style: TextStyle(
                             fontSize: 20,
                             fontWeight: FontWeight.bold,
                             color: Color(0xff5B9EE1),
                           )),
                           Text(shoppingCart.calculateTotal().toString(),style: const TextStyle(
                             fontSize: 20,
                             fontWeight: FontWeight.bold,
                             color: Color(0xff5B9EE1),
                           )),
                         ],
                       ),

                     ],
                   ),

                 ],

               ),
             ),
           ),
    );
  }
}
