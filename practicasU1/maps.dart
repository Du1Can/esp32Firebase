void main(List<String> args) {
  var estados = {
    "Durango":"Durango",
    "Guadalajara":"Jalisco",
    "Monterrey":"Nuevo León",
    "Chihuahua":"Chihuahua"
  }; 
  print(estados["Monterrey"]);

  pasteles("Naranja", 245.65);

  print(par(5));
}

void pasteles(String pastel,double precio){
  Map<String,double> pasteles = {
    "Chocolate":250.50,
    "Fresa":320.50,
    "Vainilla":280.50
  };
  pasteles[pastel] = precio;
  pasteles.forEach((pastel,precio){
    print("El pastel de $pastel su precio es $precio");
  });
}
//otra forma de declarar funciones
bool par(int x )=>x%2==0; //regresa un valor true o false si el residuo es igual o no a 0