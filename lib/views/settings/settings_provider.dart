import 'package:flutter/cupertino.dart';

class ChangeSettingScreenProvider extends ChangeNotifier {

 String screenname = ""; 
 void changeSettingScreenIndex(String  name ){
  screenname = name;
  notifyListeners();
 }
}