import 'dart:io';
import 'dart:math';
void main(List<String> args) {
  //formula general
  print("Dame el valor de a:");
  int a = int.parse(stdin.readLineSync()!);
  print("Dame el valor de b");
  int b = int.parse(stdin.readLineSync()!);
  print("Dame el valor de c");
  int c = int.parse(stdin.readLineSync()!);

  var x1, x2;
  x1 =(-b + sqrt(pow(b,2) - 4*(a*c)))/2*a;
  x2 =(-b - sqrt(pow(b,2) - 4*(a*c)))/2*a;
  print(x1);
  print(x2);
  //a1 b2 c-15
}
//sacar raiz sqrt(x) y  pow(x,exponente)