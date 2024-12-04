import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/assets_manager.dart';
import 'package:movies_app/core/colors_manager.dart';
import 'package:movies_app/core/routes_manager.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, RoutesManager.home);
    });
  }

  Widget build(BuildContext context) {
    return Container(
      color: ColorsManager.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(),
          Image.asset(
            AssetsManager.splashLogo,
            width: 199.w,
            height: 208.h,
          ),
          const Spacer(),
          Image.asset(
            AssetsManager.routeLogo,
            width: 213.w,
            height: 128.h,
          ),
        ],
      ),
    );
  }
}
