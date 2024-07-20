import 'package:flutter/material.dart';
import 'package:gamet_remote_client/utils/preferences_util.dart';
import 'package:gamet_remote_client/pages/remote_parameters_page.dart';
import 'package:gamet_remote_client/pages/about_gamet.dart';
import 'package:gamet_remote_client/utils/remote_controller.dart';

class RemoteControlPage extends StatefulWidget {
  _RemoteControlState createState() => _RemoteControlState();
}

class _RemoteControlState extends State<RemoteControlPage> {

  late String remoteIp = '';
  late String remotePort = '';
  late String remoteMac = '';
  late String remoteUsername = '';
  late String remoteUserPwd = '';

  @override @override
  void initState() {
    super.initState();
    loadPreferenceParameters();
  }

  Future<void> loadPreferenceParameters() async {
    remoteIp = await PreferencesUtil().getString(PreferencesUtil.remoteCtrlIp);
    remotePort = await PreferencesUtil().getString(PreferencesUtil.remoteCtrlPort);
    remoteMac = await PreferencesUtil().getString(PreferencesUtil.remoteComMac);
    remoteUsername = await PreferencesUtil().getString(PreferencesUtil.remoteUsername);
    remoteUserPwd = await PreferencesUtil().getString(PreferencesUtil.remoteUserPwd);
    setState(() {});//触发界面重新构建
  }

  Future<void> popupValueClick(String value) async {
    if(value == 'parameter') {
      await Navigator.push(context, MaterialPageRoute(builder: (context) => RemoteParametersPage())).then((_) {
        loadPreferenceParameters(); // 当从参数页面返回时，重新加载参数
      });
    } else if(value == 'about') {
      await Navigator.push(context, MaterialPageRoute(builder: (context) => AboutGamet()));
    }
  }

  btnTypeClick(int type) {
    if(remoteIp.isEmpty || remotePort.isEmpty || remoteMac.isEmpty ||
        remoteUsername.isEmpty || remoteUserPwd.isEmpty) {
      SnackBar bar = const SnackBar(content: Text('请将各项参数输入完整'));
      ScaffoldMessenger.of(context).showSnackBar(bar);
      return;
    }
    if(type == 1) {//远程开机
      RemoteController().sendWakeOnLanSignal(remoteMac, remoteIp);
    } else if(type == 2) {//远程关机
      RemoteController().sendHttpShutdown(remoteIp, remotePort);
    } else if(type == 3) {
      RemoteController().sendIncreaseVolume(remoteIp, remotePort);
    } else if(type == 4) {
      RemoteController().sendReduceVolume(remoteIp, remotePort);
    } else if(type == 5) {
      RemoteController().sendSinglePlay(remoteIp, remotePort);
    } else if(type == 6) {
      RemoteController().sendFolderPlay(remoteIp, remotePort);
    } else if(type == 7) {
      RemoteController().sendPlayPrevious(remoteIp, remotePort);
    } else if(type == 8) {
      RemoteController().sendPlayNext(remoteIp, remotePort);
    } else if(type == 9) {
      RemoteController().sendPlayPause(remoteIp, remotePort);
    } else if(type == 10) {
      RemoteController().sendPlayResume(remoteIp, remotePort);
    } else if(type == 11) {
      RemoteController().sendPlayStop(remoteIp, remotePort);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('远程控制'),
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry> [
                const PopupMenuItem(
                  child: Text('系统参数'),
                  value: 'parameter',
                ),
                const PopupMenuItem(
                  child: Text('关于格姆特'),
                  value: 'about',
                ),
              ];
            },
            onSelected: (value) => popupValueClick(value),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('请先设置好正确的ip等信息，使用前先确认各项信息准确'),
              const SizedBox(height: 6.0),
              Text('当前远程链接IP：$remoteIp'),
              const SizedBox(height: 6.0),
              Text('当前远程链接端口：$remotePort'),
              const SizedBox(height: 6.0),
              Text('当前远程物理地址：$remoteMac'),
              const SizedBox(height: 6.0),
              Text('当前远程电脑用户：$remoteUsername'),
              const SizedBox(height: 6.0),
              Text('当前远程电脑密码：$remoteUserPwd'),
              const SizedBox(height: 6.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,// 使用flex属性来控制空白区域的大小
                    child: Container(),
                  ),
                  ElevatedButton(
                    onPressed: ()=> btnTypeClick(1),
                    child: const Text('远程开机'),
                  ),
                  const SizedBox(width: 30),
                  ElevatedButton(
                    onPressed: ()=> btnTypeClick(2),
                    child: const Text('远程关机'),
                  ),
                  Expanded(
                    flex: 1,// 使用flex属性来控制空白区域的大小
                    child: Container(),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,// 使用flex属性来控制空白区域的大小
                    child: Container(),
                  ),
                  ElevatedButton(
                    onPressed: ()=> btnTypeClick(3),
                    child: const Text('增加音量'),
                  ),
                  const SizedBox(width: 30),
                  ElevatedButton(
                    onPressed: ()=> btnTypeClick(4),
                    child: const Text('减小音量'),
                  ),
                  Expanded(
                    flex: 1,// 使用flex属性来控制空白区域的大小
                    child: Container(),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,// 使用flex属性来控制空白区域的大小
                    child: Container(),
                  ),
                  ElevatedButton(
                    onPressed: ()=> btnTypeClick(5),
                    child: const Text('单播视频'),
                  ),
                  const SizedBox(width: 30),
                  ElevatedButton(
                    onPressed: ()=> btnTypeClick(6),
                    child: const Text('播放文件夹'),
                  ),
                  Expanded(
                    flex: 1,// 使用flex属性来控制空白区域的大小
                    child: Container(),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,// 使用flex属性来控制空白区域的大小
                    child: Container(),
                  ),
                  ElevatedButton(
                    onPressed: ()=> btnTypeClick(7),
                    child: const Text('上个视频'),
                  ),
                  const SizedBox(width: 30),
                  ElevatedButton(
                    onPressed: ()=> btnTypeClick(8),
                    child: const Text('下个视频'),
                  ),
                  Expanded(
                    flex: 1,// 使用flex属性来控制空白区域的大小
                    child: Container(),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,// 使用flex属性来控制空白区域的大小
                    child: Container(),
                  ),
                  ElevatedButton(
                    onPressed: ()=> btnTypeClick(9),
                    child: const Text('暂停'),
                  ),
                  const SizedBox(width: 15),
                  ElevatedButton(
                    onPressed: ()=> btnTypeClick(10),
                    child: const Text('继续'),
                  ),
                  const SizedBox(width: 15),
                  ElevatedButton(
                    onPressed: ()=> btnTypeClick(11),
                    child: const Text('停止'),
                  ),
                  Expanded(
                    flex: 1,// 使用flex属性来控制空白区域的大小
                    child: Container(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}