import 'package:get/get.dart';
import 'package:hotel_app/provider/base_provider.dart';


class AppBinding implements Bindings {

  @override
  void dependencies() async {
    Get.put<BaseProvider>(BaseProvider());

  }
}
