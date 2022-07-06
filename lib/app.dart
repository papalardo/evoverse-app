import 'package:app/core/app.bindings.dart';
import 'package:app/core/app.module.dart';
import 'package:app/core/app.routes.dart';
import 'package:app/utils/theme/app.theme-data.dart';
import 'package:app/utils/widgets/loader/loader-wrapper.widget.dart';
import 'package:app/utils/widgets/loader/loader.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: AppModule().routes(),
      initialRoute: AppRoutes.INITIAL,
      initialBinding: AppBindings(),
      debugShowCheckedModeBanner: false,
      builder: (context, widget) => _addRouterWrappers(context, widget),
      theme: AppThemeData.themeData(),
    );
  }

  Widget _addRouterWrappers(BuildContext context, Widget? widget) {
    return Navigator(
      onGenerateRoute: (settings) => MaterialPageRoute(
        builder: (_) => LoaderWrapperWidget(
          child: widget!,
          loader: const LoaderWidget(),
        ),
      ),
    );
  }

}
