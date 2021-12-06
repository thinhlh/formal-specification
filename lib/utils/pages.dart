import 'package:formal_specification/presentation/screens/home/home_bindings.dart';
import 'package:formal_specification/presentation/screens/home/home_screen.dart';
import 'package:formal_specification/presentation/screens/splash/splash_bindings.dart';
import 'package:formal_specification/presentation/screens/splash/splash_screen.dart';
import 'package:formal_specification/utils/routes.dart';
import 'package:get/route_manager.dart';

class Pages {
  Pages._();

  static final pages = <GetPage>[
    GetPage(
      name: Routes.home,
      page: () => HomeScreen(),
      binding: HomeBindings(),
    ),
    GetPage(
      name: Routes.splash,
      page: () => SplashScreen(),
      binding: SplashBindings(),
    )
  ];
}
