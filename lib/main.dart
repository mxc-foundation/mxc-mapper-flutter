import 'package:mxc_mapper/constants.dart';
import 'package:mxc_mapper/controllers/MenuController.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mxc_mapper/screens/main/main_screen.dart';

void main() {
  // riverpod
  runApp(ProviderScope(
    child: MXCMapperApp(),
  ));
}

final menuProvider = ChangeNotifierProvider((ref) => MenuController());
final greetingProvider = Provider((ref) {
  return 'Hi';
});

class IncrementNotifier extends ChangeNotifier {
  int _value = 0;
  int get value => _value;

  void increment() {
    _value++;
    notifyListeners();
  }
}

final incrementProvider = ChangeNotifierProvider((ref) => IncrementNotifier());

class MXCMapperApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MXC Mapper',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      home: Consumer(builder: (context, watch, child) {
        // final menuController = watch(menuProvider);
        return MainScreen();
      }),
    );
  }
}
