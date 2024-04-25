import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../common/config/config.dart';
import '../../common/routes/app_router.dart';
import '../../data/local/authorization_local.dart';
import '../../domain/usecase/authorization/login_usecase.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
  }

  void _onLogin(String authorizationUrl) async {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith(Config.redirectUrl)) {
              final token = Uri.parse(request.url).fragment.replaceAll('access_token=', '');
              GetIt.instance.get<AuthorizationLocal>().saveToken(token);
              context.goNamed(ScreenPaths.playlist);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(authorizationUrl.replaceAll('response_type=code', 'response_type=token')));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Result<String>>(
        future: GetIt.I<LoginUseCase>().call(null),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData == true) {
            _onLogin(snapshot.data!.asValue!.value);
            return WebViewWidget(controller: controller);
          }

          return const Center(child: Text('Error'));
        });
  }
}
