
import 'package:aimart/bindings/bindings.dart';
import 'package:aimart/views/viewMore/allFeaturedProduct.dart';
import 'package:aimart/views/viewMore/allLatestProduct.dart';
import 'package:aimart/views/viewMore/allProducts.dart';
import 'package:aimart/views/views.dart';
import 'package:aimart/widgets/slideSingleProduct.dart';
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
    GetPage(name: Routes.CATEGORIES, page:()=> AllCategories()),
    GetPage(name: Routes.PRODUCTS, page:()=> AllProducts()),
    GetPage(name: Routes.FEATUREDPRODUCTS, page:()=> AllFeatured()),
    GetPage(name: Routes.LATESTPRODUCTS, page:()=> AllLatestProduct()),
    GetPage(name: Routes.SINGLECATEGORY, page:()=> SingleCategory(), binding: CategorySearchBinding()),
    GetPage(name: Routes.SINGLEPRODUCT, page:()=> SlideSingleProduct(), binding: SingleProductBinding()),
    // GetPage(name: Routes.SINGLEPRODUCT, page:()=> SingleProduct(), binding: SingleProductBinding()),
  ];
}

