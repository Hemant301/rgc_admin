import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AdminOfRgc extends StatefulWidget {
  const AdminOfRgc({Key? key}) : super(key: key);

  @override
  AdminOfRgcState createState() => AdminOfRgcState();
}

class AdminOfRgcState extends State<AdminOfRgc> {
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: const Text(""),
        title: const Text(
          'Gest Approval Panel',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Stack(
        children: <Widget>[
          WebView(
            initialUrl:
                "https://cms.cybertize.in/rgc/admin/php/guest/index.php",
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: (finish) {
              setState(() {
                isLoading = false;
              });
            },
          ),
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Stack(),
        ],
      ),

      //  WebView(
      //   initialUrl: "https://www.ranchigymkhanaclub.com/membership-payment/",
      //   javascriptMode: JavascriptMode.unrestricted,
      //     onPageFinished: (finish) {
      //       setState(() {
      //         isLoading = false;
      //       });
      //     },
      // ),   isLoading ? Center( child: CircularProgressIndicator(),):
    );
  }
}
