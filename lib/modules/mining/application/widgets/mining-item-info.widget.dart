import "package:flutter/material.dart";

class MiningItemInfoWidget extends StatelessWidget {
  final String title;
  final String? value;
  final Widget icon;
  final Widget? child;

  const MiningItemInfoWidget({
    Key? key,
    required this.title,
    required this.icon,
    this.value,
    this.child
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Wrap(
        direction: Axis.vertical,
        spacing: 5,
        children: [
          Text(title, style: const TextStyle(
            color: Color(0xFF979797)
          )),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 5,
            children: [
              SizedBox(
                height: 30,
                width: 30,
                child: icon,
              ),
              if (child != null) child!,
              if (value != null)
              Text(value!, style: const TextStyle(
                color: Color(0xFFFFFFFF),
                fontWeight: FontWeight.bold
              )),
            ],
          )
        ],
      ),
    );
  }
}
