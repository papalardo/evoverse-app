import "package:app/utils/theme/app.palette.dart";
import "package:flutter/material.dart";

class MainCardWidget extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? leftTitle;
  final Widget? rightTitle;

  const MainCardWidget({
    Key? key,
    required this.title,
    required this.child,
    this.leftTitle,
    this.rightTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppPalette.primary600,
        borderRadius: BorderRadius.circular(10)
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: rightTitle ?? const SizedBox(),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: const Color(0xFF1f2329),
              borderRadius: BorderRadius.circular(10)
            ),
            padding: const EdgeInsets.all(10),
            child: child,
          )
        ],
      ),
    );
  }

}
