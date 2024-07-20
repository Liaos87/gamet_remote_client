import 'package:flutter/material.dart';
import 'package:gamet_remote_client/utils/preferences_util.dart';

class RemoteParametersPage extends StatefulWidget {
  _RemoteParameterState createState() => _RemoteParameterState();
}

class _RemoteParameterState extends State<RemoteParametersPage> {

  final TextEditingController ipController = TextEditingController();
  final TextEditingController portController = TextEditingController();
  final TextEditingController macController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController pwdController = TextEditingController();

  @override void initState() {
    super.initState();
    loadPreferenceParameters();
  }

  Future<void> loadPreferenceParameters() async {
    String remoteIp = await PreferencesUtil().getString(PreferencesUtil.remoteCtrlIp);
    String remotePort = await PreferencesUtil().getString(PreferencesUtil.remoteCtrlPort);
    String remoteMac = await PreferencesUtil().getString(PreferencesUtil.remoteComMac);
    String remoteUsername = await PreferencesUtil().getString(PreferencesUtil.remoteUsername);
    String remoteUserPwd = await PreferencesUtil().getString(PreferencesUtil.remoteUserPwd);
    ipController.text = remoteIp;
    portController.text = remotePort;
    macController.text = remoteMac;
    nameController.text = remoteUsername;
    pwdController.text = remoteUserPwd;
  }

  Future<void> _clickSaveParameters() async {
    String sIp = ipController.text.trim();
    String sPort = portController.text.trim();
    String sMac = macController.text.trim();
    String sName = nameController.text.trim();
    String sPwd = pwdController.text.trim();
    if(sIp.isNotEmpty && sPort.isNotEmpty && sMac.isNotEmpty && sName.isNotEmpty && sPwd.isNotEmpty) {
      PreferencesUtil().saveString(PreferencesUtil.remoteCtrlIp, sIp);
      PreferencesUtil().saveString(PreferencesUtil.remoteCtrlPort, sPort);
      PreferencesUtil().saveString(PreferencesUtil.remoteComMac, sMac);
      PreferencesUtil().saveString(PreferencesUtil.remoteUsername, sName);
      PreferencesUtil().saveString(PreferencesUtil.remoteUserPwd, sPwd);
      Navigator.pop(context);
    } else {
      SnackBar bar = const SnackBar(content: Text('请将各项参数输入完整'));
      ScaffoldMessenger.of(context).showSnackBar(bar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('远程控制'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: ipController,
                decoration: const InputDecoration(
                  hintText: '输入远程电脑IP',
                  labelText: '远程电脑IP',
                ),
              ),
              const SizedBox(height: 12.0),
              TextField(
                controller: portController,
                decoration: const InputDecoration(
                  hintText: '输入远程电脑Port',
                  labelText: '远程电脑Port',
                ),
              ),
              const SizedBox(height: 12.0),
              TextField(
                controller: macController,
                decoration: const InputDecoration(
                  hintText: '输入远程电脑Mac',
                  labelText: '远程电脑Mac',
                ),
              ),
              const SizedBox(height: 12.0),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: '输入远程电脑用户名',
                  labelText: '远程电脑用户名',
                ),
              ),
              const SizedBox(height: 12.0),
              TextField(
                controller: pwdController,
                decoration: const InputDecoration(
                  hintText: '输入远程电脑用户密码',
                  labelText: '远程电脑用户密码',
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(onPressed: _clickSaveParameters, child: const Text('保存')),
            ],
          ),
        ),
      ),
    );
  }
}