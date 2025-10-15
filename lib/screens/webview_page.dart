import 'package:app1/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key, required this.title, required this.url});

  final String title;
  final String url;

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late final WebViewController _controller;
  bool _isLoading = true;
  Brightness? _lastBrightness;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.transparent)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (_) {
            setState(() => _isLoading = false);
            _applyColorScheme();
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final brightness = Theme.of(context).brightness;
    if (brightness != _lastBrightness) {
      _lastBrightness = brightness;
      if (!_isLoading) {
        _applyColorScheme();
      }
    }
  }

  void _applyColorScheme() {
    final brightness = _lastBrightness ?? Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;
    final cssScheme = isDark ? 'dark' : 'light';
    final bgColor = isDark ? '#0E1629' : '#E7ECFF';
    _controller.runJavaScript(
      "document.documentElement.style.colorScheme='$cssScheme';"
      "document.body.style.background='$bgColor';",
    );
  }

  @override
  Widget build(BuildContext context) {
    final background = Theme.of(context).scaffoldBackgroundColor;
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Container(
        color: background,
        child: Stack(
          children: [
            WebViewWidget(controller: _controller),
            if (_isLoading)
              Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              ),
          ],
        ),
      ),
    );
  }
}
