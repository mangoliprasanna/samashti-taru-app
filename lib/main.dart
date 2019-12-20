import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:samashti_app/helpers/route_generator.dart';
import 'package:samashti_app/screens/welcome_screen.dart';

void main() {
  runApp(Samashti());
}

class Samashti extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainApp();
  }
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      defaultBrightness: Brightness.light,
      data: (brightness) => ThemeData(
        brightness: Brightness.light,
        primaryColor: Color.fromRGBO(242, 174, 43, 1),
        accentColor: Color.fromRGBO(242, 174, 43, 1),
      ),
      themedWidgetBuilder: (context, theme) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme,
          home: WelcomeScreen(),
          onGenerateRoute: RouteGenerator.generateRoute,
        );
      },
    );
  }
}
