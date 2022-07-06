import 'dart:async';

import 'package:app/utils/extensions/datetime.dart';
import 'package:flutter/material.dart';

class MiningPoolResetTimeWidget extends StatefulWidget {
  const MiningPoolResetTimeWidget({Key? key}) : super(key: key);

  @override
  State<MiningPoolResetTimeWidget> createState() => _MiningPoolResetTimeWidgetState();
}

class _MiningPoolResetTimeWidgetState extends State<MiningPoolResetTimeWidget> {
  var time = "00:00:00";
  Timer? timer;

  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      // TODO:: Get date from server
      var now = DateTime.now();
      var dateCycleEnds = now.copyWith(
          day: now.day + 1,
          hour: 0,
          minute: 0,
          second: 0
      );

      setState(() {
        time = sDuration(dateCycleEnds.difference(now));
      });
    });

    super.initState();
  }

  @override
  dispose() {
    timer!.cancel();
    super.dispose();
  }

  String sDuration(Duration duration) {
    return "${duration.inHours.toString().padLeft(2, '0')}:"
        "${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:"
        "${(duration.inSeconds.remainder(60).toString().padLeft(2, '0'))}";
  }

  @override
  Widget build(BuildContext context) {
    return Text(time,
      style: const TextStyle(
        color: Color(0xFFFFFFFF),
        fontWeight: FontWeight.bold
      ),
    );
  }
}
