import 'package:flutter_ui_food_delivery_app/model/Command.dart';
import 'package:flutter_ui_food_delivery_app/model/list_food.dart';

class HistoryProvider {
  //couterProvider only consists of a counter and a method which is responsible for increasing the value of count
  List<Command> commandItems = [];

  List<Command> addToList(Command commandItem) {
    bool isPresent = false;

    if (commandItems.length > 0) {
      for (int i = 0; i < commandItems.length; i++) {
        if (commandItems[i].idCommand == commandItem.idCommand) {
          isPresent = true;
          break;
        } else {
          isPresent = false;
        }
      }

      if (!isPresent) {
        commandItems.add(commandItem);
      }
    } else {
      commandItems.add(commandItem);
    }

    return commandItems;
  }

  List<Command> removeFromList(Command commandItem) {
    //remove it from the list
    commandItems.remove(commandItem);

    return commandItems;
  }
}
