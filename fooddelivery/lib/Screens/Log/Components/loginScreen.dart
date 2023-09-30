import 'package:flutter/material.dart';
import 'package:fooddelivery/utils/customTextInput.dart';

import '../../../constants/colors.dart';
import 'forgetPwScreen.dart';
import 'signUpScreen.dart';
import '../../../utils/helper.dart';
import 'package:otp/otp.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class LoginScreen extends StatelessWidget {
  String secret = "JBSWY3DPEHPK3PXP";

  String otpCode = "";

  // Fonction pour générer un code OTP aléatoire
  void generateOTP() {
    // Utilisez la bibliothèque OTP pour générer un code OTP
    otpCode = OTP.generateTOTPCodeString(secret, DateTime.now() as int);
  }

  // Fonction pour envoyer l'e-mail contenant le code OTP
  Future<void> sendEmailWithOTP(String userEmail, String otpCode) async {
    

    if (smtpUsername == null || smtpPassword == null) {
      // Gérez le cas où les informations SMTP ne sont pas disponibles
      print('Les informations SMTP ne sont pas disponibles.');
      return;
    }

    final smtpServer = gmail(smtpUsername, smtpPassword);

    // Créez le message avec l'e-mail de l'utilisateur et le code OTP
    final message = Message()
      ..from = Address('your_email@gmail.com')
      ..recipients.add(userEmail)
      ..subject = 'Verification Code for Your Account'
      ..text = 'Your verification code is: $otpCode';

    try {
      // Envoyez l'e-mail
      final sendReport = await send(message, smtpServer);

      print('Message sent: ' + sendReport.toString());
    } catch (e) {
      print('Error sending email: $e');
      // Gérez les erreurs d'envoi d'e-mail ici
    }
  }

// Fonction pour vérifier si l'e-mail est valide en utilisant une expression régulière
  bool _isValidEmail(String email) {
    // L'expression régulière pour vérifier une adresse e-mail valide
    final RegExp emailRegex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$',
      caseSensitive: false,
      multiLine: false,
    );

    return emailRegex.hasMatch(email);
  }

  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Helper.getScreenHeight(context),
        width: Helper.getScreenWidth(context),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 30,
            ),
            child: Column(
              children: [
                Text(
                  "Login",
                  style: Helper.getTheme(context).headline6,
                ),
                Spacer(),
                Text('Add your details to login'),
                Spacer(),
                CustomTextInput(
                  hintText: "Your email",
                  controller: emailController, // Utilisez le contrôleur ici
                ),
                Spacer(),
                CustomTextInput(
                  hintText: "password",
                ),
                Spacer(),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary:
                          Color.fromARGB(255, 72, 142, 3), // Couleur du bouton
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(30.0), // Arrondi des coins
                      ),
                    ),
                    onPressed: () {
                      String userEmail = emailController.text;

                      generateOTP();
                      bool isValidEmail = _isValidEmail(userEmail);

                      if (!isValidEmail) {
                        // Affichez un message d'erreur à l'utilisateur
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Adresse e-mail invalide'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        emailController.clear();

                        return;
                      }
                      sendEmailWithOTP(userEmail, otpCode);
                    },
                    child: Text("Login"),
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ForgetPwScreen()),
                    );
                  },
                  child: Text("Forget your password?"),
                ),
                Spacer(
                  flex: 4,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an Account?"),
                      Text(
                        "Sign Up",
                        style: TextStyle(
                          color: AppColor.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
