import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intergez_webview/Views/HomePage/View/home_page_view.dart';
import 'package:intergez_webview/Views/NoNetwork/View/no_network.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({Key? key}) : super(key: key);

  @override
  _SplashScreenViewState createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {

  Map _source = {ConnectivityResult.none: false};
  final MyConnectivity _connectivity = MyConnectivity.instance;


  @override
  void initState() {
    super.initState();
    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      setState(() => _source = source);
    });
  }


  @override
  Widget build(BuildContext context) {
    print(_source.keys.toList()[0]);

    switch (_source.keys.toList()[0]) {
      case ConnectivityResult.mobile:
        return buildFuture();
      case ConnectivityResult.wifi:
        return buildFuture();
      case ConnectivityResult.none:
        return FutureBuilder<bool>(
          future: _noneFuture(),
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              return NoNetworkView();
            }else{
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 1,
                  ),
                ),
              );
            }
          }
        );
      default:
        return buildSplash(context);
    }
  }

  Widget buildFuture() {
    return Scaffold(
    backgroundColor: Color(0xffB03242),
    body: FutureBuilder<bool>(
      future: hasNetwork(),
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          bool? hasNetwork = snapshot.data;

          if(hasNetwork == null){
            return NoNetworkView();
          }else {
            if (hasNetwork == true) {
              return HomePageView();
            } else {
              return NoNetworkView();
            }
          }
        }else{
          return buildSplash(context);
        }
      }
    ),
  );
  }

  Widget buildSplash(BuildContext context) {
    return Scaffold(
      body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 150,
                        height: 130,
                        child: Image.asset(
                          "assets/img/ig_logo.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: 80),

                      Container(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 1,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),

                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        bottom: 30
                    ),
                    child: Container(
                      width: 160,
                      height: 50,
                      child: Image.asset(
                        "assets/img/intergez_logo.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
    );
  }

  Future<bool> hasNetwork() async {
    try {
      await Future.delayed(Duration(seconds: 2));
      final result = await InternetAddress.lookup('intergez.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  Future<bool> _noneFuture() async{
    await Future.delayed(Duration(seconds: 2));
    return true;
  }
}



class MyConnectivity {
  MyConnectivity._();

  static final _instance = MyConnectivity._();
  static MyConnectivity get instance => _instance;
  final _connectivity = Connectivity();
  final _controller = StreamController.broadcast();
  Stream get myStream => _controller.stream;

  void initialise() async {
    ConnectivityResult result = await _connectivity.checkConnectivity();
    _checkStatus(result);
    _connectivity.onConnectivityChanged.listen((result) {
      _checkStatus(result);
    });
  }

  void _checkStatus(ConnectivityResult result) async {
    bool isOnline = false;
    try {
      final result = await InternetAddress.lookup('intergez.com');
      isOnline = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      isOnline = false;
    }
    _controller.sink.add({result: isOnline});
  }

  void disposeStream() => _controller.close();
}