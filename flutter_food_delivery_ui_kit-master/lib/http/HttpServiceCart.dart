import 'dart:convert';
import 'package:flutter_ui_food_delivery_app/model/Command.dart';
import 'package:http/http.dart' as http;

String baseURL = "http://localhost:8080/DelivCROUS";

Future<Command> createCommand(Command command) async {
  var body = jsonEncode(command.toJson());
  var url = Uri.parse(baseURL + '/commands');
  http.Response response = await http.post(url, body: body);
  print(response.body);
  Map<String, dynamic> responseMap = jsonDecode(response.body);
  Command newCommand = Command.fromJson(responseMap); // Renommez la variable
  return newCommand;
}

Future<Result<List<Command>?, Exception>> getCommands() async {
  try {
    final url = Uri.parse(baseURL + '/commands');
    final response = await http.get(url);
    switch (response.statusCode) {
      case 200:
        // 2. return Success with the desired value
        List responseList = jsonDecode(response.body);
        List<Command> commands = [];
        for (Map<String, dynamic> commandMap in responseList) {
          Command command = Command.fromJson(commandMap);
          commands.add(command);
        }
        return Success(commands);
      default:
        // 3. return Failure with the desired exception
        return Failure(Exception(response.reasonPhrase));
    }
  } on Exception catch (e) {
    // 4. return Failure here too
    return Failure(e);
  }
}

Future<void> addDishToCommand(int idCommand, int idDish) async {
  final response = await http.put(
      Uri.parse('http://localhost:8080/DelivCROUS/$idCommand/add/$idDish'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });

  if (response.statusCode != 200) {
    // Gérez les erreurs en fonction du code de statut de la réponse
    print("Réponse du serveur : ${response.body}");

    throw Exception('Erreur lors de l\'ajout du plat dans la commande');
  }
}

Future<http.Response> updateFood(int id) async {
  var url = Uri.parse(baseURL + '/commands/$id');
  http.Response response = await http.put(
    url,
  );
  print(response.body);
  return response;
}

Future<http.Response> history() async {
  var url = Uri.parse(baseURL + '/commands/history');
  http.Response response = await http.delete(
    url,
  );
  print(response.body);
  return response;
}

Future<http.Response> notordered() async {
  var url = Uri.parse(baseURL + '/commands/notordered');
  http.Response response = await http.delete(
    url,
  );
  print(response.body);
  return response;
}

Future<http.Response> delivered() async {
  var url = Uri.parse(baseURL + '/commands/delivered');
  http.Response response = await http.delete(
    url,
  );
  print(response.body);
  return response;
}

Future<http.Response> deleteDishFromCommand(int idCommand, int idDish) async {
  var url = Uri.parse(baseURL + '/commands/$idCommand/remove/$idDish');
  http.Response response = await http.delete(
    url,
  );
  print(response.body);
  return response;
}

Future<http.Response> deleteCommand(int id) async {
  var url = Uri.parse(baseURL + '/commands/$id');
  http.Response response = await http.delete(
    url,
  );
  print(response.body);
  return response;
}

sealed class Result<S, E extends Exception> {
  const Result();
}

final class Success<S, E extends Exception> extends Result<S, E> {
  const Success(this.value);
  final S value;
}

final class Failure<S, E extends Exception> extends Result<S, E> {
  const Failure(this.exception);
  final E exception;
}
