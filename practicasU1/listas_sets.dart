void main(List<String> args) {
  List<int> valores;
  valores = [1,2,3,4,5,5,4,3,2];
  print(valores); //para imprimir una posicion es con [] como en java
  List<String> cad;
  cad = ["cad1","cad2","cad3"];
  print(cad);

  //sets
  Set numeros = Set.from(valores);
  print(numeros);

}