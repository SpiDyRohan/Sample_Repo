import 'package:flutter_test_sample/RouteDetail/screens/list_data_model.dart';
import 'package:get/get.dart';

class SecondScreenController extends GetxController{
  RxList<ListDataModel> list=<ListDataModel>[].obs;
  var currentIndex=0.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    list.value.add(ListDataModel("assets/images/download1.jpeg", "name"));
    list.value.add(ListDataModel("assets/images/download2.jpeg", "name"));
    list.value.add(ListDataModel("assets/images/download3.jpeg", "name"));
  }
}