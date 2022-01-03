import 'package:aimart/controllers/controllers.dart';
import 'package:aimart/models/models.dart';
import 'package:aimart/services/services.dart';
import 'package:aimart/utilities/utilities.dart';
import 'package:get/get.dart';


class OrderController extends GetxController {

  final Rx<List<Order>> _orderList = Rx<List<Order>>([]);


  List<Order> get orderList => _orderList.value;

  @override
  void onInit() {
    String username = Utils.getUsername(Get.find<FirebaseAuthController>().user!.email!);
    _orderList.bindStream(FirebaseService.getMyOrders(username));
    super.onInit();
  }

  @override
  void dispose() { 
    super.dispose();
  }

  Future<void> submitOrder(Order order) async {
    await FirebaseService.createOrder(order);
  }

}