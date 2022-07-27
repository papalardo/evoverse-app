import "package:app/core/app.routes.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class MaintenancePage extends StatelessWidget {
  const MaintenancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset("lib/assets/images/off.png",
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 3, color: const Color(0xFFd9d9d9)),
                  gradient: const LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color(0xFF202d73),
                      Color(0xFF632482)
                    ]
                  ),
                ),
                child: const Text("Server is under maintenance.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            )
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.offAllNamed(AppRoutes.SPLASH),
        label: const Text("Try again"),
        icon: const Icon(Icons.refresh),
      ),
    );
  }

}
