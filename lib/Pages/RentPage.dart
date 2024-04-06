import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../Controller/LoadUrlController.dart';
import '../Network/Internet.dart';
import '../Utils/constants.dart';
import 'NoInternetConnectionPage.dart';

class RentPage extends StatefulWidget {
  final void Function() navigateToHomePageCallback;

  const RentPage({Key? key, required this.navigateToHomePageCallback, required this.webUrl})
      : super(key: key);

  final String? webUrl;


  @override
  State<RentPage> createState() => _RentPageState();
}

class _RentPageState extends State<RentPage> {
  late final WebViewController _controller;
  bool canPop = false;

  @override
  void initState() {
    super.initState();
    WebViewController controller = WebViewController();
    _controller = LoadUrlController(controller,  widget.webUrl! , context);
    //_controller = LoadUrlController(controller, '${BaseUrl}/rent/toronto-real-estate', context);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop,
      onPopInvoked: (didPos) async {
        if (await _controller.canGoBack()) {
          await _controller.goBack();
        } else {
          if (context.mounted) {
            setState(() {
              canPop = true;
            });
          }
        }
      },
      child: Scaffold(
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return FutureBuilder<bool>(
      future: checkInternetConnectivity(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            if (snapshot.data == true) {
              return WebViewWidget(controller: _controller);
            } else {
              return NoInternetConnectionPage(tryAgain: _recheckInternet);
            }
          }
        }
      },
    );
  }

  void _recheckInternet() {
    _controller.reload();
    Future.delayed(Duration(milliseconds: 700), () {
      setState(() {
        _buildBody();
      });
    });
  }
}
