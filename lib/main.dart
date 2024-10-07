import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tasawak/tasawak.dart';
import 'package:tasawak/view_model/data/local/hive.dart';
import 'firebase_options.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  // await EasyLocalization.ensureInitialized();
  myBox = await openHiveBox('box1'); // it belongs to Hive
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.android,
  );


  runApp(
    const Tasawak(),
  );
}


/// to generate the locale keys
/// flutter pub run easy_localization:generate -S assets/translation -O assets/translation -o local_keys.g.dart -f keys

/// to get the latest version of packages
/// flutter pub upgrade --major-versions
