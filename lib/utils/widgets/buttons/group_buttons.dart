import 'package:app/utils/theme/app.palette.dart';
import 'package:flutter/material.dart';

class GroupButtonsItem {
    final Widget child;
    final dynamic value;

    GroupButtonsItem({
      required this.child,
      required this.value,
    });
}

class GroupButtons<T> extends StatefulWidget {
  final List<GroupButtonsItem> buttons;
  final void Function(T) onChange;
  final T? initialSelected;

  const GroupButtons({
    Key? key,
    required this.buttons,
    required this.onChange,
    this.initialSelected,
  }) : super(key: key);

  @override
  State<GroupButtons<T>> createState() => _GroupButtonsState<T>();
}

class _GroupButtonsState<T> extends State<GroupButtons<T>> {
  dynamic selectedValue;

  @override
  initState() {
    selectedValue = widget.initialSelected;
    super.initState();
  }

  Widget createButton({
    required GroupButtonsItem button,
  }) => ElevatedButton(
    child: button.child,
    style: ElevatedButton.styleFrom(
      primary: button.value == selectedValue
          ? AppPalette.orange400 : AppPalette.primary900,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: AppPalette.gray400),
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    onPressed: () {
      setState(() {
        selectedValue = button.value;
        widget.onChange(button.value as T);
      });
    },
  );

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      alignment: WrapAlignment.center,
      children: widget.buttons
        .map((button) => createButton(button: button))
        .toList(),
    );
  }
}
