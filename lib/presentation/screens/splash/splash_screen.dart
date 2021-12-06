import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:formal_specification/base/base_screen.dart';
import 'package:formal_specification/presentation/screens/splash/splash_controller.dart';
import 'package:formal_specification/utils/colors.dart';
import 'package:formal_specification/utils/style.dart';

class SplashScreen extends BaseScreen<SplashController> {
  @override
  Widget buildBody(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Opacity(
            opacity: 0.5,
            child: Container(
              child: SvgPicture.asset('assets/images/notebook.svg'),
            ),
          ),
        ),
        Center(
          child: Text(
            'Formal Specification Coding Project',
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: AppStyle.BOLD,
              fontSize: 50,
            ),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
