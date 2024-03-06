import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:oxyboots/onboardscreen/onboardscreen.dart';
import 'package:oxyboots/provoder/cart_provider.dart';
import 'package:oxyboots/provoder/favourate.dart';
import 'package:oxyboots/ui/home_page.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(

      const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ShoppingCart()),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
      ],
      
      child: const MaterialApp(

        home: Homepage(),
      ),
    );
  }
}

