import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formal_specification/utils/pages.dart';
import 'package:formal_specification/utils/routes.dart';
import 'package:formal_specification/utils/themes.dart';
import 'package:formal_specification/utils/values.dart';
import 'package:get/route_manager.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(1080, 720),
      builder: () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: Values.appName,
        theme: AppTheme.themeData,
        defaultTransition: Transition.fadeIn,
        getPages: Pages.pages,
        initialRoute: Routes.initial,
      ),
    );
  }
}
