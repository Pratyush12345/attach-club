import 'package:flutter/material.dart';

class ChangeScreenProvider extends ChangeNotifier {

 int selectedIndex = 0; 
 void changeScreenIndex(int  i ){
  selectedIndex = i;
  notifyListeners();
 }
}