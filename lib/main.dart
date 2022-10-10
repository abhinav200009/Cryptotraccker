import 'package:cryptotracker/constants/theme.dart';
import 'package:cryptotracker/models/local_storage.dart';
import 'package:cryptotracker/provider/market_provider.dart';
import 'package:cryptotracker/provider/theme_provider.dart';
import 'package:cryptotracker/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'constants/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String currentTheme = await LocalStorage.getTheme() ?? "light ";
  runApp(MyApp(
    theme: currentTheme,
  ));
}

class MyApp extends StatelessWidget {
  final String theme;
  MyApp({required this.theme});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MarketProvider>(
            create: (context) => MarketProvider()),
        ChangeNotifierProvider<ThemeProvider>(
            create: (context) => ThemeProvider(theme))
      ],
      child: Consumer<ThemeProvider>(builder: (context, themeMode, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: themeMode.themeMode,
          theme: lightTheme,
          darkTheme: darkTheme,
          home: Homepage(),
        );
      }),
    );
  }
}
