// class Mathmatics {
//   int addition=0;
//   int? subtract;
//   int? multiply;
//   void result() {
//     print("addtion${addition! * 2}");
//     print("multiply${multiply! * 2}");
//     print("subtrct${subtract! * 2}");
//   }
// }

// void main() {
//   Mathmatics mathmatics = new Mathmatics();
//   mathmatics.addition = 2;
//   mathmatics.subtract = 4;
//   mathmatics.multiply = 4;
//   mathmatics.result();
// }

/// encapsulation
/// is noting but get and set the value eacatly same of wht we did above cls and objects expamles bt bit different
/// set= set the value
/// get = get the values
/// here is an example=>
// class Mathematics {
//   int? _num;
//   int? _deno;
//   void set setmethod1(int val) {
//     _num = val * 3;
//   }

//   void set setmethod2(int val) {
//     _deno = val * 3;
//   }

//   int get getnum => _num!;
//   int get getdeno => _deno!;
// }

// void main() {
//   Mathematics mathematics = new Mathematics();
//   mathematics.setmethod1 = 20;
//   mathematics.setmethod2 = 30;
//   print(mathematics.getdeno);
//   print(mathematics.getnum);
// }
// void main() {
//   int length = 40;
//   int breadth = 20;
//   int results = getresults(length, breadth);
//   print("area resluts${results}");
// }

// int getresults(int length, int breadth) => length * breadth;
// class Mathematics {
//   int _num = 0;
//   int? _deno;
//   void set setnum(int val) {
//     _num = val + 3;
//   }

//   void set setdeno(int val) {
//     _num = val - 3;
//   }

//   int get getnum => _num;
//   int get getsum => _deno!;
// }

// void main() {
//   Mathematics mathematics = Mathematics();
//   mathematics.setnum = 20;
//   mathematics.setdeno = 10;
//   print(mathematics.getnum);
//   print(mathematics.getsum);
// }
// int areaOfRectangle(int length, int breath) => length * breath;
// void main() {
//   int length = 10;
//   int breath = 20;
//   int area = areaOfRectangle(length, breath);
//   print("Area ofd reactangle is ${area}");
// }
// inheritance is nothing but get data from parent class there are 3 type in inheritance *single*multi level*hera

// class elecrtronics {
//   int height = 20;
//   int weigth = 30;
//   int thickness = 2;
//   // void watch() {
//   //   print("electonics are parent class");
//   // }

//   // void playheight() {
//   //print("electonics are parent class${height}");
//   elecrtronics(String brand) {
//     print("");
//   }
// }

// class Mobilephone extends elecrtronics {
//   // void plays() {
//   //   print("oalf");
//   // }
//   Mobilephone(String model, String brand) : super(brand) {
//     print("data${model}");
//   }
// }

// void main() {
//   Mobilephone mobilephone = Mobilephone("df", "ss");
//   mobilephone.height = 20;
//   mobilephone.thickness = 4;
//   mobilephone.weigth = 50;
//   // mobilephone.playheight();
// }

// abstraction is noting but hide the implementation part of parent class
// here is an exapmle
// abstract class electrnoics {
//   void watch();
//   void damaged() {
//     print("items are damaged");
//   }
// }

// class MobilePhone extends electrnoics {
//   void watch() {
//     print("items getting watched");
//   }
// }

// void main() {
//   MobilePhone mobilePhone = new MobilePhone();
//   mobilePhone.watch();
//   mobilePhone.damaged();
// }
// overiding is notyhig but overide the paraent funtion in child

