import 'dart:math';

import 'package:app/core/app.routes.dart';
import 'package:app/utils/theme/app.palette.dart';
import 'package:app/utils/widgets/loader/loader-wrapper.widget.dart';
import 'package:app/utils/widgets/loader/loader.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  final Widget? floatingActionButton;
  final PreferredSizeWidget? appBar;

  const AppScaffold({
    Key? key,
    required this.body,
    this.floatingActionButton,
    this.appBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      floatingActionButton: floatingActionButton,
      body: LoaderWrapperWidget(
        id: 'scaffold',
        child: body,
        loader: const LoaderWidget(),
      ),
    );
  }
}
