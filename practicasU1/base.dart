
void main(){
  print("hola mundo");
  //tipos de datos en dart no hay float
  //el int y double son de 64 bits
  int? x; //puede ser null con el ?
  double y = 0.0;
  print(x);
  print(y);
  String cad = "ITD";
  print(cad);
  bool flag = true;
  print(flag);

  //inferencia de tipos utilizando la palabra reservada var
  // a este no se ocupa ponerle ?
  //salto de linea con triple comillas """
  print("los valores en los tipos de datos vistos en clase son: $x $y $cad $flag");
  print("Si quiero hacer operaciones dentro de una cadena: ${y+1}");

  //const(aloja el valor en tiempo de compilación) y final(aloja el valor en la memoria en tiempo de ejecución) con diferentes
  
}