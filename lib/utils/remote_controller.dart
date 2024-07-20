import 'dart:convert';
import 'dart:io';
import 'package:gamet_remote_client/utils/http_handler_util.dart';
/**
 * 单例远程控制类，发送各项指令到服务端
 * */
class RemoteController {

  static final RemoteController _instance = RemoteController._internal();

  factory RemoteController() => _instance;

  RemoteController._internal();

  //发送windows开机指令
  Future<void> sendWakeOnLanSignal(String macAddress, String broadcastIp) async {
    if (macAddress.length != 17) {
      throw FormatException("MAC address should be set as form 'XX-XX-XX-XX-XX-XX'");
    }
    final String macNoDashes = macAddress.replaceAll('-', '');
    final String data = List.generate(20, (_) => 'FFFFFFFFFFFF').join() + (macNoDashes * 20);
    final List<int> sendBytes = _hexStringToBytes(data);
    try {
      final RawDatagramSocket socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 0);
      for (var i = 0; i < 6; i++) {
        socket.send(sendBytes, InternetAddress(broadcastIp), 9);
        await Future.delayed(const Duration(seconds: 1)); // Non-blocking wait
      }
    } on SocketException catch (e) {
      print(e);
    }
  }

  List<int> _hexStringToBytes(String hexString) {
    return Iterable.generate(hexString.length ~/ 2, (index) {
      final start = index * 2;
      final end = start + 2;
      return int.parse(hexString.substring(start, end), radix: 16);
    }).toList();
  }

  //发送http关机命令
  Future<void> sendHttpShutdown(String ip, String port) async {
    String url = getStrCommand(ip, port, "关机");
    HttpHandlerUtil().sendCommand(url);
  }

  //发送增加音量命令
  Future<void> sendIncreaseVolume(String ip, String port) async {
    String url = getStrCommand(ip, port, "增加音量");
    HttpHandlerUtil().sendCommand(url);
  }

  //发送减小音量命令
  Future<void> sendReduceVolume(String ip, String port) async {
    String url = getStrCommand(ip, port, "减小音量");
    HttpHandlerUtil().sendCommand(url);
  }

  //发送单播命令
  Future<void> sendSinglePlay(String ip, String port) async {
    String url = getStrCommand(ip, port, "单播");
    HttpHandlerUtil().sendCommand(url);
  }

  //发送播放文件夹命令
  Future<void> sendFolderPlay(String ip, String port) async {
    String url = getStrCommand(ip, port, "播放文件夹");
    HttpHandlerUtil().sendCommand(url);
  }

  //发送上个视频命令
  Future<void> sendPlayPrevious(String ip, String port) async {
    String url = getStrCommand(ip, port, "上个视频");
    HttpHandlerUtil().sendCommand(url);
  }

  //发送下个视频命令
  Future<void> sendPlayNext(String ip, String port) async {
    String url = getStrCommand(ip, port, "下个视频");
    HttpHandlerUtil().sendCommand(url);
  }

  //暂停
  Future<void> sendPlayPause(String ip, String port) async {
    String url = getStrCommand(ip, port, "暂停");
    HttpHandlerUtil().sendCommand(url);
  }
  //继续
  Future<void> sendPlayResume(String ip, String port) async {
    String url = getStrCommand(ip, port, "续播");
    HttpHandlerUtil().sendCommand(url);
  }
  //停止
  Future<void> sendPlayStop(String ip, String port) async {
    String url = getStrCommand(ip, port, "停止");
    HttpHandlerUtil().sendCommand(url);
  }

  String getStrCommand(String ip, String port, String command) {
    StringBuffer sb = StringBuffer();
    if(!ip.startsWith("http://")) {
      sb.write("http://");
    }
    sb.write(ip);
    sb.write(":");
    sb.write(port);
    sb.write("/");
    sb.write(command);
    return sb.toString();
  }


}