
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

    GetPage(name: Routes.SEARCH, page:()=> SearchView()),
    GetPage(name: Routes.CART, page:()=> CartView()),
    GetPage(name: Routes.CHECKOUT, page:()=> CheckoutView()),
    GetPage(name: Routes.PRIVACYPOLICY, page:()=> PrivacyPolicy()),
    GetPage(name: Routes.REFUNDPOLICY, page:()=> RefundPolicy()),
    GetPage(name: Routes.TERMSOFSERVICE, page:()=> TermsOfService()),
    GetPage(name: Routes.CONTACTUS, page:()=> ContactView(), binding: ContactBinding()),
    GetPage(name: Routes.SINGLECATEGORY, page:()=> SingleCategory(), binding: CategorySearchBinding()),
    GetPage(name: Routes.SINGLEPRODUCT, page:()=> SingleProduct()),
  ];
}

