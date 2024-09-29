import '../consts/imports.dart';

class BottomNavController extends GetxController {
  int tappedIndexNew = 0;
  int get tappedIndex => tappedIndexNew;

  void tappedIndexFunc(int index) {
    tappedIndexNew = index;
    update();
  }
}