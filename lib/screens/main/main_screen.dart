// import 'package:mxc_mapper/controllers/MenuController.dart';
import 'package:mxc_mapper/responsive.dart';
import 'package:mxc_mapper/screens/map/map_screen.dart';
import 'package:flutter/material.dart';
import 'components/side_menu.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(),
      body: Row(
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
      ),
    );
  }
}
