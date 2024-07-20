import 'package:flutter/material.dart';
import 'package:gamet_remote_client/pages/login_page.dart';

class WelcomePage extends StatefulWidget {
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<WelcomePage> {

  @override void initState() {
    super.initState();
    _navigatePages();
  }

  void _navigatePages() async {
    await Future.delayed(const Duration(seconds: 2));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    double fontSize = 12 * MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Container()),
          SizedBox(
            width: 240,
            height: 160,
            child: Image.asset(
              'assets/images/logo_gmt.webp',
              fit: BoxFit.contain,//保持图片原始比例
            ),
          ),
          Expanded(child: Container()),
          // 页面底部居中显示文字
          Center(
            child: Text(
              '格姆特科技有限公司',
              style: TextStyle(fontSize: fontSize),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }

}

extension SpFontSize on double {
  double get sp => this; // 现在仅返回double值本身，转换将在使用时进行
}