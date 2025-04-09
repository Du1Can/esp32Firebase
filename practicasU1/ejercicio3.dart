import 'dart:io';
void main(List<String> args) {
  List<String> frutas = ["sandia","toronja","kiwi","durazno", "manzana"];
  print("Dame una fruta: ");
  String frutain = stdin.readLineSync()!;
  print((frutas.contains(frutain))?"Esta dentro de la lista":"No esta dentro de la lista");

  //otra forma es con un if
}