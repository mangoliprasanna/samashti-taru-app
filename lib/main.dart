import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samashti_app/helpers/route_generator.dart';
import 'package:samashti_app/helpers/theme_provider.dart';
import 'package:samashti_app/helpers/user_provider.dart';
import 'package:samashti_app/screens/splash_screen.dart';
import 'package:samashti_app/widgets/post/post_provider.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(Samashti());
}

class Samashti extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (_) => ThemeProvider(),
      child: MultiProvider(
        providers: [
          Provider<UserProvider>(create: (_) => UserProvider(),),
          Provider<PostProvider>(create: (_) => PostProvider(),)
        ],
        child: MainApp(),
      ) 
    );
  }
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: "Samashti - The Student Council",
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      onGenerateRoute: RouteGenerator.generateRoute,
      theme: theme.currentTheme,
    );
  }
}
