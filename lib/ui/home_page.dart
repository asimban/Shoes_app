import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:oxyboots/appfunctions/customtextformfield.dart';
import 'package:oxyboots/auth/signup_page.dart';
import 'package:oxyboots/provoder/favoriteItem.dart';
import 'package:oxyboots/ui/details_page.dart';
import 'package:provider/provider.dart';

import '../model_class/user_entity.dart';
import '../provoder/favourate.dart';


class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
final CarouselController foundationImage = CarouselController();

List imagePath = [
  {"image_path": "assets/shoescarosel.jpg"},
  {"image_path": "assets/shoescarosel.jpg"},
  {"image_path": "assets/shoescarosel.jpg"},
];
int _selectedIndex = 0;
late Future<QuerySnapshot<UserEntity>> userEntity =
UserEntity.collection().get();
  @override
  Widget build(BuildContext context) {
    FavoritesProvider favoritesProvider = Provider.of<FavoritesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("OXY BOOTS"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const FavoriteScreen()));
            },
            icon: const Icon(Icons.favorite_border,
            ),
          ),
        ],


      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        iconSize: 30.0,
        showUnselectedLabels: true,
        selectedItemColor: const Color(0xff007BFF),
        unselectedItemColor: const Color(0xff484C52),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite_border,
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.add_alert_outlined,
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_rounded),
              label: ""),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            CustomTextFormField(
                prefixIcon: Icons.search, hintText: "Looking for Shoes"),
            const SizedBox(
              height: 40,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Popular Shoes",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "See all",
                  style: TextStyle(
                    color: Color(0xff5B9EE1),
                  ),
                )
              ],
            ),
           StreamBuilder(stream: FirebaseFirestore.instance.collection('Admin Panel').snapshots(),
               builder:(context,AsyncSnapshot<QuerySnapshot> snapshot) {
                 if (snapshot.connectionState == ConnectionState.waiting) {
                   return const Center(child: CircularProgressIndicator());
                 }

                 if (snapshot.hasError) {
                   return Text('Error: ${snapshot.error}');
                 }
                List<DocumentSnapshot> document = snapshot.data!.docs;
                 return Expanded(
                   child: GridView.builder(
                     itemCount: document.length,
                     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                       crossAxisCount: 2,
                       crossAxisSpacing: 10.0,
                       mainAxisSpacing: 10.0,), itemBuilder:(context, index) {
                    Map<String,dynamic> data = document[index].data() as Map<String,dynamic>;
                    String title = data['title'];
                    String name = data['name'];
                    double price = data['price'];
                    String imageUrl = data['profileImageUrl'];
                    return  Column(
                      children: [
                        SizedBox(
                          height: 80,
                          width: 200,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              imageUrl,fit: BoxFit.cover,
                            ),
                          )
                        ),
                        Column(
                          crossAxisAlignment : CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment : MainAxisAlignment.spaceBetween,
                              children: [
                                Text(title.toString(),style: const TextStyle(
                                 color: Color(0xff5B9EE1),),),
                                const Icon(Icons.favorite_border),
                              ],
                            ),
                            Text(price.toString(),style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),),
                            Row(
                             mainAxisAlignment : MainAxisAlignment.spaceBetween,
                              children: [
                                Text(name.toString(),style: const TextStyle(
                                  fontWeight: FontWeight.w600,

                                ),),
                                Container(
                                    decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
                                    color: Color(0xff5B9EE1),
                                    ),
                                  height: 25,
                                  width: 30,
                                    child: InkWell(
                                        child: const Icon(Icons.add,color: Colors.white,),
                                    onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(image: imageUrl, sellerText: title, nikeJordanText: name, priceText: price.toString()),));
                                    },),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    );
                    },
                   ),
                 );

               },),
            const SizedBox(
              height: 40,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "New Arrivals",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "See all",
                  style: TextStyle(
                    color: Color(0xff5B9EE1),
                  ),
                )
              ],
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CarouselSlider(
                items: imagePath
                    .map(
                      (e) => Image.asset(
                    e['image_path'],

                  ),
                )
                    .toList(),
                carouselController: foundationImage,
                options: CarouselOptions(
                  scrollPhysics: const BouncingScrollPhysics(),
                  autoPlay: true,
                  aspectRatio: 2,
                  viewportFraction: 1,
                ),
              ),
            ),
          ],
        ),
      ),
      drawer:  Drawer(
        backgroundColor: Color(0xff1E1E1E),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 40,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text("Hey, 👋",style: TextStyle(
                color: Color(0xff707B81)
              ),),
              const SizedBox(
                height: 10,
              ),
               FirebaseAuth.instance.currentUser!.email==null? const Text("Login Here",style: TextStyle(
                   color: Colors.white
               ),):
               Text(FirebaseAuth.instance.currentUser!.email.toString(),style: const TextStyle(
                  color: Colors.white,
              ),),
              const SizedBox(
                height: 50,
              ),
               Row(
                children: [
                  const Icon(Icons.person_outline_rounded,color: Color(0xff707B81),),
                  const SizedBox(width: 20,),
                  InkWell(
                    child: const Text("Profile",style: TextStyle(
                      color: Colors.white
                    ),),
                    onTap: (){
                    },
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                children: [
                  Icon(Icons.home_outlined,color: Color(0xff707B81),),
                  SizedBox(width: 20,),
                  Text("Home",style: TextStyle(
                      color: Colors.white
                  ),)
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                children: [
                  Icon(Icons.shopping_bag_outlined,color: Color(0xff707B81),),
                  SizedBox(width: 20,),
                  Text("My Cart",style: TextStyle(
                      color: Colors.white
                  ),)
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                children: [
                  Icon(Icons.favorite_border,color: Color(0xff707B81),),
                  SizedBox(width: 20,),
                  Text("Favorite",style: TextStyle(
                      color: Colors.white
                  ),)
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                children: [
                  Icon(Icons.shop_rounded,color: Color(0xff707B81),),
                  SizedBox(width: 20,),
                  Text("Order",style: TextStyle(
                      color: Colors.white
                  ),)
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                children: [
                  Icon(Icons.notification_important_outlined,color: Color(0xff707B81),),
                  SizedBox(width: 20,),
                  Text("Notifications",style: TextStyle(
                      color: Colors.white
                  ),)
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Icon(Icons.login,color: Color(0xff707B81),),
                  const SizedBox(width: 20,),
                  InkWell(
                    child: const Text("Sign Out",style: TextStyle(
                        color: Colors.white
                    ),),
                    onTap: () async {
                      {
                        await FirebaseAuth.instance.signOut();
                        Navigator.pushReplacement(
                            context, MaterialPageRoute(builder: (context) => const SignupPage()));
                      }
                    },
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
