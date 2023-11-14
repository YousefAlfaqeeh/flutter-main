import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/modules/cubit/cubit.dart';
import 'package:udemy_flutter/modules/cubit/states.dart';
import 'package:udemy_flutter/modules/studet_details/detail.dart';
import 'package:udemy_flutter/modules/studet_details/new_detail.dart';
import 'package:udemy_flutter/shared/components/dialog.dart';
import 'package:udemy_flutter/shared/local/cache_helper.dart';
import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';
import 'dart:convert';

class WebView_Login extends StatefulWidget {
  String url;

  WebView_Login(this.url);

  @override
  State<WebView_Login> createState() => _WebView_LoginState();
}
JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
  return JavascriptChannel(
      name: 'Toaster',
      onMessageReceived: (JavascriptMessage message) {
        // ignore: deprecated_member_use
        // Scaffold.of(context).showSnackBar(
        //   SnackBar(content: Text(message.message)),
        // );
      });
}
class _WebView_LoginState extends State<WebView_Login> {
  Completer<WebViewController> _completer = Completer<WebViewController>();
  String url_2 = '';

  int count = 0;
  Future<void> _launchInBrowser(String u) async {
    final Uri url = Uri.parse(u);
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
      webViewConfiguration: const WebViewConfiguration(
          headers: <String, String>{'my_header_key': 'my_header_value'}),

    )) {
      throw 'Could not launch $url';
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    url_2 = widget.url;
    if(Platform.isAndroid) WebView.platform=AndroidWebView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AppCubit(),
        child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                  leading: IconButton(
                    onPressed: () {
// log('AppCubit.url_3');
                      if(AppCubit.url=='login')
                        {

                      Navigator.pop(context);
                        }
                      else if(AppCubit.url_3==AppCubit.url)
                        {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => New_Detail(),
                              ));
                        }
                      else
                        {
                          Navigator.pop(context);
                          // print('-------------------------------');
                          // print(AppCubit.url_3.isNotEmpty);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WebView_Login(AppCubit.url_3),
                              ));
                          // AppCubit.get(context).setUrl('');

                        }
                    },
                    icon: Container(
                        width: 30,
                        height: 30,
                        padding: EdgeInsetsDirectional.only(end: 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: Icon(size: 20, Icons.keyboard_arrow_left)),
                  ),

                  ),
              body:Builder(builder: (context) {
                return  WebView(
                  initialUrl: widget.url,
                  javascriptMode: JavascriptMode.unrestricted,
                  initialCookies: [],

                  onWebViewCreated: (controller) {
                    _completer.complete(controller);

                    controller.loadUrl(widget.url, headers: {
                      "X-Openerp-Session-Id":
                      CacheHelper.getBoolean(key: 'sessionId')
                    });
                  },
                  gestureNavigationEnabled: true,
                  javascriptChannels: <JavascriptChannel>{
                    _toasterJavascriptChannel(context),
                  },
                  onPageStarted: (url) async {
                    // print("-------------------------");
                    // print( CacheHelper.getBoolean(key: 'sessionId'));
                    // print("-------------------------");
                    if (Platform.isAndroid) {

                      if(url.contains("login"))
                      {

                        Navigator.pop(context);

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WebView_Login(url),
                            ));
                      }
                      else
                      {
                        AppCubit.get(context).setUrl1(url);
                        // print(AppCubit.url_3==AppCubit.url);
                      }

                    }
                    else {
                      if (AppCubit.url != url) {

                        AppCubit.get(context).setUrl1(url);
                        showDialog(context: context, builder: (context) {
                          return Center( child: CircularProgressIndicator(),);
                        },);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WebView_Login(url),
                            ));

                      }


                    }
                  },
                  onPageFinished: (url) {

                  },
                );
              },)
            );
          },
        )

        );
  }
}



class WebView_Login1 extends StatefulWidget {
  String url;

  WebView_Login1(this.url);

  @override
  State<WebView_Login1> createState() => _WebView_LoginState1();
}

class _WebView_LoginState1 extends State<WebView_Login1> {
  Completer<WebViewController> _completer = Completer<WebViewController>();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AppCubit(),
        child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(),
              body: WebView(
                initialUrl: widget.url,
                javascriptMode: JavascriptMode.unrestricted,
                initialCookies: [],
                onWebViewCreated: (controller) {
                  _completer.complete(controller);

                  controller.loadUrl(widget.url);
                },
                gestureNavigationEnabled: true,
              ),
            );
          },
        )

    );
  }
}