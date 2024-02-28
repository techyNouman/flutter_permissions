import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../permissions/enum.dart';
import '../../permissions/request_permission_manager.dart';
import '../Components/custom_app_bar.dart';
import '../Components/app_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(appBarTitle: "Flutter Permissions Example"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppButton(
              btnFun: () =>   _requestPermission(PermissionType.whenInUseLocation, context),
              btnText: 'Request location permission',
            ),
            AppButton(
              btnFun: () =>   _requestPermission(PermissionType.notification, context),
              btnText: 'Request notification permission',
            ),
          ],
        ),
      ),
    );
  }
}

_requestPermission(PermissionType permissionType, BuildContext context){
  RequestPermissionManager(permissionType)
      .onPermissionDenied(() {
    // Handle permission denied for location
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Permission denied")));
  }).onPermissionGranted(() {
    // Handle permission granted for location
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Permission granted")));
  }).onPermissionPermanentlyDenied(() {
    // Handle permission permanently denied for location
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Permission permanently denied")));
  }).execute();

}
/// Get from gallery
_getFromGallery(context) async {
  try {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
    }
  } catch (e) {
    var status = await Permission.photos.status;
    if (status.isDenied) {
      print('Access Denied');
      showAlertDialog(context);
    } else {
      print('Exception occured!');
    }
  }
}

showAlertDialog(context) => showCupertinoDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Permission Denied'),
        content: const Text('Allow access to gallery and photos'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => openAppSettings(),
            child: const Text('Settings'),
          ),
        ],
      ),
    );
