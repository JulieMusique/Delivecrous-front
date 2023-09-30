import 'package:flutter/material.dart';
import 'package:flutter_ui_food_delivery_app/utils/colors.dart';
import 'package:flutter_ui_food_delivery_app/widgets/custom_text.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController controller =
      TextEditingController(text: "Spicy chickens");

  @override
  void initState() {
   
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: gallery,
            padding: EdgeInsets.all(24),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.075,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    
                    Expanded(
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration.collapsed(
                          hintText: "Search",
                          border: InputBorder.none,
                        ),
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
            decoration: BoxDecoration(
                color: alabaster,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppText(
                    text: "Found  6 results",
                    size: 28,
                    color: Colors.black,
                    weight: FontWeight.w700,
                    textAlign: TextAlign.center,
                  ),
                ),
                Flexible(
                    child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2 / 3,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0),
                  itemBuilder: (BuildContext context, int index) {
                    
                  },
                ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
