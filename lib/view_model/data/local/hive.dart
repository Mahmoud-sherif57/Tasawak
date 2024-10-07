import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

Box? myBox;
Future<Box> openHiveBox(String boxName) async {
  if (!Hive.isBoxOpen(boxName)) {
    final directory = await getApplicationDocumentsDirectory();
    Hive.init(( directory).path);
  }
  return Hive.openBox(boxName);
}



