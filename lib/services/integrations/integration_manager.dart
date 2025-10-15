import 'dart:async';
import 'dart:io';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:flutter/foundation.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import '../../config/app_config.dart';

class IntegrationManager {
  IntegrationManager._();

  static final IntegrationManager instance = IntegrationManager._();

  AppsflyerSdk? _appsFlyer;
  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) {
      return;
    }
    final config = AppConfig.instance;
    await Future.wait([_initAppsFlyer(config), _initOneSignal(config)]);
    _initialized = true;
  }

  Future<TrackingStatus> requestATT() async {
    if (!Platform.isIOS) {
      return TrackingStatus.notSupported;
    }
    var status = await AppTrackingTransparency.trackingAuthorizationStatus;
    if (status == TrackingStatus.notDetermined) {
      // Allow the first frame to render before triggering the system dialog.
      await Future.delayed(const Duration(milliseconds: 300));
      status = await AppTrackingTransparency.requestTrackingAuthorization();
    }
    return status;
  }

  Future<void> _initAppsFlyer(AppConfig config) async {
    if (config.appsFlyerDevKey.isEmpty) {
      return;
    }
    final options = AppsFlyerOptions(
      afDevKey: config.appsFlyerDevKey,
      appId: config.appleAppId,
      showDebug: config.environment.toLowerCase() != 'production',
    );
    _appsFlyer = AppsflyerSdk(options);
    try {
      await _appsFlyer?.initSdk(registerConversionDataCallback: false);
    } catch (err) {
      debugPrint('AppsFlyer init failed: $err');
    }
  }

  Future<void> _initOneSignal(AppConfig config) async {
    if (config.oneSignalAppId.isEmpty) {
      return;
    }
    try {
      OneSignal.initialize(config.oneSignalAppId);
      if (config.features.pushNotificationsEnabled) {
        await OneSignal.Notifications.requestPermission(true);
      }
    } catch (err) {
      debugPrint('OneSignal init failed: $err');
    }
  }
}
