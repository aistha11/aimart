import 'package:aimart_dash/models/order.dart';
import 'package:aimart_dash/services/services.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {

  final Rx<List<Order>> _orderList = Rx<List<Order>>([]);


  List<Order> get orderList => _orderList.value;

  @override
  void onInit() {
    
    _orderList.bindStream(FirebaseService.getAllOrders());
    super.onInit();
  }


  Future<void> changeOrderStatus(Order order) async {
    await FirebaseService.changeOrderStatus(order);
  }
  Future<void> deleteOrder(Order order) async {
    await FirebaseService.deleteOrder(order);
  }

  
}