import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fooddelivery/Screens/HomeScreen.dart';
import 'package:rive/rive.dart';

class PageConnexion extends StatefulWidget {
  const PageConnexion({Key? key}) : super(key: key);

  @override
  State<PageConnexion> createState() => _PageConnexionState();
}

class _PageConnexionState extends State<PageConnexion> {
  String? _idUtilisateur;
  String? _mdpUtilisateur;
  String? _emailUtilisateur;
  bool _estConnectable = true;
  String? _message;
  late String animationURL;
  Artboard? _teddyArtboard;
  SMITrigger? successTrigger, failTrigger;
  SMIBool? isHandsUp, isChecking;
  SMINumber? numLook;

  StateMachineController? stateMachineController;
  final TextEditingController _txtEmail = TextEditingController();
  final TextEditingController _txtMdp = TextEditingController();

  Widget boutonPrincipal() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: ElevatedButton(
        onPressed: () =>  Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            )/*soumettre()*/,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 3,
        ),
        child: Text(_estConnectable ? 'Se connecter' : 'S\'inscrire'),
      ),
    );
  }

  Widget messageValidation() {
    return _message != null
        ? Text(
            _message!,
            style: const TextStyle(color: Colors.red),
          )
        : const SizedBox.shrink();
  }

  Widget boutonSecondaire() {
    return TextButton(
      onPressed: () {
        setState(() {
          _estConnectable = !_estConnectable;
        });
      },
      child: Text(_estConnectable ? 'Créer un compte' : 'Se connecter'),
    );
  }

  void handsOnTheEyes() {
    isHandsUp?.change(true);
  }

  void lookOnTheTextField() {
    isHandsUp?.change(false);
    isChecking?.change(true);
    numLook?.change(0);
  }

  void moveEyeBalls(val) {
    numLook?.change(val.length.toDouble());
  }

 /* Future<void> soumettre() async {
    isChecking?.change(false);
    isHandsUp?.change(false);
    setState(() {
      _message = "";
    });

    try {
      if (_estConnectable) {
        _emailUtilisateur = _txtEmail.text;
        _mdpUtilisateur = _txtMdp.text;

        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailUtilisateur ?? "",
          password: _mdpUtilisateur ?? "",
        );

        _idUtilisateur = userCredential.user?.uid;
      } else {
        _emailUtilisateur = _txtEmail.text;
        _mdpUtilisateur = _txtMdp.text;

        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailUtilisateur ?? "",
          password: _mdpUtilisateur ?? "",
        );

        _idUtilisateur = userCredential.user?.uid;
      }

      if (_idUtilisateur != null) {
        setState(() {
          successTrigger?.fire();
        });

        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PagePrincipale()),
        );
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        failTrigger?.fire();
        _message = e.message;
      });
    }
  }*/

  @override
  void initState() {
    super.initState();
    animationURL = defaultTargetPlatform == TargetPlatform.android
        ? 'assets/animations/login.riv'
        : 'animations/login.riv';
    rootBundle.load(animationURL).then(
      (data) {
        final file = RiveFile.import(data);
        final artboard = file.mainArtboard;
        stateMachineController =
            StateMachineController.fromArtboard(artboard, "Login Machine");
        if (stateMachineController != null) {
          artboard.addController(stateMachineController!);

          stateMachineController!.inputs.forEach((e) {
            debugPrint(e.runtimeType.toString());
            debugPrint("name${e.name}End");
          });

          stateMachineController!.inputs.forEach((element) {
            if (element.name == "trigSuccess") {
              successTrigger = element as SMITrigger;
            } else if (element.name == "trigFail") {
              failTrigger = element as SMITrigger;
            } else if (element.name == "isHandsUp") {
              isHandsUp = element as SMIBool;
            } else if (element.name == "isChecking") {
              isChecking = element as SMIBool;
            } else if (element.name == "numLook") {
              numLook = element as SMINumber;
            }
          });
        }
        setState(() => _teddyArtboard = artboard);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffd6e2ea),
      body: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_teddyArtboard != null)
                    SizedBox(
                      width: 300,
                      height: 250,
                      child: Rive(
                        artboard: _teddyArtboard!,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  Container(
                    alignment: Alignment.center,
                    width: 400,
                    padding: const EdgeInsets.only(bottom: 10),
                    margin: const EdgeInsets.only(bottom: 10 * 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            children: [
                              const SizedBox(height: 15 * 2),
                              TextField(
                                controller: _txtEmail,
                                onTap: lookOnTheTextField,
                                onChanged: moveEyeBalls,
                                keyboardType: TextInputType.emailAddress,
                                style: const TextStyle(fontSize: 14),
                                cursorColor: const Color(0xffb04863),
                                decoration: InputDecoration(
                                  hintText: "Adresse mail",
                                  filled: true,
                                  border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: SvgPicture.asset(
                                        "assets/icons/email.svg"),
                                  ),
                                  focusColor: const Color(0xffb04863),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xffb04863),
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextField(
                                controller: _txtMdp,
                                onTap: handsOnTheEyes,
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: true,
                                style: const TextStyle(fontSize: 14),
                                cursorColor: const Color(0xffb04863),
                                decoration: InputDecoration(
                                  hintText: "Mot de Passe",
                                  filled: true,
                                  border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: SvgPicture.asset(
                                        "assets/icons/password.svg"),
                                  ),
                                  focusColor: const Color(0xffb04863),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xffb04863),
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                ),
                              ),
                              boutonPrincipal(),
                              boutonSecondaire(),
                              const SizedBox(height: 2),
                              messageValidation(),
                              const SizedBox(height: 4),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ]),
    );
  }
}
