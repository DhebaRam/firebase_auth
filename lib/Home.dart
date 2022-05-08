import 'dart:io';
import 'package:app/mainPage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:app/AppProvider.dart';
import 'package:app/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> // with TickerProviderStateMixin
{
  final Color yellow = const Color(0xfffbc31b);
  final Color orange = const Color(0xfffb6900);

  // AnimationController? animationController;
  File? imageess;
  File? photoUrl;
  XFile? images;

  @override
  void initState() {
    super.initState();
    Provider.of<AppProvider>(context, listen: false).checkimage();
    // animationController =
    //     AnimationController(duration: const Duration(seconds: 2), vsync: this);
    // animationController!.repeat();
    getPermission();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // animationController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fireauth = FirebaseAuth.instance.currentUser!.uid;
    final refs = FirebaseStorage.instance.ref().child('files/$fireauth');
    return Scaffold(
        // appBar: AppBar(
        //   actions: [
        //     Container(
        //       padding: const EdgeInsets.only(left: 15, right: 15),
        //       // decoration: const BoxDecoration(
        //       //   color: Colors.grey,
        //       //   borderRadius: BorderRadius.all(Radius.circular(15)),
        //       // ),
        //       child: IconButton(
        //         icon: const Icon(
        //           Icons.logout,
        //         ),
        //         onPressed: () async {
        //           await FirebaseAuth.instance.signOut().then((value) =>
        //               Navigator.of(context).pushAndRemoveUntil(
        //                   MaterialPageRoute(
        //                       builder: (context) => const Login()),
        //                   (route) => false));
        //           // Navigator.of(context)
        //           //     .push(MaterialPageRoute(builder: (context) => const Login()));
        //         },
        //       ),
        //     ),
        //   ],
        // ),
        body: Consumer<AppProvider>(builder: (context, data, child) {
      data.setImage(refs);
      return Column(children: [
        Container(
          height: 150,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(50.0),
                  bottomRight: Radius.circular(50.0)),
              gradient: LinearGradient(
                  colors: [orange, yellow],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight)),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                "Uploading Image to Firebase Storage",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontStyle: FontStyle.italic),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          child: Stack(
            children: [
              if (data.urls != null)
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 4.0),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(data.urls), fit: BoxFit.cover),
                  ),
                )
              else
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    border: Border.all(color: Colors.white70, width: 4.0),
                    shape: BoxShape.circle,
                  ),
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.deepPurpleAccent,
                    color: Colors.red,
                    // valueColor: animationController!.drive(
                    //     ColorTween(begin: Colors.blueAccent, end: Colors.red))
                  ),
                ),
              TextButton(
                child: const Icon(
                  Icons.add_a_photo,
                  size: 40,
                ),
                onPressed: pickImage,
              ),
            ],
          ),
        ),
        // ignore: deprecated_member_use
        RaisedButton(
          child: const Text("Logout",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20)),
          onPressed: () async {
            data.urlnull();
            await FirebaseAuth.instance.signOut().then((value) =>
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const MainPage()),
                    (route) => false));
          },
        ),
      ]);
    }));
  }

  void pickImage() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Consumer<AppProvider>(builder: (context, data, child) {
            return SafeArea(
                child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Gallery'),
                  onTap: () {
                    data.imgFromGallery();
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: const Text('Camera'),
                    onTap: () {
                      data.imgFromCamera();
                      Navigator.of(context).pop();
                    })
              ],
            ));
          });
        });
  }

  void getPermission() async {
    await Permission.storage.request();
    await Permission.camera.request();
  }
// void uploadImage() async{
//   final getProvider = Provider.of<AppProvider>(context, listen: false);
//   FirebaseStorage storage = FirebaseStorage.instance;
//   if(getProvider.images!.path.isEmpty){
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         backgroundColor: Colors.pinkAccent,
//         content: Text(
//           "Please select Image..",
//           style: TextStyle(fontSize: 20.0),
//         ),
//       ),
//     );
//   }
//   else{
//     final
//     try {
//       final ref = FirebaseStorage.instance
//           .ref()
//           .child('file/');
//       await ref.putFile(getProvider.images!.path);
//     }
//     catch(e){
//       print(e.toString());
//     }
//   }
// }
}
