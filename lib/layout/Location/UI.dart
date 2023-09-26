import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sellbuy/shared/Constants/Consts.dart';
import 'GetControl.dart';
class CurrentLocation extends StatelessWidget {
  const CurrentLocation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(
        init: LocationController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: primColors,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const Text(' Find Your Location',style: TextStyle(color: Colors.black54),),
            ),
            body: Center(
              child: controller.isLoading.value
                  ? const CircularProgressIndicator()
                  : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      controller.currentLocation == null
                          ? 'try again , not Location yet'
                          : controller.currentLocation!,
                      style: const TextStyle(fontSize: 20,color: Colors.indigo),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () async {
                      await controller.getCurrentLocation();
                    },
                    child: const Text('Tab To Find Your Location'),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
