/*import 'package:flutter/material.dart';
//import 'package:flutter_ui_food_delivery_app/profile/camera.dart';
import 'package:flutter_ui_food_delivery_app/utils/colors.dart';
import 'package:flutter_ui_food_delivery_app/utils/routes.dart';
import 'package:flutter_ui_food_delivery_app/widgets/custom_button.dart';
import '../utils/helper.dart';
//import 'package:camera/camera.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  /*late CameraController _cameraController;
  List<CameraDescription> _cameras = [];
ImageProvider<Object> _capturedImage = AssetImage('');*/ // Image vide par défaut

  @override
  void initState() {
    super.initState();
    // Initialisation de la caméra
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    // Récupérez la liste des caméras disponibles
    final cameras = await availableCameras();
    setState(() {
      _cameras = cameras;
      // Utilisez la première caméra par défaut
      _cameraController =
          CameraController(_cameras[0], ResolutionPreset.medium);
      _cameraController.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    });
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          SafeArea(
            child: Container(
              height: Helper.getScreenHeight(context),
              width: Helper.getScreenWidth(context),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      // Dans votre ProfileScreen
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CameraCapturePage(
                                cameraController:
                                    _cameraController, 
                                     onCapture: (capturedImage) {
            setState(() {
              _capturedImage = capturedImage;
              print(_capturedImage);
            });
          },// Transmettez le contrôleur de caméra
                              ),
                            ),
                          );
                        },
                        child: ClipOval(
                          child: Stack(
                            children: [
                              // À l'intérieur de ClipOval
                                Container(
                                height: 80,
                                width: 80,
                                // ignore: unnecessary_null_comparison
                                child: _capturedImage != null
                                    ?Image.asset(
                                        Helper.getAssetName("man.jpeg"),
                                        fit: BoxFit.cover,
                                      )
                                    : Image(
                                        image: _capturedImage,
                                      )
                              ),


                              Positioned(
                                bottom: 0,
                                child: Container(
                                  height: 20,
                                  width: 80,
                                  color: Colors.black.withOpacity(0.3),
                                  child: Icon(
                                    Icons
                                        .camera_alt, // Utilisez une icône de caméra à la place de l'image "camera.png"
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 10,
                      ),

                      CustomFormImput(
                        label: "Name",
                        value: "Emilia Clarke",
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomFormImput(
                        label: "Email",
                        value: "emiliaclarke@email.com",
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomFormImput(
                        label: "Mobile No",
                        value: "emiliaclarke@email.com",
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomFormImput(
                        label: "Address",
                        value: "No 23, 6th Lane, Colombo 03",
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomFormImput(
                        label: "Password",
                        value: "Emilia Clarke",
                        isPassword: true,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomFormImput(
                        label: "Confirm Password",
                        value: "Emilia Clarke",
                        isPassword: true,
                      ),

                      AppButton(
                          bgColor: vermilion,
                          borderRadius: 30,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          onTap: () {
                            Navigator.pushNamed(context, Routes.home);
                          },
                          text: "Save",
                          textColor: athens_gray)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomFormImput extends StatelessWidget {
  const CustomFormImput({
    Key? key,
    required String label,
    required String value,
    bool isPassword = false,
  })  : _label = label,
        _value = value,
        _isPassword = isPassword,
        super(key: key);

  final String _label;
  final String _value;
  final bool _isPassword;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      padding: const EdgeInsets.only(left: 40),
      decoration: ShapeDecoration(
        shape: StadiumBorder(),
        color: AppColor.placeholderBg,
      ),
      child: TextFormField(
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: _label,
          contentPadding: const EdgeInsets.only(
            top: 10,
            bottom: 10,
          ),
        ),
        obscureText: _isPassword,
        initialValue: _value,
        style: TextStyle(
          fontSize: 14,
        ),
      ),
    );
  }
}
*/
import 'package:flutter/material.dart';
import 'package:flutter_ui_food_delivery_app/home/home_screen.dart';
import 'package:flutter_ui_food_delivery_app/home/main_screen.dart';
import 'package:flutter_ui_food_delivery_app/widgets/custom_button.dart';
import '../utils/colors.dart';
import '../utils/helper.dart';
import '../utils/routes.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
  title: Text('Profile'),
  backgroundColor: Colors.transparent,
  elevation: 0,
  leading: IconButton(
    icon: Icon(Icons.arrow_back), // Icône de retour
    onPressed: () {
                        Navigator.pushNamed(context, Routes.home);
; // Retour à la page précédente
    },
  ),
),

      body: Stack(
        children: [
          SafeArea(
            child: Container(
              height: Helper.getScreenHeight(context),
              width: Helper.getScreenWidth(context),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                    
                      ClipOval(
                        child: Stack(
                          children: [
                            Container(
                              height: 80,
                              width: 80,
                              child: Image.asset(
                                Helper.getAssetName(
                                  "man.jpeg",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              child: Container(
                                height: 20,
                                width: 80,
                                color: Colors.black.withOpacity(0.3),
                                child: Image.asset(Helper.getAssetName(
                                    "camera.png")),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                   
                      SizedBox(
                        height: 40,
                      ),
                      CustomFormImput(
                        label: "Name",
                        value: "Emilia Clarke",
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomFormImput(
                        label: "Email",
                        value: "emiliaclarke@email.com",
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomFormImput(
                        label: "Mobile No",
                        value: "emiliaclarke@email.com",
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomFormImput(
                        label: "Address",
                        value: "No 23, 6th Lane, Colombo 03",
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomFormImput(
                        label: "Password",
                        value: "Emilia Clarke",
                        isPassword: true,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomFormImput(
                        label: "Confirm Password",
                        value: "Emilia Clarke",
                        isPassword: true,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                       AppButton(
                          bgColor: vermilion,
                          borderRadius: 30,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          onTap: () {
                            Navigator.pushNamed(context, Routes.home);
                          },
                          text: "Save",
                          textColor: athens_gray)
                    ],
                  ),
                ),
              ),
            ),
          ),
         
        ],
      ),
    );
  }
}

class CustomFormImput extends StatelessWidget {
  const CustomFormImput({
    Key? key,
   required String label,
    required String value,
    bool isPassword = false,
  })  : _label = label,
        _value = value,
        _isPassword = isPassword,
        super(key: key);

  final String _label;
  final String _value;
  final bool _isPassword;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      padding: const EdgeInsets.only(left: 40),
      decoration: ShapeDecoration(
        shape: StadiumBorder(),
        color: AppColor.placeholderBg,
      ),
      child: TextFormField(
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: _label,
          contentPadding: const EdgeInsets.only(
            top: 10,
            bottom: 10,
          ),
        ),
        obscureText: _isPassword,
        initialValue: _value,
        style: TextStyle(
          fontSize: 14,
        ),
      ),
    );
  }
}