// import 'dart:ffi';
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagepickController extends GetxController {
  late Rx<File?> _imagefile;
  File? get profileimage => _imagefile.value;
  void galleryImage() async {
    final pickedimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedimage != null) {
      Get.snackbar("Profile Image", "Successfully updated");
    }
    _imagefile = Rx<File?>(File(pickedimage!.path));
  }
}
