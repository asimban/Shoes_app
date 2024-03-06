
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:oxyboots/appfunctions/custom_button.dart';
import 'package:oxyboots/appfunctions/customtextformfield.dart';
import 'package:oxyboots/model_class/user_entity.dart';
import 'package:provider/provider.dart';

import '../provoder/cart_provider.dart';


class CheckOutPage extends StatefulWidget {
  const CheckOutPage({super.key});


  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final contactController = TextEditingController();
  final provinceController = TextEditingController();
  final cityController = TextEditingController();
  final addressController = TextEditingController();
  final districtController = TextEditingController();
  bool isLoading = false;


  @override
  Widget build(BuildContext context) {
    ShoppingCart shoppingCart = Provider.of<ShoppingCart>(context);
    return   Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Enter Your Information!!",style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),),
                  const SizedBox(height: 50,),
                  CustomTextFormField(
                    validator: MinLengthValidator(4,
                        errorText: 'Please Enter Name'),
                    controller: nameController,
                    hintText: "Enter Your Name",
                  ),
                  const SizedBox(height: 10,),
                  CustomTextFormField(
                    validator: MinLengthValidator(
                      11,
                      errorText: "Please Enter Phone No",
                    ),
                    controller: contactController,
                    hintText: "Enter your Contact",
                  ),
                  const SizedBox(height: 10,),
                  CustomTextFormField(
                    validator: MinLengthValidator(4,
                      errorText: 'Enter Your Address',),
                    controller: addressController,
                    hintText: "Enter Your Address",
                  ),
                  const SizedBox(height: 10,),
                  CustomTextFormField(
                    validator: MinLengthValidator(
                      2,errorText: 'Enter your District',
                    ),
                    controller: districtController,
                    hintText: "Enter your District",
                  ),
                  const SizedBox(height: 10,),
                  CustomTextFormField(
                    validator: MinLengthValidator(
                      2,errorText: 'Enter your Province'
                    ),
                    controller: provinceController,
                    hintText: "Enter Your Province",
                  ),
                  const SizedBox(height: 10,),
                  CustomTextFormField(
                    validator: MinLengthValidator(
                      2,errorText: "Enter Your City",
                    ),
                    controller: cityController,
                    hintText: "Enter Your City",
                  ),

                  const SizedBox(height: 50,),

                  CustomButton(buttonText: "Submit", onPressed: () async {
                    setState(() {

                    });
                    if(!formKey.currentState!.validate()){
                      return;
                    }
                    UserEntity userEntity = UserEntity(
                      fullName: nameController.text.trim(),
                      address: addressController.text.trim(),
                      district: districtController.text.trim(),
                      province: provinceController.text.trim(),
                      phoneNo: int.parse(contactController.text.trim()),
                      city: cityController.text.trim(),
                      items: shoppingCart.cartItems.map((items)  {
                        return {
                          'Name':items.name,
                          'Price':items.price,
                          'Image':items.imageUrl,
                          'Quantity':items.quantity,
                          'Size':items.size,
                        };
                      }).toList(),
                      totalAmount: shoppingCart.calculateTotal(),

                    );
                     UserEntity.collection().add(userEntity);
                     shoppingCart.clearCart();
                     ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Your data sent successfully!"),
                        duration: Duration(seconds: 2),),
                    );

                  }),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
