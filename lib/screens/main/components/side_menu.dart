import 'package:flutter/material.dart';
import 'package:flutter_textfield_autocomplete/flutter_textfield_autocomplete.dart';
import 'package:mxc_mapper/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

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

  ScrollController _controller = ScrollController();

  static const historyLength = 5;

  List<String> _searchHistory = [
    'ddd2',
    'ddd3',
    'ddd4',
    'ddd5',
  ];

  GlobalKey<TextFieldAutoCompleteState<String>> _textFieldAutoCompleteKey =
      new GlobalKey();

  List<String> filteredSearchHistory = [];

  String selectedTerm = '';

  List<String> filterSearchTerms({
    String filter = '',
  }) {
    if (filter != null && filter.isNotEmpty) {
      return _searchHistory.reversed
          .where((term) => term.startsWith(filter))
          .toList();
    } else {
      return _searchHistory.reversed.toList();
    }
  }

  void addSearchTerm(String term) {
    if (_searchHistory.contains(term)) {
      putSearchTermFirst(term);
      return;
    }

    _searchHistory.add(term);
    if (_searchHistory.length > historyLength) {
      _searchHistory.removeRange(0, _searchHistory.length - historyLength);
    }

    filteredSearchHistory = filterSearchTerms(filter: '');
  }

  void deleteSearchTerm(String term) {
    _searchHistory.removeWhere((t) => t == term);
    filteredSearchHistory = filterSearchTerms(filter: '');
  }

  void putSearchTermFirst(String term) {
    deleteSearchTerm(term);
    addSearchTerm(term);
  }

  late FloatingSearchBarController controller;

  @override
  void initState() {
    super.initState();
    controller = FloatingSearchBarController();
    filteredSearchHistory = filterSearchTerms(filter: '');
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

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
          Container(
            height: 100,
            child: FloatingSearchBar(
              controller: controller,
              body: FloatingSearchBarScrollNotifier(
                child: SizedBox(height: 0),
                /* child: SearchResultsListView(
                  searchTerm: selectedTerm,
                ), */
              ),
              // transition: CircularFloatingSearchBarTransition(),
              physics: BouncingScrollPhysics(),
              title: Text(
                selectedTerm ?? 'The Search App',
                style: Theme.of(context).textTheme.headline6,
              ),
              hint: 'Search and find out...',
              automaticallyImplyDrawerHamburger: false,
              backgroundColor: Color.fromRGBO(42, 45, 62, 1),
              accentColor: Color.fromRGBO(42, 45, 62, 1),
              shadowColor: Color.fromRGBO(42, 45, 62, 0),
              backdropColor: Color.fromRGBO(42, 45, 62, 0),
              actions: [
                FloatingSearchBarAction.searchToClear(),
              ],
              onQueryChanged: (query) {
                print("query : $query");
                setState(() {
                  filteredSearchHistory = filterSearchTerms(filter: query);
                });

                print("filteredSearchHistory : ${filteredSearchHistory.first}");
              },
              onSubmitted: (query) {
                setState(() {
                  addSearchTerm(query);
                  selectedTerm = query;
                });
                controller.close();
              },
              builder: (context, transition) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Material(
                    color: Colors.white,
                    elevation: 4,
                    child: Builder(
                      builder: (context) {
                        print(
                            "filteredSearchHistory in builder : $filteredSearchHistory");
                        if (filteredSearchHistory.isEmpty &&
                            controller.query.isEmpty) {
                          return Container(
                            height: 0,
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: Text(
                              'Start searching',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.caption,
                            ),
                          );
                        } else if (filteredSearchHistory.isEmpty) {
                          return ListTile(
                            title: Text(controller.query),
                            leading: const Icon(Icons.search),
                            onTap: () {
                              setState(() {
                                addSearchTerm(controller.query);
                                selectedTerm = controller.query;
                              });
                              controller.close();
                            },
                          );
                        } else {
                          // return ListView.builder(
                          //     shrinkWrap: true,
                          //     controller: _controller,
                          //     itemCount: filteredSearchHistory.length,
                          //     itemBuilder: (context, index) {
                          //       print(
                          //           "In listview builder : $filteredSearchHistory");
                          //       return Text("${filteredSearchHistory[index]}",
                          //           style: TextStyle(color: Colors.red));
                          //     });
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: filteredSearchHistory
                                .map(
                                  (term) => ListTile(
                                    title: Text(
                                      term,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(color: Colors.black87),
                                    ),
                                    leading: const Icon(Icons.history),
                                    trailing: IconButton(
                                      icon: const Icon(Icons.clear),
                                      onPressed: () {
                                        setState(() {
                                          deleteSearchTerm(term);
                                        });
                                      },
                                    ),
                                    onTap: () {
                                      setState(() {
                                        putSearchTermFirst(term);
                                        selectedTerm = term;
                                      });
                                      controller.close();
                                    },
                                  ),
                                )
                                .toList(),
                          );
                        }
                      },
                    ),
                  ),
                );
              },
            ),
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

class SearchResultsListView extends StatelessWidget {
  final String searchTerm;

  const SearchResultsListView({
    Key? key,
    this.searchTerm = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (searchTerm == '') {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search,
              size: 64,
            ),
            Text(
              'Start searching',
              style: Theme.of(context).textTheme.headline5,
            )
          ],
        ),
      );
    }

    // final fsb = FloatingSearchBar.of(context);

    return ListView(
      padding: EdgeInsets.only(top: 20),
      children: List.generate(
        50,
        (index) => ListTile(
          title: Text('$searchTerm search result'),
          subtitle: Text(index.toString()),
        ),
      ),
    );
  }
}
