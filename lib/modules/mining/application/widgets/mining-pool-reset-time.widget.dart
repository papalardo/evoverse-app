import "dart:async";

import "package:app/services/http/http.service.dart";
import "package:app/stores/mining.store.dart";
import "package:app/utils/extensions/datetime.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class MiningPoolResetTimeWidget extends StatefulWidget {
  final MiningStore miningStore;

  const MiningPoolResetTimeWidget({
    Key? key,
    required this.miningStore,
  }) : super(key: key);

  @override
  State<MiningPoolResetTimeWidget> createState() => _MiningPoolResetTimeWidgetState();
}

class _MiningPoolResetTimeWidgetState extends State<MiningPoolResetTimeWidget> {
  var time = "00:00:00";
  DateTime now = DateTime.now();

  Timer? timer;

  @override
  void initState() {
    fetchTimeFromServer().whenComplete(() => initTime());

    super.initState();
  }

  Future<void> fetchTimeFromServer() async {
    var httpClient = Get.find<HttpService>();
    var response = await httpClient.get("https://worldtimeapi.org/api/timezone/Etc/GMT");

    now = DateTime.parse(response.json!["datetime"].substring(0, 19));
  }

  initTime() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      now = now.add(const Duration(seconds: 1));

      var dateCycleEnds = now.copyWith(
          day: now.day + 1,
          hour: 0,
          minute: 0,
          second: 0
      );

      var diff = dateCycleEnds.difference(now);

      if (diff.inSeconds < 1) {
        widget.miningStore.reload();
      }

      setState(() => time = diff.toString().split(".").first.padLeft(8, "0"));
    });
  }

  @override
  dispose() {
    timer!.cancel();
    super.dispose();
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
