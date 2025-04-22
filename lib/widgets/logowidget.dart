// Created By Amit Jangid 24/08/21

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gail_pipeline/constants/app_constants.dart'; 

class LogoWidget extends StatelessWidget {
  final double? width, height;

  const LogoWidget({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Image(
        width: width,
        height: height,
        image: AssetImage(kIconLogo),
      );
}
