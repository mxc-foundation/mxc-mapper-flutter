import 'package:flutter/material.dart';
import 'package:mxc_mapper/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FakeHttpClient {
  Future<String> get(int url) async {
    await Future.delayed(const Duration(seconds: 1));
    return 'Toral Amount: $url';
  }
}

final fakeHttpClientProvider = Provider((ref) => FakeHttpClient());
final responseProvider =
    FutureProvider.autoDispose.family<String, int>((ref, url) async {
  final httpClient = ref.read(fakeHttpClientProvider);
  return httpClient.get(url);
});

class SideMenu extends StatefulWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  bool _checkboxListTileAll = false;
  bool _checkboxListTileOnline = false;
  bool _checkboxListTileOffline = false;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Welcom to the MXC Mapper", style: TitleTextStyle)
                  ],
                ),
              ],
            ),
          ),
          DropdownButton<String>(
            items: <String>[
              'Matchx',
              'Huawei Tech',
              'Enlink',
              'XY Pool',
              'sejong solutech',
              'DU Iot'
            ].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (_) {},
          ),
          DrawerHeader(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("13353", style: XXLTextStyle),
                    SizedBox(height: defaultPadding),
                    Text(
                      "M2 pro miners2",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("2425", style: XLTextStyle),
              SizedBox(height: defaultPadding),
              Text("LPWAN Gateway", style: RTextStyle),
              SizedBox(height: defaultPadding),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Total Amount:', style: RTextStyle),
                    Text('232425' + ' MXC', style: RTextStyle)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Daily Revenue (Avg.): ', style: RTextStyle),
                    Text('23424' + ' MXC', style: RTextStyle)
                  ],
                ),
              ),
              CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: Text('View All', style: RTextStyle),
                value: _checkboxListTileAll,
                onChanged: (value) {
                  setState(() {
                    _checkboxListTileAll = !_checkboxListTileAll;
                  });
                },
              ),
              CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: Text('View online(' + '234' + ')', style: RTextStyle),
                value: _checkboxListTileOnline,
                onChanged: (value) {
                  setState(() {
                    _checkboxListTileOnline = !_checkboxListTileOnline;
                  });
                },
              ),
              CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: Text('View offline(' + '24' + ')', style: RTextStyle),
                value: _checkboxListTileOffline,
                onChanged: (value) {
                  setState(() {
                    _checkboxListTileOffline = !_checkboxListTileOffline;
                  });
                },
              )
            ],
          ),
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
