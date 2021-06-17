import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/menu_view.dart';
import 'package:flutter_application_1/view/user/login_view.dart';
import 'package:flutter_application_1/view/user/register_view.dart';


Map<String,WidgetBuilder> routes = {
   "/":(BuildContext context) => LoginView(), 
   "register": (BuildContext context) => RegisterView(),  
   'menu':(BuildContext context) => MenuView(),  
};