import 'dart:async';

import 'package:app/services/http/http.service.dart';
import 'package:app/utils/widgets/loader/shimmer-wrapper.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class DateCountdownWidget extends StatefulWidget {
  final DateTime endsAt;
  final Function()? onOver;
  final String timezone;
  final TextStyle? style;

  const DateCountdownWidget({
    Key? key,
    required this.endsAt,
    this.onOver,
    this.style,
    this.timezone = 'Etc/GMT',
  }) : super(key: key);

  @override
  State<DateCountdownWidget> createState() => _DateCountdownWidgetState();
}

class _DateCountdownWidgetState extends State<DateCountdownWidget> {
  String? time;
  DateTime now = DateTime.now();

  Timer? timer;

  @override
  void initState() {
    fetchTimeFromServer().whenComplete(() => initTime());

    super.initState();
  }

  Future<void> fetchTimeFromServer() async {
    var httpClient = Get.find<HttpService>();
    var response = await httpClient
        .get('https://worldtimeapi.org/api/timezone/${widget.timezone}');

    now = DateTime.parse(response.json!['datetime'].substring(0, 19));
  }

  initTime() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (! mounted) {
        return;
      }

      now = now.add(const Duration(seconds: 1));

      var diff = widget.endsAt.difference(now);

      if (diff.inSeconds == 0 && widget.onOver != null) {
        _onOver();
        return;
      }

      setState(() => time = diff.toString().split('.').first.padLeft(8, '0'));
    });
  }

  _onOver() {
    widget.onOver!();
    cancelTimer();
    setState(() => time = "00:00:00");
  }

  cancelTimer() {
    timer?.cancel();
  }

  @override
  void dispose() {
    cancelTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (time != null) {
      return Text(time!, style: widget.style);
    }
    return ShimmerWrapper(
        child: Container(color: Colors.white,
          child: Text("00:00:00", style: widget.style),
        )
    );
  }

}
