import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

class AppProvider extends ChangeNotifier {
  bool boolval = false;
  bool isObscure = true;
  var countryCode = '+91';
  String email = "";
  String password = "";
  String phoneNumber = "";
  bool otpCodeVisible = false;
  String verificationId = "";
  XFile? images;
  File? photo;
  bool checkfimage = false;

  // ignore: prefer_typing_uninitialized_variables
  var urls = null;

  // ignore: non_constant_identifier_names
  GetBoolVal() async {
    if (boolval == false) {
      boolval = true;
      notifyListeners();
    } else {
      boolval = false;
      notifyListeners();
    }
  }

  setPhoneNumber(userphoneNumber) {
    phoneNumber = countryCode + userphoneNumber.toString();
    notifyListeners();
  }

  setEmail(useremail) {
    email = useremail.toString().trim();
    notifyListeners();
  }

  setEmailPassword(emailpass) {
    password = emailpass.toString();
    notifyListeners();
  }

  setCountryCode(getcountrycode) {
    countryCode = getcountrycode.toString();
    notifyListeners();
  }

  setverificationId(verificationID) {
    if (kDebugMode) {
      print(verificationID);
    }
    verificationId = verificationID;
    notifyListeners();
  }

  setVisibility() => otpCodeVisible = true;

  setotpvisibility() => otpCodeVisible = false;

  checkimage() async {
    if (FirebaseAuth.instance.currentUser!.photoURL != null) {
      checkfimage = true;
      notifyListeners();
    } else {
      checkfimage = false;
      notifyListeners();
    }
  }

  Future<void> imgFromCamera() async {
    final ImagePicker _picker = ImagePicker();
    var permissionStatus = await Permission.camera.status;
    if (permissionStatus.isGranted) {
      XFile? image = await _picker.pickImage(source: ImageSource.camera);
      images = image;
      notifyListeners();
      photo = File(images!.path);
      uploadFile();
    } else {
      if (kDebugMode) {
        print('Permission not granted. Try Again with permission access');
      }
    }
  }

  Future<void> imgFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    var permissionStatus = await Permission.storage.status;
    if (permissionStatus.isGranted) {
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      images = image;
      notifyListeners();
      photo = File(images!.path);
      uploadFile();
    } else {
      if (kDebugMode) {
        print('Permission not granted. Try Again with permission access');
      }
    }
  }

  urlnull() {
    urls = null;
    notifyListeners();
    print("nulll$urls");
  }

  setImage(image) async {
    urls = await image.getDownloadURL();
    notifyListeners();
  }

  void uploadFile() async {
    if (photo == null) return;
    final fireauth = FirebaseAuth.instance.currentUser!.uid;
    // final fileName = basename(photo!.path);
    final destination = 'files/$fireauth';
    try {
      // FirebaseAuth.instance.currentUser!
      //     .updatePhotoURL(destination)
      //     .then((value) => print("success"));
      final ref =
          firebase_storage.FirebaseStorage.instance.ref().child(destination);
      await ref.putFile(photo!);
      notifyListeners();
      if (kDebugMode) {
        print("Image Upload");
      }
    } catch (e) {
      if (kDebugMode) {
        print('error occurred');
      }
    }
  }
  bool isConnected = false;
  CheckInternet() async{
    isConnected = await InternetConnectionChecker().hasConnection;
    notifyListeners();
    print(isConnected);
  }
}
