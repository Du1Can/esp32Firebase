import 'dart:io';
void main(List<String> args) {
  //input, lectura
  int val = int.parse(stdin.readLineSync()!); //cuando se usa null-savefty, tenemos que poner el ! para jalar el valor y no salga error
  print(val);

  //para correrlo nos metemos en terminal, y luego a la carpeta y despues el comando:
  //dart nombrearchivo.dart

  String? nombre = stdin.readLineSync();
  print(nombre);
}

