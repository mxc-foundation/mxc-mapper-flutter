import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset("assets/images/logo.png"),
          ),
          DrawerListTile(
            title: "Dashbord",
            svgSrc: "assets/icons/menu_dashbord.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "LPWAN MANAGEMENT",
            svgSrc: "assets/icons/dummy.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Network Server",
            svgSrc: "assets/icons/menu_networkserver.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Gateway",
            svgSrc: "assets/icons/menu_gateway.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Device",
            svgSrc: "assets/icons/menu_device.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Organization",
            svgSrc: "assets/icons/menu_organization.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Profile",
            svgSrc: "assets/icons/menu_profiles.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Setting",
            svgSrc: "assets/icons/menu_settings.svg",
            press: () {},
          ),
          /* DrawerListTile(
            title: "Settings",
            svgSrc: "assets/icons/menu_setting.svg",
            press: () {},
          ), */
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: Colors.white54,
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}
