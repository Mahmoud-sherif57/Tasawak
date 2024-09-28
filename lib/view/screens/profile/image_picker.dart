// import 'package:image_picker/image_picker.dart';
//
// class ImageHelper {
//   ImageHelper({
//     ImagePicker? imagePicker,
//   }) : imagePicker = imagePicker ?? ImagePicker();
//
//   final ImagePicker imagePicker;
//
//   Future<List<XFile>> pickImage({
//     ImageSource source = ImageSource.gallery,
//     int imageQuality = 100,
//     bool multiple = false,
//   }) async {
//     if (multiple) {
//       return await imagePicker.pickMultiImage(imageQuality: imageQuality);
//     }
//     final file = await imagePicker.pickImage(source: source, imageQuality: imageQuality);
//     if (file != null) return [file];
//     return [];
//   }
// }
