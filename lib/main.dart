import 'package:Expenso/bloc/activity_bloc.dart';
import 'package:Expenso/bloc/preset_bloc.dart';
import 'package:Expenso/preset/preset_create/preset_create_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Expenso/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:Expenso/home/loading.dart';
import 'package:provider/provider.dart';
import 'package:Expenso/theme/ThemeManager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'expnses/transaction_list_model.dart';
import 'expnses/transactions_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await TransacationsDatabase.init();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  ThemeMode savedThemeMode = ThemeManager
      .modeMapper[prefs.getInt('theme') ?? ThemeManager.defaultThemeIndex]!;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => ThemeManager(themeMode: savedThemeMode)),
        ChangeNotifierProvider(create: (context) => TransactionList()),
      ],
      child: const EnduranceApp(),
    ),
  );
}

class EnduranceApp extends StatelessWidget {
  const EnduranceApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<PresetBloc>(
              create: (BuildContext context) => PresetBloc()),
          BlocProvider<ActivityBloc>(
              create: (BuildContext context) => ActivityBloc())
        ],
        child: MaterialApp(
          title: 'Expenso',
          theme: Provider.of<ThemeManager>(context).lightMode,
          darkTheme: Provider.of<ThemeManager>(context).darkMode,
          themeMode: Provider.of<ThemeManager>(context).themeMode,
          initialRoute: '/',
          routes: {
            "/": (context) => LoadingPage(),
            "/home": (context) => const HomePage(
                  title: 'Home Page',
                  username: 'your_username_here',
                ),
            // '/': (context) => const HomePage(title: 'Home Page'),
            '/preset/create': (context) => const CreatePresetPage()
          },
        ));
  }
}
