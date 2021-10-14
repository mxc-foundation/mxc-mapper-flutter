import 'package:mxc_mapper/constants.dart';
import 'package:mxc_mapper/controllers/MenuController.dart';
// import 'package:mxc_mapper/screens/main/main_screen.dart';
import 'package:mxc_mapper/responsive.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mxc_mapper/screens/main/components/side_menu.dart';
import 'package:mxc_mapper/screens/main/main_screen.dart';
import 'package:mxc_mapper/screens/map/map_screen.dart';

void main() {
  // riverpod
  runApp(ProviderScope(
    child: MyApp(),
  ));
}

final menuProvider = ChangeNotifierProvider((ref) => MenuController());

/* void main() {
  runApp(MyApp());
} */

class MyApp extends StatelessWidget {
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
      /* home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => MenuController(),
          ),
        ],
        child: MainScreen(),
      ), */

      home: Consumer(builder: (context, watch, child) {
        // final menuController = watch(menuProvider);
        return MainScreen();
        /* Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              Expanded(
                flex: 5,
                child: MapScreen(),
              ),
            Expanded(
              child: SideMenu(),
            ),
          ],
        ); */
      }),
    );
  }
}
