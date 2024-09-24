import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/dstate/d_logic.dart';
import 'bloc/newstate/NewsLogic.dart';
import 'bloc/shareState/ShareLogic.dart';
import 'bloc/themestate/themeLogic.dart';
import 'bloc/themestate/themeState.dart';
import 'firebase_options.dart';
import 'home.dart';
import 'layout/registration/authScreen.dart';
import 'layout/settingTap/theme.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<ThemeLogic>(create: (context) => ThemeLogic(),),
      BlocProvider<DLogic>(create: (context) => DLogic(),),
      BlocProvider<NewsLogic>(create: (context) => NewsLogic(),),
      BlocProvider<ShareLogic>(create: (context) => ShareLogic(),),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeLogic, ThemeState>(
      builder: (context, state) {
        final themeLogic = context.read<ThemeLogic>();
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lighttheme,
          darkTheme: darktheme,
          themeMode: themeLogic.currentThemeMode,
          initialRoute: home.rountName,
          routes: {
            home.rountName: (context) => authpage(), // Route setup
          },
        );
      },
    );
  }
}

