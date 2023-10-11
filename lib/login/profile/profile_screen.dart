import 'package:flutter/material.dart';
import 'package:flutter_ui_food_delivery_app/widgets/custom_button.dart';
import '../../utils/colors.dart';
import '../../utils/helper.dart';
import '../../utils/routes.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'), // Titre de la page de profil
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Icône de retour
          onPressed: () {
            Navigator.pushNamed(context, Routes.home);
          }, // Retour à la page précédente
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
                      // Image de profil avec l'option de la caméra
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
                      // Champ de formulaire personnalisé pour le nom
                      CustomFormInput(
                        label: "Name",
                        value: "Emilia Clarke",
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // Champ de formulaire personnalisé pour l'e-mail
                      CustomFormInput(
                        label: "Email",
                        value: "emiliaclarke@email.com",
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // Champ de formulaire personnalisé pour le numéro de téléphone mobile
                      CustomFormInput(
                        label: "Mobile No",
                        value: "emiliaclarke@email.com",
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // Champ de formulaire personnalisé pour l'adresse
                      CustomFormInput(
                        label: "Address",
                        value: "No 23, 6th Lane, Colombo 03",
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // Champ de formulaire personnalisé pour le mot de passe
                      CustomFormInput(
                        label: "Password",
                        value: "Emilia Clarke",
                        isPassword: true,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // Champ de formulaire personnalisé pour la confirmation du mot de passe
                      CustomFormInput(
                        label: "Confirm Password",
                        value: "Emilia Clarke",
                        isPassword: true,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // Bouton "Save" pour enregistrer les modifications du profil
                      AppButton(
                        bgColor: vermilion,
                        borderRadius: 30,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        onTap: () {
                          Navigator.pushNamed(context, Routes.home);
                        },
                        text: "Save",
                        textColor: athens_gray,
                      ),
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

class CustomFormInput extends StatelessWidget {
  const CustomFormInput({
    Key? key,
    required String label,
    required String value,
    bool isPassword = false,
  })  : _label = label,
        _value = value,
        _isPassword = isPassword,
        super(key: key);

  final String _label; // Libellé du champ de formulaire
  final String _value; // Valeur du champ de formulaire
  final bool _isPassword; // Indique si le champ de formulaire est un mot de passe

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      padding: const EdgeInsets.only(left: 40),
      decoration: ShapeDecoration(
        shape: StadiumBorder(),
        color: AppColor.placeholderBg, // Couleur de fond du champ de formulaire
      ),
      child: TextFormField(
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: _label, // Libellé du champ de formulaire
          contentPadding: const EdgeInsets.only(
            top: 10,
            bottom: 10,
          ),
        ),
        obscureText: _isPassword, // Cache le texte si c'est un champ de mot de passe
        initialValue: _value, // Valeur initiale du champ de formulaire
        style: TextStyle(
          fontSize: 14,
        ),
      ),
    );
  }
}
