import 'dart:io';
import 'dart:ui';

import 'package:blur/blur.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:intergez_webview/Views/HomePage/ViewModel/home_page_viewmodel.dart';
import 'package:intergez_webview/Widgets/Bounce/bounce.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  HomePageViewModel _viewModel = HomePageViewModel();

  final GlobalKey webViewKey = GlobalKey();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
        supportZoom: false,
        disableContextMenu: true,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  late PullToRefreshController pullToRefreshController;

  @override
  void initState() {
    super.initState();

    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Color(0xffB03242),
        backgroundColor: Colors.grey.shade900,
        size: AndroidPullToRefreshSize.DEFAULT,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        if(webViewController != null) {
          if (await webViewController!.canGoBack()) {
            await webViewController!.goBack();
          }

          return false;
        }else{
          return true;
        }
      },
      child: SafeArea(
        child: Scaffold(
          key: scaffoldKey,
          resizeToAvoidBottomInset: false,
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: buildFAB(),
          bottomNavigationBar: buildBottomAppBar(),
          endDrawer: buildEndDrawer(),
          body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  InAppWebView(
                    key: webViewKey,
                    initialUrlRequest: URLRequest(url: Uri.parse("https://www.intergez.com/")),
                    initialOptions: options,
                    pullToRefreshController: pullToRefreshController,
                    onWebViewCreated: (controller) {
                      webViewController = controller;
                    },
                    onLoadStart: (controller, url) async {
                      if (url == null) {
                        url = Uri.parse("https://www.intergez.com/");
                      }
                      _viewModel.setUrl(url.toString());


                      if(url.host.contains("intergez.com")){

                      }else{
                        showModalBottomSheet(
                            context: context,
                            elevation: 5,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) {
                              return StatefulBuilder(
                                builder: (context, setState) {
                                  return Padding(
                                    padding: MediaQuery.of(context).viewInsets,
                                    child: Container(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(height: 20),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Container(),
                                              ),
                                              Expanded(
                                                  child: Container(
                                                    height: 5,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(30),
                                                        color: Colors.grey.shade500),
                                                  )),
                                              Expanded(
                                                child: Container(),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 20),
                                          Text(
                                            "Intergez'den Ayrılıyorsunuz",
                                            style: TextStyle(
                                                fontSize: 22,
                                                color: Colors.grey.shade400,
                                                fontWeight: FontWeight.w600
                                            ),
                                          ),
                                          SizedBox(height: 20),
                                          Container(
                                            width: MediaQuery.of(context).size.width,
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 10),
                                              child: Text(
                                                "Bağlantı",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.grey.shade300,
                                                    fontWeight: FontWeight.w400,
                                                    decoration: TextDecoration.underline
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Container(
                                            width: MediaQuery.of(context).size.width,
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 14),
                                              child: Text(
                                                "${url.toString()}",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey.shade600,
                                                    fontWeight: FontWeight.w200
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          ListTile(
                                            title: Text(
                                              "Tarayıcıda Görüntüle",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey.shade200,
                                                  fontWeight: FontWeight.w400
                                              ),
                                            ),
                                            onTap: (){
                                              _launchURL(url.toString());
                                            },
                                            leading: Icon(
                                              Foundation.web,
                                              color: Colors.pinkAccent,
                                            ),
                                          ),
                                          ListTile(
                                            title: Text(
                                              "Bağlantı Adresini Kopyala",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey.shade200,
                                                  fontWeight: FontWeight.w400
                                              ),
                                            ),
                                            onTap: (){
                                              Clipboard.setData(
                                                new ClipboardData(text: "$url"),
                                              );
                                              Navigator.pop(context);
                                              SnackBar snackBar = SnackBar(
                                                content: Text("Kopyalandı"),
                                              );
                                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                            },
                                            leading: Icon(
                                              Entypo.copy,
                                              color: Colors.amber,
                                            ),
                                          ),
                                          ListTile(
                                            title: Text(
                                              "Vazgeç",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey.shade200,
                                                  fontWeight: FontWeight.w400
                                              ),
                                            ),
                                            onTap: (){
                                              Navigator.pop(context);
                                            },
                                            leading: Icon(
                                              CupertinoIcons.back,
                                              color: Colors.redAccent,
                                            ),
                                          ),
                                          SizedBox(height: 20),
                                        ],
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade900,
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(32),
                                          topLeft: Radius.circular(32),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            });
                        await webViewController!.goBack();
                      }

                    },
                    androidOnPermissionRequest: (controller, origin, resources) async {
                      return PermissionRequestResponse(
                          resources: resources, action: PermissionRequestResponseAction.GRANT);
                    },
                    shouldOverrideUrlLoading: (controller, navigationAction) async {
                      var uri = navigationAction.request.url!;

                      if (!["http", "https", "file", "chrome", "data", "javascript", "about"].contains(uri.scheme)) {
                        if (await canLaunch(_viewModel.url)) {
                          // Launch the App
                          await launch(
                            _viewModel.url,
                          );
                          // and cancel the request
                          return NavigationActionPolicy.CANCEL;
                        }
                      }

                      return NavigationActionPolicy.ALLOW;
                    },
                    onLoadStop: (controller, url) async {
                      pullToRefreshController.endRefreshing();

                      if (url == null) {
                        url = Uri.parse("https://www.intergez.com/");
                      }
                      _viewModel.setUrl(url.toString());
                    },
                    onLoadError: (controller, url, code, message) {
                      pullToRefreshController.endRefreshing();
                    },
                    onProgressChanged: (controller, progress) {
                      if (progress == 100) {
                        pullToRefreshController.endRefreshing();
                      }
                      _viewModel.setProgress(progress / 100);
                    },
                    onUpdateVisitedHistory: (controller, url, androidIsReload) {
                      if (url == null) {
                        url = Uri.parse("https://www.intergez.com/");
                      }
                      _viewModel.setUrl(url.toString());
                    },
                    onConsoleMessage: (controller, consoleMessage) {
                      print(consoleMessage);
                    },
                  ),
                  //SearchPanel Blur
                  Observer(
                    builder: (_) => Positioned.fill(
                      child: Visibility(
                        visible: _viewModel.searchPanelShow,
                        child: GestureDetector(
                          onTapDown: (_)=>_viewModel.setSearchPanelShow(!_viewModel.searchPanelShow),
                          child: Blur(
                            blur: 3,
                            blurColor: Colors.grey.shade900,
                            child: Container(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  //SearchPanel
                  Observer(
                    builder: (_) => Positioned(
                      top: 54,
                      right: 0,
                      left: 0,
                      child: Visibility(
                        visible: _viewModel.searchPanelShow,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(width: 10),
                                    Text(
                                      "Arama Yap",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600
                                      ),
                                    ),
                                    Spacer(),
                                    IconButton(
                                        onPressed: ()=>_viewModel.setSearchPanelShow(!_viewModel.searchPanelShow),
                                        icon: Icon(Entypo.squared_cross,color: Color(0xffB03242),),
                                    ),
                                    SizedBox(width: 10),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    autofocus: true,
                                    textInputAction: TextInputAction.search,
                                    onFieldSubmitted: (value) async{
                                      _viewModel.setSearchPanelShow(!_viewModel.searchPanelShow);
                                      webViewController!.loadUrl(
                                          urlRequest: URLRequest(url: Uri.parse("https://www.intergez.com/?s=$value")),
                                      );
                                    },
                                    decoration: InputDecoration(
                                        hintText: "Arama Yap...",
                                        hintStyle: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey.shade800
                                        ),
                                        prefixIcon: Icon(
                                          Icons.search,
                                          size: 20,
                                          color: Colors.grey.shade700,
                                        ),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xffB03242)
                                            )
                                        ),
                                        disabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xffB03242)
                                            )
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xffB03242)
                                            )
                                        ),
                                        errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xffB03242)
                                            )
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xffB03242)
                                            )
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xffB03242)
                                            )
                                        )
                                    ),
                                  ),
                                )
                              ],
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(4),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade900,
                                  offset: Offset(2, 6), //(x,y)
                                  blurRadius: 3,
                                ),
                              ],
                            ),
                          )
                        ),
                      ),
                    ),
                  ),
                  // Loadin Page Indicator
                  Observer(
                      builder: (_)=>Visibility(
                    visible: _viewModel.progress<0.2,
                    child: Positioned.fill(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        color: Colors.white,
                        child: Center(
                          child: CupertinoActivityIndicator(),
                        ),
                      ),
                      ),
                    ),
                  ),
                  // Progress Indicator
                  Observer(
                    builder: (_) => Positioned(
                      top: 0,
                      child: Visibility(
                          visible: _viewModel.progress < 1.0,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 4,
                            child: LinearProgressIndicator(
                              value: _viewModel.progress,
                              valueColor: AlwaysStoppedAnimation<Color>(Color(0xffB03242).withOpacity(0.8)),
                              backgroundColor: Colors.grey.shade700,
                            ),
                          )),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  Widget buildEndDrawer() {
    return Drawer(
      child: Container(
        child: ListView(
          children: [
            Container(
              width: 160,
              height: 200,
              color: Color(0xffB03242),
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/img/drawer_logo.png"),
                          fit: BoxFit.contain
                      )
                  ),
                ),
              ),
            ),
            ListTile(
              onTap: () async {
                if(webViewController == null) return;
                await webViewController!.loadUrl(
                    urlRequest: URLRequest(url: Uri.parse("https://www.intergez.com/"))
                );
                Navigator.pop(context);
              },
              title: Text(
                "Ana Sayfa",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade200,
                    fontWeight: FontWeight.w400
                ),
              ),
              leading: Icon(
                AntDesign.home,
                color: Colors.white,
              ),
            ),
            ListTile(
              onTap: ()async{
                if(webViewController == null) return;
                await webViewController!.loadUrl(
                    urlRequest: URLRequest(url: Uri.parse("https://www.intergez.com/hakkimizda"))
                );
                Navigator.pop(context);
              },
              title: Text(
                "Hakkımızda",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade200,
                    fontWeight: FontWeight.w400
                ),
              ),
              leading: Icon(
                CupertinoIcons.info,
                color: Colors.white,
              ),
            ),
            ListTile(
              onTap: ()async{
                if(webViewController == null) return;
                await webViewController!.loadUrl(
                    urlRequest: URLRequest(url: Uri.parse("https://www.intergez.com/iletisim"))
                );
                Navigator.pop(context);
              },
              title: Text(
                "İletişim",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade200,
                    fontWeight: FontWeight.w400
                ),
              ),
              leading: Icon(
                Icons.call,
                color: Colors.white,
              ),
            ),
            Divider(
              color: Colors.grey.shade800,
            ),
            // Facebook
            ListTile(
              onTap: (){
                _launchURL("https://www.facebook.com/intergezcom");
              },
              title: Text(
                "Facebook",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade200,
                    fontWeight: FontWeight.w400
                ),
              ),
              leading: Icon(
                Feather.facebook,
                color: Color(0xff3b5998),
              ),
            ),
            // Twitter
            ListTile(
              onTap: (){
                _launchURL("https://twitter.com/intergezcom");
              },
              title: Text(
                "Twitter",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade200,
                    fontWeight: FontWeight.w400
                ),
              ),
              leading: Icon(
                Feather.twitter,
                color: Color(0xff1DA1F2),
              ),
            ),
            // Instagram
            ListTile(
              onTap: (){
                _launchURL("https://www.instagram.com/intergezcom/");
              },
              title: Text(
                "Instagram",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade200,
                    fontWeight: FontWeight.w400
                ),
              ),
              leading: Icon(
                Feather.instagram,
                color: Color(0xffC13584),
              ),
            ),
            // Youtube
            ListTile(
              onTap: (){
                _launchURL("https://www.youtube.com/channel/UCT0-y0be36W85pOJnGWX7Fw");
              },
              title: Text(
                "Youtube",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade200,
                    fontWeight: FontWeight.w400
                ),
              ),
              leading: Icon(
                Feather.youtube,
                color: Colors.red,
              ),
            ),

            Divider(
              color: Colors.grey.shade800,
            ),

            ListTile(
              onTap: (){
                _launchURL("mailto:iletisim@intergez.com");
              },
              title: Text(
                "Bize Ulaşın",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey
                ),
              ),
              subtitle: Text(
                "iletisim@intergez.com",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: Colors.orangeAccent
                ),
              ),
            )

          ],
        ),
      ),
    );
  }

  Widget buildFAB() {
    return FloatingActionButton(
          onPressed: () {
            _viewModel.setSearchPanelShow(!_viewModel.searchPanelShow);
          },
          child: Icon(
            Ionicons.ios_search,
            color: Colors.white,
          ),
          backgroundColor: Color(0xffd14f60), //Color(0xffB03242),
        );
  }

  Widget buildBottomAppBar() {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 6,
      color: Color(0xffB03242),
      child: Container(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Bounce(
              onPressed: () {
                if (webViewController != null) {
                  _viewModel.setSearchPanelShow(false);
                  webViewController!.loadUrl(urlRequest: URLRequest(url: Uri.parse("https://www.intergez.com/")));
                }
              },
              child: Container(
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Row(
                    children: [
                      Icon(
                        Ionicons.md_home_outline,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Ana Sayfa",
                        style: TextStyle(color: Colors.grey.shade200, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Bounce(
              onPressed: () {
                _viewModel.setSearchPanelShow(false);
                if(scaffoldKey.currentState != null) {
                  scaffoldKey.currentState!.openEndDrawer();
                }
              },
              child: Container(
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Row(
                    children: [
                      Icon(
                        AntDesign.contacts,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Bize Ulaşın",
                        style: TextStyle(color: Colors.grey.shade200, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

}
