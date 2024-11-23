import 'package:flutter/material.dart';
import 'package:flutter_application_base/helpers/preferences.dart';
import 'package:flutter_application_base/screens/screens.dart';
import 'package:flutter_application_base/themes/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.initShared();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void _updateTheme() {
    setState(() {}); // Refresca la UI al cambiar el tema
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: Preferences.darkmode ? ThemeMode.dark : ThemeMode.light,
      routes: {
        'home': (context) => const HomeScreen(),
        'custom_list': (context) => const CustomListScreen(),
        'profile': (context) => ProfileScreen(onThemeChanged: _updateTheme),
        'custom_list_item': (context) => const CustomListItem(),
        'record_list': (context) => const RecordListScreen(),
        'record_details': (context) => const RecordDetailsScreen(),
      },
    );
  }
}



