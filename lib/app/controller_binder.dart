import 'package:ecommerce/features/common/ui/controllers/main_bottom_nav_controller.dart';
import 'package:ecommerce/features/admin/presentation/controllers/admin_auth_controller.dart';
import 'package:ecommerce/features/admin/presentation/controllers/admin_medicine_controller.dart';
import 'package:get/get.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(
      MainButtomNavController(),
    );
    Get.put(
      AdminAuthController(),
    );
    Get.put(
      AdminMedicineController(),
    );
  }
}
