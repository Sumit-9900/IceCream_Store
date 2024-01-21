import 'package:flutter/material.dart';
import 'package:store_pro/app/constants.dart';
import 'package:store_pro/l10n/l10n.dart';
import 'package:store_pro/product_store/views/home_view.dart';
import 'package:store_pro/product_store/views/login_view.dart';
import 'package:store_pro/themes/styles.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: Styles.lightColorScheme,
      ),
      darkTheme: ThemeData(
        colorScheme: Styles.darkColorScheme,
      ),
      themeMode: ThemeMode.light,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Constants.prefs!.getBool('isLoggedIn') == true
          ? const HomeView()
          : const LoginView(),
    );
  }
}
