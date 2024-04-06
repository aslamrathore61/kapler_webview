import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:kepler_web/model/native_item.dart';
import '../../Utils/constants.dart';
import 'BuyPage.dart';
import 'HomePage.dart';
import 'RentPage.dart';
import 'TripleNinePage.dart';

class BottomNaviBar extends StatefulWidget {
  const BottomNaviBar({Key? key}) : super(key: key);

  @override
  State<BottomNaviBar> createState() => _BottomNaviBarState();
}

class _BottomNaviBarState extends State<BottomNaviBar> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool canPop = false;
  DateTime? currentBackPressTime;
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index == 4) {
      _scaffoldKey.currentState?.openDrawer();
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  void Function() getNavigateToHomePageCallback() {
    return _navigateToHomePage;
  }

  void _navigateToHomePage() {
    setState(() {
      _selectedIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final NativeItem nativeItem =
        ModalRoute.of(context)?.settings.arguments as NativeItem;

    List<Widget> widgetOptions = <Widget>[
      HomePage(webUrl: nativeItem.items?[0].uRL),
      BuyPage(
          navigateToHomePageCallback: getNavigateToHomePageCallback(),
          webUrl: nativeItem.items?[1].uRL),
      RentPage(
          navigateToHomePageCallback: getNavigateToHomePageCallback(),
          webUrl: nativeItem.items?[2].uRL),
      TripleNinePage(
          navigateToHomePageCallback: getNavigateToHomePageCallback(),
          webUrl: nativeItem.items?[3].uRL)
    ];

    double statusBarHeight = MediaQuery.of(context).padding.top;
    return PopScope(
      canPop: canPop,
      onPopInvoked: (didPos) {
        if (!_scaffoldKey.currentState!.isDrawerOpen && _selectedIndex == 0) {
          DateTime now = DateTime.now();
          if (currentBackPressTime == null ||
              now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
            currentBackPressTime = now;
            showToast(
                'Tap again to close',
                Colors.green,
                const Icon(
                  Icons.check,
                  color: Colors.white,
                ));
            setState(() {
              canPop = false;
            });
          } else {
            setState(() {
              canPop = true;
            });
          }
        }
      },
      child: Container(
        margin: EdgeInsets.only(top: statusBarHeight),
        child: Scaffold(
          key: _scaffoldKey,
          drawer: Container(
              width: MediaQuery.of(context).size.width - 74,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.zero, // Remove the corner radius
                color: Colors.white, // Set your desired background color here
              ),
              child: const Drawer()),
          body: Column(
            children: [
              Container(
                  height: 58,
                  width: double.infinity,
                  color: greyColor,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Image.asset(
                          'assets/icons/savemaxdoller.png',
                          width: 27,
                          height: 27,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          margin: EdgeInsets.only(top: 8, bottom: 8),
                          height: double.infinity,
                          color: Colors.white,
                          child: const Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 8.0, right: 8.0),
                                child: Icon(
                                  Icons.location_on,
                                  size: 17,
                                ),
                              ),
                              Text(
                                'Toronto',
                                style: TextStyle(fontSize: 13),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: const EdgeInsets.only(
                            top: 8,
                            bottom: 8,
                          ),
                          height: double.infinity,
                          color: darkGreyColor,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 10.0, right: 6.0),
                                child: Icon(Icons.close, size: 16),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 6.0, right: 10.0),
                                child: Icon(
                                  Icons.search,
                                  size: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const Expanded(
                          flex: 0,
                          child: SizedBox(
                            width: 33,
                          ))

                      // Expanded(flex: 1,child: Container())
                    ],
                  )),
              const SizedBox(
                height: 5,
              ),
              Expanded(
                child: Center(
                  child: widgetOptions.elementAt(_selectedIndex),
                ),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: nativeItem.items!.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              return BottomNavigationBarItem(
                icon: CustomBottomNavigationBarItem(
                  base64Icon: item.icon!,
                  title: item.title!,
                  isSelected: _selectedIndex == index,
                  onTap: () => _onItemTapped(index),
                ),
                label: item.title,
              );
            }).toList(),
            showUnselectedLabels: false,
            showSelectedLabels: false,
            selectedItemColor: Colors.red,
            unselectedLabelStyle: TextStyle(color: Colors.black87),
            currentIndex: _selectedIndex,
            //  onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}

class CustomBottomNavigationBarItem extends StatefulWidget {
  final String base64Icon;
  final String title;
  final bool isSelected;
  final Function onTap;

  const CustomBottomNavigationBarItem({
    Key? key,
    required this.base64Icon,
    required this.title,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  _CustomBottomNavigationBarItemState createState() =>
      _CustomBottomNavigationBarItemState();
}

class _CustomBottomNavigationBarItemState
    extends State<CustomBottomNavigationBarItem> {
  late final ImageProvider _imageProvider;

  @override
  void initState() {
    super.initState();
    final bytes = base64Decode(widget.base64Icon);
    _imageProvider = MemoryImage(bytes);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.onTap(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ImageIcon(
            _imageProvider,
            size: 24,
            color: widget.isSelected ? Colors.red : Colors.black87,
          ),
          Text(
            widget.title,
            style: TextStyle(
              color: widget.isSelected ? Colors.red : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
