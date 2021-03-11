import 'package:flutter/cupertino.dart';

class ImagePathUrl with ChangeNotifier {
  String _imagePath =
      'https://firebasestorage.googleapis.com/v0/b/prawitama-care.appspot.com/o/Motivational-Quotes-ID-17.32817bcc.png?alt=media&token=1f77e79c-2905-44dc-aeb4-62e7bea76fab';

  String get imagePath => _imagePath;

  set imagePath(String url) {
    _imagePath = url;
    notifyListeners();
  }
}
