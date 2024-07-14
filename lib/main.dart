import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gemini/Models/contentProvider.dart';
import 'package:gemini/Models/dimension.dart';
import 'package:provider/provider.dart';

import 'homepage.dart';


void main() async {
  await dotenv.load(fileName: ".env");
  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) =>Dimension()),
            ChangeNotifierProvider(create: (_) =>ContentProvider()),
       ],
      child: MyApp(),
      ),
  );
}

