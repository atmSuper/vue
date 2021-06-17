枚举使用enum关键字来进行定义:

main(List<String> args) {
  print(Colors.black);
}
enum Colors {
  white,
  red,
  black,
}

枚举类型中有两个比较常见的属性:

index: 用于表示每个枚举常量的索引, 从0开始.
values: 包含每个枚举值的List.
main(List<String> args) {
  print(Colors.black);
  //Colors.black
  print(Colors.black.index);
  //2
  print(Colors.values);
  //[Colors.white, Colors.red, Colors.black]
}
enum Colors {
  white,
  red,
  black,
}

List和Map的泛型
List使用时泛型的写法:
var names1 = ["dabai", "xiaobai", "xiaohei", 1];
  print(names1.runtimeType);
  //List<Object>
  //限制类型
  var names2 = <String>["xiaobai", "dabai", 1]; //最后一个报错
  List<String> names3 = ["xiaobai", "dabai", 1];//最后一个报错

Map使用时泛型的写法:
 var map1 = {"name": "dabai", "age": 1, "gendar": "Male"};

  //限制类型
  var map2 = <String, String>{"name": "xiaobai", "age": 1, "gendar": "Male"};//第二个报错
  Map<String, String> map3 = {"name": "xiaobai", "age": 1, "gendar": "Male"};//第二个报错  


类定义的泛型:
main(List<String> args) {
  Location l1 = Location(10, 20);
  print(l1.x.runtimeType); // Object
}

class Location {
  Object x;
  Object y;

  Location(this.x, this.y);
}
Location类的定义:泛型方式

main(List<String> args) {
  Location l2 = Location<int>(10, 20);
  print(l2.x.runtimeType); // int 

  Location l3 = Location<String>('aaa', 'bbb');
  print(l3.x.runtimeType); // String
}

class Location<T> {
  T x;
  T y;

  Location(this.x, this.y);
}
如果希望类型只能是num类型呢?
main(List<String> args) {
  Location l2 = Location<int>(10, 20);
  print(l2.x.runtimeType);
    
  // 错误的写法, 类型必须继承自num
  Location l3 = Location<String>('aaa', 'bbb');
  print(l3.x.runtimeType);
}
class Location<T extends num> {
  T x;
  T y;
  Location(this.x, this.y);
}

泛型方法的定义:
main(List<String> args) {
  var names = ['why', 'kobe'];
  var first = getFirst(names);
  print('$first ${first.runtimeType}'); // why String
}

T getFirst<T>(List<T> ts) {
  return ts[0];
}

??双问号运算符的意思是“如果为空”。以下面的表达式为例。
String a = b ?? 'hello';
这意味着a等于b，但是如果b为null，则a等于'hello'。

另一个相关的运算符是??=。例如:
b ??= 'hello';
这意味着如果b为null，则将其设置为hello。否则，请勿更改。


Dart 1.12 release news统称为“空感知运算符”:
??-如果为空运算符
??=-可以识别空值的作业
x?.p-可以识别null的访问
x?.m()-空值方法调用