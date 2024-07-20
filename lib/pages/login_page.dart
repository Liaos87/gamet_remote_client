import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:gamet_remote_client/utils/permissions_util.dart';
import 'package:gamet_remote_client/pages/remote_control_page.dart';

class LoginPage extends StatefulWidget {
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _userLoginClick() async {
    String username = _nameController.text.trim();
    String password = _passwordController.text.trim();
    if(username.isNotEmpty && password.isNotEmpty) {
      bool isStorageGrant = await PermissionsUtil().checkStoragePermission();
      if(isStorageGrant) {
        checkUserLogin(username, password);
      } else {
        //申请存储权限
        final status = await Permission.storage.request();
        if (status.isGranted) {
          // 权限被授予
          //print('Storage permission granted');
          checkUserLogin(username, password);
        } else if (status.isPermanentlyDenied) {
          // 用户永久拒绝了权限，需要引导用户去设置页面手动开启
          openAppSettings();
        } else if (status.isDenied) {
          // 权限被拒绝，但不是永久拒绝，可以再次请求
          //print('Storage permission denied');
        }
      }
    } else {
      SnackBar bar = const SnackBar(content: Text('用户名和密码不能为空'));
      ScaffoldMessenger.of(context).showSnackBar(bar);
    }
  }

  void checkUserLogin(String username, String password) {
    //后续可添加用户名和密码准确性的判断
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RemoteControlPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  hintText: '用户名',
                  labelText: '用户名',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _passwordController,
                obscureText: true, // 隐藏密码
                decoration: const InputDecoration(
                  hintText: '密码',
                  labelText: '密码',
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(onPressed: _userLoginClick, child: const Text('登录')),
            ],
          ),
        ),
      ),
    );
  }
}