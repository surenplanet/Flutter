import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/user_auth.dart';

import "./screens/home_screen.dart";
import "./screens/splash_screen.dart";
import './screens/user_auth_screen.dart';
import './screens/names_screen.dart';
//import './helpers/custom_route.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: UserAuth(),
        ),
      ],
      child: Consumer<UserAuth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'MyShop',
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato',
            /* pageTransitionsTheme: PageTransitionsTheme(
              builders: {
                TargetPlatform.android: CustomPageTransitionBuilder(),
                TargetPlatform.iOS: CustomPageTransitionBuilder(),
              },
            ),*/
          ),
          home: NamesScreen(),
//          auth.isAuth
//              ? HomeScreen()
//              : FutureBuilder(
//                  future: auth.tryAutoLogin(),
//                  builder: (ctx, authResultSnapshot) =>
//                      authResultSnapshot.connectionState ==
//                              ConnectionState.waiting
//                          ? SplashScreen()
//                          : UserAuthScreen(),
//                ),
          routes: {
            NamesScreen.routeName: (ctx) => NamesScreen(),
          },
        ),
      ),
    );
  }
}
