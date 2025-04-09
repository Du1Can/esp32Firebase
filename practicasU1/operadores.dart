void main(List<String> args){
  var x;
  x = 1;
  print(x is !String); //solamente que no acepta x is null

  var y = 100;
  print((y>=100)&&(y<200)?"Es barato":"Es caro");

}