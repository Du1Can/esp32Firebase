void main(List<String> args) {
  List <String> so = ['Android','IOS','Windows Phone'];
  print('ciclo1');
  for (int i = 0; i < so.length; i++) {
    print(so[i]);
  }
  print('ciclo2');
  so.forEach((i){
    print(i);
  });
  print('ciclo3');
  for (var i in so) {
    print(i);
  }
  print('ciclo4');
  int x=0;
  while (x<= so.length-1) {
    print(so[x]);
    x++;
  }
  print('ciclo5');
  int y=0;
  do {
    print(so[y]);
    y++;
    
  } while (y<so.length);


}