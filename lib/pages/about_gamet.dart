import 'package:flutter/material.dart';

class AboutGamet extends StatelessWidget {

  final List<String> _pathList = [
    'assets/images/intro_page1.webp',
    'assets/images/intro_page4.webp',
    'assets/images/intro_page5.webp',
    'assets/images/intro_page7.webp',
    'assets/images/intro_page14.webp',
    'assets/images/intro_page15.webp',
    'assets/images/intro_page18.webp',
    'assets/images/intro_page19.webp',
    'assets/images/intro_page20.webp',
    'assets/images/intro_page21.webp',
    'assets/images/intro_page26.webp',
    'assets/images/intro_page27.webp',
    'assets/images/intro_page36.webp',
    'assets/images/intro_page37.webp',
    'assets/images/intro_page38.webp',
    'assets/images/intro_page39.webp',
    'assets/images/intro_page43.webp',
    'assets/images/intro_page44.webp',
    'assets/images/intro_page49.webp',
    'assets/images/intro_page50.webp',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('关于格姆特', style: TextStyle(fontSize: 16),),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // 当按钮被点击时，使用Navigator.pop返回到上一个页面
            Navigator.pop(context);
          },
        ),
        //automaticallyImplyLeading: true, // 开启自动返回按钮
      ),
      body: ListView.builder(
          itemCount: _pathList.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                  _pathList[index],
                  fit: BoxFit.cover
              ),
            );
          }
      ),
    );
  }

}