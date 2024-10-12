import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../services/api.dart';

class AppBaseController extends GetxController {

  Api api = Api() ;
  bool isBusy = false ;
  double width = 0 ;
  double height = 0 ;

  String imageUrl2 = ' ';
  void setBusy(bool value) {
    isBusy = value;
    update();
  }

  double getWidth(BuildContext context){
    return width = MediaQuery.of(context).size.width;
  }
  double getHeight(BuildContext context){
    return height = MediaQuery.of(context).size.height;
  }
  back(){
    Get.back();
  }

}