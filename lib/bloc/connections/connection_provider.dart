import 'package:flutter/material.dart';

class ChangeConnectionScreenProvider extends ChangeNotifier {

 String screenname = ""; 
 void changeScreenIndex(String  name ){
  screenname = name;
  notifyListeners();
 }
}