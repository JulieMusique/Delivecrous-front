import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui_food_delivery_app/History/bloc/HistorylistBloc.dart';
import 'package:flutter_ui_food_delivery_app/home/main_screen.dart';
import 'package:flutter_ui_food_delivery_app/http/HttpServiceCart.dart';
import 'package:flutter_ui_food_delivery_app/model/Command.dart';
import 'package:flutter_ui_food_delivery_app/model/list_food.dart';
import 'package:flutter_ui_food_delivery_app/utils/colors.dart';
import 'package:flutter_ui_food_delivery_app/utils/style.dart';
import '../model/User.dart';
import 'bloc/listTileColorBloc.dart';

class HistoryScreen extends StatefulWidget {
  final User user;
  HistoryScreen({required this.user});

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late HistoryListBloc bloc;
  Future<List<Command>>? commandItems = Future.value([]);

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.getBloc<HistoryListBloc>();
    fetchHistoryCommands(widget.user.id ?? 0).then((list) {
      if (list.isNotEmpty) {
        setState(() {
          print(list);
          commandItems = Future.value(list);
        });
      } else {
        setState(() {
          commandItems = Future.error(
              "No data found"); // Mettez un message d'erreur approprié
        });
      }
    }).catchError((error) {
      setState(() {
        commandItems = Future.error(error);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Command>>(
      stream: bloc.listStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              leading: GestureDetector(
                child: Icon(
                  CupertinoIcons.back,
                  size: 20,
                ),
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MainScreen(
                                onTap: () {},
                                user: widget.user,
                              )));
                },
              ),
              title: Text(
                "History",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
            ),
            body: SafeArea(child: SafeArea(child: HistoryBody(commandItems))),
          );
        } else if (snapshot.hasError) {
          return Container(
            child: Text("An error occurred: ${snapshot.error}"),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            child: CircularProgressIndicator(),
          );
        } else {
          // Si aucune des conditions ci-dessus n'est remplie, vous pouvez renvoyer un widget par défaut.
          return Container(
            child: Text("Waiting for data..."),
          );
        }
      },
    );
  }
}

class HistoryBody extends StatelessWidget {
  Future<List<Command>>? commandItems;

  HistoryBody(this.commandItems);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Command>>(
      future: commandItems,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Si le Future est en cours d'exécution, affichez un indicateur de chargement.
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // En cas d'erreur, affichez un message d'erreur.
          return noItemContainer();
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          // Si des données sont disponibles et non vides, affichez la liste d'articles.
          return Container(
            padding: EdgeInsets.fromLTRB(20, 30, 15, 0),
            child: Column(
              children: <Widget>[
                CustomAppBar(),
                Expanded(
                  flex: 1,
                  child: commandItemList(snapshot
                      .data!), // Utilisez snapshot.data au lieu de commandItems
                )
              ],
            ),
          );
        } else {
          // Si aucune des conditions ci-dessus n'est remplie, affichez un message approprié.
          return noItemContainer();
        }
      },
    );
  }

  Container noItemContainer() {
    return Container(
      child: Center(
        child: Text(
          "No More Items Left In History",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey[500],
              fontSize: 20),
        ),
      ),
    );
  }

  ListView commandItemList(List<Command> commandItems) {
    return ListView.builder(
      itemCount: commandItems.length,
      itemBuilder: (context, index) {
        return HistoryListItem(commandItem: commandItems[index]);
      },
    );
  }
}

class HistoryListItem extends StatelessWidget {
  final Command commandItem;

  HistoryListItem({required this.commandItem});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: Key(commandItem.idCommand.toString()),
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: Alignment.centerRight,
          color:
              vermilion, // Couleur d'arrière-plan lorsque vous faites glisser l'élément
          child: Icon(
            Icons.delete,
            color: Colors.white,
            size: 30,
          ),
        ),
        onDismissed: (direction) {
          final HistoryListBloc bloc = BlocProvider.getBloc<HistoryListBloc>();

          // Supprimez l'élément de la liste des favoris en utilisant le bloc
          // Fonction pour supprimer un aliment du panier
          //bloc.removeFromList(commandItem);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'La commande ${commandItem.idCommand} retiré des favoris'),
              duration: Duration(seconds: 1),
            ),
          );
          // Vous devrez également mettre à jour l'interface utilisateur ici

          // Affiche un message en bas de l'écran
          // pour refléter les changements dans la liste des favoris
        },
        child: LongPressDraggable(
          hapticFeedbackOnStart: false,
          maxSimultaneousDrags: 1,
          data: commandItem,
          feedback: DraggableChildFeedback(commandItem: commandItem),
          child: DraggableChild(commandItem: commandItem),
          childWhenDragging: DraggableChild(commandItem: commandItem),
        ));
  }
}

class DraggableChild extends StatelessWidget {
  const DraggableChild({
    Key? key,
    required this.commandItem,
  }) : super(key: key);

  final Command commandItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      child: ItemContent(
        commandItem: commandItem,
      ),
    );
  }
}

class DraggableChildFeedback extends StatelessWidget {
  const DraggableChildFeedback({
    Key? key,
    required this.commandItem,
  }) : super(key: key);

  final Command commandItem;

  @override
  Widget build(BuildContext context) {
    final ColorBloc colorBloc = BlocProvider.getBloc<ColorBloc>();

    return Opacity(
      opacity: 0.7,
      child: Material(
        child: StreamBuilder(
          stream: colorBloc.colorStream,
          builder: (context, snapshot) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: snapshot.data != null ? snapshot.data : Colors.white,
              ),
              child: ItemContent(commandItem: commandItem),
            );
          },
        ),
      ),
    );
  }
}

class ItemContent extends StatelessWidget {
  const ItemContent({
    Key? key,
    required this.commandItem,
  }) : super(key: key);

  final Command commandItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(blurRadius: 10, color: AppColor.lighterGray)],
        color: AppColor.white,
      ),
      child: Row(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PrimaryText(
                    text: 'La commande du ${commandItem.orderDate}',
                    size: 18,
                    fontWeight: FontWeight.w700,
                  ),
                  PrimaryText(
                    text: '\$${commandItem.totalAmount}',
                    size: 16,
                    color: AppColor.lightGray,
                  ),
                ],
              ),
            ],
          ),
          Spacer(),
        ],
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: GestureDetector(
        child: Icon(
          CupertinoIcons.back,
          size: 20,
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        "My History Dishes",
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 15,
        ),
      ),
    );
  }
}
