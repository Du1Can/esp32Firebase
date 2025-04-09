import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Web extends StatefulWidget {
  const Web({super.key});

  @override
  State<Web> createState() => _WebState();
}

class _WebState extends State<Web> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.transparent)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) => debugPrint('Cargando: $url'),
          onPageFinished: (url) => debugPrint('Página cargada: $url'),
          onWebResourceError: (error) => debugPrint('Error: ${error.description}'),
        ),
      )
      ..loadRequest(Uri.parse('https://weather.com'));
    //TODO https://www.megnasa.com/home
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Verificar el clima')),
      body: WebViewWidget(controller: _controller),
    );
  }
}