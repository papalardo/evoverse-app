import "package:app/utils/theme/app.palette.dart";
import "package:app/utils/widgets/loader/loader.controller.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";


class LoaderWrapperWidget extends StatelessWidget {
  final Widget child;
  final Widget loader;
  final String id;

  const LoaderWrapperWidget({
    Key? key,
    required this.child,
    required this.loader,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        GetBuilder<LoaderController>(
          builder: (controller) {
            return IgnorePointer(
              ignoring: ! controller.isLoading(id),
              child: AnimatedOpacity(
                opacity: controller.isLoading(id) ? 1 : 0,
                duration: const Duration(milliseconds: 300),
                child: Container(
                  color: AppPalette.BACKGROUND.withOpacity(0.6),
                  child: Center(child: loader),
                ),
              ),
            );
          }
        ),
        // Obx(() => IgnorePointer(
        //   ignoring: ! controller.loading(),
        //   child: AnimatedOpacity(
        //     opacity: controller.loading() ? 1 : 0,
        //     duration: const Duration(milliseconds: 300),
        //     child: Container(
        //       color: AppPalette.BACKGROUND.withOpacity(0.6),
        //       child: Center(child: loader),
        //     ),
        //   ),
        // )),
      ],
    );
  }
}
