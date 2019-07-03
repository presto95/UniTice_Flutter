import "package:flutter/material.dart";
import 'package:notification_permissions/notification_permissions.dart';
import "package:system_setting/system_setting.dart";

class NotificationPermissionListTile extends StatefulWidget {
  @override
  _NotificationPermissionListTileState createState() =>
      _NotificationPermissionListTileState();
}

class _NotificationPermissionListTileState
    extends State<NotificationPermissionListTile> with WidgetsBindingObserver {
  bool _isGranted = false;

  String get _permissionDescription =>
      "알림이 ${_isGranted ? "활성화" : "비활성화"}되어 있습니다.";

  @override
  void initState() {
    super.initState();
    _setPermissionStatus();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildListTile(),
        _buildPermissionDescriptionText(),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _setPermissionStatus();
    }
  }

  Widget _buildListTile() {
    return ListTile(
      title: Text("알림 설정"),
      trailing: Icon(Icons.navigate_next),
      onTap: () {
        SystemSetting.goto(SettingTarget.NOTIFICATION);
      },
    );
  }

  Widget _buildPermissionDescriptionText() {
    return Container(
      padding: const EdgeInsets.only(left: 16),
      child: Text(
        _permissionDescription,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 13,
        ),
      ),
    );
  }

  void _setPermissionStatus() async {
    final status =
        await NotificationPermissions.getNotificationPermissionStatus();
    setState(() {
      _isGranted = status == PermissionStatus.granted;
    });
  }
}
