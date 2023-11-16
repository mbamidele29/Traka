import 'package:flutter/material.dart';
import 'package:traka/core/config/startup.dart';
import 'package:traka/core/route/navigation_service.dart';
import 'package:traka/core/utils/colors.dart';
import 'package:traka/core/widgets/appbar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InAppWebScreen extends StatefulWidget {
  final String url;
  final String? redirectUrl;

  const InAppWebScreen({Key? key, required this.url, this.redirectUrl})
      : super(key: key);

  @override
  State<InAppWebScreen> createState() => _InAppWebScreenState();
}

class _InAppWebScreenState extends State<InAppWebScreen> {
  double progress = 0;

  late WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            setState(() {
              this.progress = progress / 100;
            });
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            print('QWERTY: ${request.url}');
            if (request.url.contains("error=")) {
              Navigator.of(context).pop(
                Exception(Uri.parse(request.url).queryParameters["error"]),
              );
            } else if (request.url
                .toLowerCase()
                .startsWith((widget.redirectUrl ?? '').toLowerCase())) {
              locator<NavigationService>()
                  .popWithData({'redirectUrl': request.url});
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
        Uri.parse(widget.url.toLowerCase().startsWith('https')
            ? widget.url
            : widget.url.toLowerCase().replaceFirst("http:", 'https:')),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: UniqueKey(),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const TrakaAppBar(),
      body: Column(
        children: [
          progress < 1.0
              ? LinearProgressIndicator(
                  value: progress, color: AppColor.primary)
              : const SizedBox(),
          Expanded(
            child: WebViewWidget(controller: _webViewController),
          ),
        ],
      ),
    );
  }
}
