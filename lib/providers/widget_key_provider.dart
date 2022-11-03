import 'package:flutter/cupertino.dart';

class WidgetKeyProvider with ChangeNotifier {
  late GlobalKey _fabKey;
  late GlobalKey _imageKey;
  late bool _isAnimating = false;
  late String _imageName;

  GlobalKey get fabKey => _fabKey;
  GlobalKey get imageKey => _imageKey;
  bool get isAnimating => _isAnimating;
  String get imageName => _imageName;

  void setFabKey(GlobalKey fabKey) {
    _fabKey = fabKey;
  }

  void startAnimation(
      {required GlobalKey imageKey, required String imageName}) {
    _imageKey = imageKey;
    _imageName = imageName;
    _isAnimating = true;
    notifyListeners();
  }

  void endAnimation() {
    _isAnimating = false;
    notifyListeners();
  }
}
