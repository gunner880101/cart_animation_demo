import 'package:flutter/cupertino.dart';

class WidgetKeyProvider with ChangeNotifier {
  late GlobalKey _fabKey;
  late List<GlobalKey> _itemKeyList;

  GlobalKey get fabKey => _fabKey;
  List<GlobalKey> get itemKeyList => _itemKeyList;

  void setFabKey(GlobalKey fabKey) {
    _fabKey = fabKey;
  }
}
