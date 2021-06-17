https://juejin.cn/post/6844903766492200974

继承（关键字 extends）
混入 mixins （关键字 with）
接口实现（关键字 implements）

extends ->  mixins -> implements
extens在前，mixins在中间，implements最后，接下来看具体的例子。

class Television {
  void turnOn() {
    _illuminateDisplay();
  }
  
  void _illuminateDisplay(){
  }
}

class Update{
  void updateApp(){

  }
}

class Charge{

  void chargeVip(){

  }
}

class SmartTelevision extends Television with Update,Charge  {

  void turnOn() {
    super.turnOn();
    _bootNetworkInterface();
    updateApp();
    chargeVip();
  }
  
  void _bootNetworkInterface(){
  }

}
