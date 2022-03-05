
import 'package:aimart/bindings/bindings.dart';
import 'package:aimart/views/views.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.WRAPPER;

  static final routes = [
    GetPage(
      name: Routes.WRAPPER,
      page: () => Wrapper(),
      binding: WrapperBinding(),
    ),
    GetPage(name: Routes.CHECKOUT, page:()=> CheckoutView(),binding: CheckoutBinding()),
    GetPage(name: Routes.CONTACTUS, page:()=> ContactView(), binding: ContactBinding()),
    GetPage(name: Routes.SINGLECATEGORY, page:()=> SingleCategory(), binding: CategorySearchBinding()),
    GetPage(name: Routes.SINGLEPRODUCT, page:()=> SingleProduct()),
  ];
}

