import 'dart:html';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:prawitama_care_admin/common/utils.dart';

class StorageServices {
  static void uploadImage({@required Function(File file) onSelected}) {
    InputElement uploadInput = FileUploadInputElement()..accept = 'image/*';
    uploadInput.click();

    uploadInput.onChange.listen((event) {
      final file = uploadInput.files.first;
      final reader = FileReader();

      reader.readAsDataUrl(file);
      reader.onLoadEnd.listen((event) {
        onSelected(file);
      });
    });
  }

  static void uploadToStorage(String programName) async {
    uploadImage(onSelected: (file) async {
      Reference ref = FirebaseStorage.instance
          .refFromURL('gs://prawitama-care.appspot.com/')
          .child(programName);

      UploadTask uploadTask = ref.putBlob(file);
      var dowurl = await (await uploadTask).ref.getDownloadURL();
      imageUrl = dowurl.toString();
    });
  }
}
