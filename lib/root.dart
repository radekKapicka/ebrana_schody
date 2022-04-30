import 'package:ebrana_schody/pages/navpages/home_page.dart';
import 'package:ebrana_schody/pages/welcome_page.dart';
import 'package:flutter/cupertino.dart';

enum AuthStatus{
  notLoggedIn,
  loggedIn,
}

class RootWidget extends StatefulWidget {
  const RootWidget({Key? key}) : super(key: key);

  @override
  State<RootWidget> createState() => _RootWidgetState();
}

class _RootWidgetState extends State<RootWidget> {

  AuthStatus _authStatus = AuthStatus.notLoggedIn;

  @override
  void didChangeDependencies() async{
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();


  }

  @override
  Widget build(BuildContext context) {
    Widget retVal;

    switch(_authStatus){
      case AuthStatus.notLoggedIn:
         retVal = WelcomePage();
        break;
      case AuthStatus.loggedIn:
        retVal = WelcomePage();
        break;
      default: retVal = WelcomePage();
    }
    return retVal;
  }
}
