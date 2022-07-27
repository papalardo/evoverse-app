import "package:flutter/material.dart";

class AppFutureBuilder<T> extends StatelessWidget {
  final Future<T> future;
  final Function(T) done;
  final Widget? busy;
  final Widget? empty;
  final Function(dynamic)? error;

  const AppFutureBuilder({
    Key? key,
    required this.future,
    required this.done,
    this.error,
    this.busy,
    this.empty,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return busy ?? const SizedBox();
        }

        if (snapshot.hasData) {
          return done(snapshot.data);
        }

        // logger.i("snapshot ==> ${snapshot} ${snapshot.}")
        if (snapshot.hasError) {
          if (error == null) return const Text("Error");
          return error!(snapshot.error);
        }

        return empty ?? const SizedBox();
      }
    );
  }

}
