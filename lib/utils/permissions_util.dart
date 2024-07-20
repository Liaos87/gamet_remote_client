import 'package:permission_handler/permission_handler.dart';

class PermissionsUtil {

  static final PermissionsUtil _instance = PermissionsUtil._internal();

  factory PermissionsUtil() => _instance;

  PermissionsUtil._internal();

  //检查存储权限状态
  Future<bool> checkStoragePermission() async {
    PermissionStatus status = await Permission.storage.status;
    return status.isGranted;
  }

  //检查相机权限状态
  Future<bool> checkCameraPermission() async {
    PermissionStatus status = await Permission.camera.status;
    return status.isGranted;
  }

}