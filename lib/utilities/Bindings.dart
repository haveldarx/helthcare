import 'package:get/instance_manager.dart';
import 'package:medicalimagingapp/controller/authentication_controller.dart';
import 'package:medicalimagingapp/controller/userdataController.dart';
///Getx will create an instance of data and auth controllers,
///
/// as soon as the page will be removed from stack,
///Getx automatically removes the instance of both controller.

class GetXBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => DataController());
    Get.lazyPut(() => AuthenticationController());
  }
}