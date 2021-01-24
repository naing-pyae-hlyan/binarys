import 'package:flutter/foundation.dart';

class ConvertController extends ChangeNotifier {
  List<String> _binary = [];

  void setBinary(List<String> b) {
    this._binary = b;
    notifyListeners();
  }

  List<String> get binary => this._binary;

  void clear() {
    this.binary.clear();
    notifyListeners();
  }
}
