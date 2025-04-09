void main(List<String> args) {
  var precio = 400;
  if(precio<100){
    print('Es barato');
  }else if(precio==100){
    print('aceptable');
  }else{
    print('Es caro');
  }

  switch (precio){
    case 100:
      print('Es aceptable');
      continue otro;
    case 200:
      print('Es caro');
      break;
    otro:
      case 400:
        print('OTRO');
  }
  //funciona como un if else
  precio <=100?print('Es barato'):print('Es caro');
  print(precio <=100?'Es barato':'Es caro');
}