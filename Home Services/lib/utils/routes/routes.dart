import 'package:flutter/material.dart';


import '../../Forgot/Forgot_Password/Forgot_passoword_view.dart';
import '../../Not_Sing_Up.dart';
import '../../Proder/view/Dashboad/Admin_Dashboad_Screen.dart';
import '../../Proder/view/Proder_SignUp_Screen.dart';
import '../../Proder/view/Proder_Login_screen.dart';
import '../../Users/dashboad/Dashboad_Screen.dart';
import '../../Users/dashboad/Profile/Profie_Screen.dart';
import '../../Users/login/Mobile_Number.dart';
import '../../Users/login/login.dart';
import '../../Users/signup/sign_up_screen.dart';
import '../../Users/splash/splash_screen.dart';

import 'route_name.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case RouteName.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RouteName.loginView:
        return MaterialPageRoute(builder: (_) => const UserLogin());

      case RouteName.SignupView:
        return MaterialPageRoute(builder: (_) => const SignupScreen());

      case RouteName.ForgotView:
        return MaterialPageRoute(builder: (_) => const ForgotPassword());
      case RouteName.ProderDashboardView:
        return MaterialPageRoute(builder: (_) => const ProderDashboadScreen());
      case RouteName.LoginMobileView:
        return MaterialPageRoute(builder: (_)=> const MobileNumber());
      case RouteName.ProifileView:
        return MaterialPageRoute(builder: (_)=>  ProifileScreen());
      case RouteName.UserLoginView:
        return MaterialPageRoute(builder: (_)=> const UserLogin());
      case RouteName.NotSignUPView:
        return MaterialPageRoute(builder: (_)=> const NotSignUP());
      case RouteName.ProuderSignupView:
        return MaterialPageRoute(builder: (_)=> const ProuderSignupScreen());


      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}
