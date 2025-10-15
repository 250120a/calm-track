import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class AppConfig {
  AppConfig._();

  static final AppConfig instance = AppConfig._();

  AppConfigData _data = AppConfigData.defaults();

  AppConfigData get data => _data;

  String get gameName => _data.gameName;
  String get appsFlyerDevKey => _data.appsFlyerDevKey;
  String get appleAppId => _data.appleAppId;
  String get oneSignalAppId => _data.oneSignalAppId;
  String get environment => _data.environment;
  String get version => _data.version;
  DateTime? get lastUpdated => _data.lastUpdated;
  FeaturesConfig get features => _data.features;
  bool get showPrivacy => _data.showPrivacy;
  bool get showUsage => _data.showUsage;
  String get privacyUrl => _data.privacyUrl;
  String get usageUrl => _data.usageUrl;
  String get appUrl => _data.appUrl;

  Future<void> load({bool useRemote = true}) async {
    final defaults = await _loadLocalDefaults();
    _data = defaults;
    if (!useRemote) {
      return;
    }
    try {
      final remoteConfig = FirebaseRemoteConfig.instance;
      await remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval: const Duration(minutes: 30),
        ),
      );
      await remoteConfig.setDefaults(defaults.toRemoteConfigDefaults());
      await remoteConfig.fetchAndActivate();
      _data = AppConfigData.fromRemoteConfig(remoteConfig, fallback: defaults);
    } catch (err) {
      debugPrint('Remote config load failed: $err');
      _data = defaults;
    }
  }

  Future<AppConfigData> _loadLocalDefaults() async {
    try {
      final raw = await rootBundle.loadString('assets/config/config.json');
      final json = jsonDecode(raw) as Map<String, dynamic>;
      return AppConfigData.fromRemoteExport(json);
    } catch (err) {
      debugPrint('Failed to read local config: $err');
      return AppConfigData.defaults();
    }
  }
}

class AppConfigData {
  AppConfigData({
    required this.gameName,
    required this.appsFlyerDevKey,
    required this.appleAppId,
    required this.oneSignalAppId,
    required this.environment,
    required this.version,
    required this.lastUpdated,
    required this.features,
    required this.showPrivacy,
    required this.showUsage,
    required this.privacyUrl,
    required this.usageUrl,
    required this.appUrl,
  });

  final String gameName;
  final String appsFlyerDevKey;
  final String appleAppId;
  final String oneSignalAppId;
  final String environment;
  final String version;
  final DateTime? lastUpdated;
  final FeaturesConfig features;
  final bool showPrivacy;
  final bool showUsage;
  final String privacyUrl;
  final String usageUrl;
  final String appUrl;

  factory AppConfigData.defaults() {
    return AppConfigData(
      gameName: 'SoulTrack',
      appsFlyerDevKey: '',
      appleAppId: '',
      oneSignalAppId: '',
      environment: 'Development',
      version: '1.0.0',
      lastUpdated: null,
      features: const FeaturesConfig(
        pushNotificationsEnabled: true,
        analyticsEnabled: true,
        privacyPolicyRequired: true,
      ),
      showPrivacy: true,
      showUsage: true,
      privacyUrl: 'aHR0cHM6Ly9jYWxtdHJhY2stcHJpdmFjeS5jYXJyZC5jby8',
      usageUrl: 'aHR0cHM6Ly9jYWxtdHJhY2stdXNhZ2UuY2FycmQuY28v',
      appUrl: 'https://apps.apple.com/app/id000000000',
    );
  }

  factory AppConfigData.fromRemoteConfig(
    FirebaseRemoteConfig remote, {
    required AppConfigData fallback,
  }) {
    DateTime? parseDate(String value) {
      if (value.isEmpty) return fallback.lastUpdated;
      try {
        return DateTime.tryParse(value) ?? fallback.lastUpdated;
      } catch (_) {
        return fallback.lastUpdated;
      }
    }

    return AppConfigData(
      gameName: _string(remote, 'gameName', fallback.gameName),
      appsFlyerDevKey: _string(
        remote,
        'appsFlyerDevKey',
        fallback.appsFlyerDevKey,
      ),
      appleAppId: _string(remote, 'appleAppID', fallback.appleAppId),
      oneSignalAppId: _string(
        remote,
        'oneSignalAppID',
        fallback.oneSignalAppId,
      ),
      environment: _string(remote, 'environment', fallback.environment),
      version: _string(remote, 'version', fallback.version),
      lastUpdated: parseDate(
        _string(
          remote,
          'lastUpdated',
          fallback.lastUpdated?.toIso8601String() ?? '',
        ),
      ),
      features: FeaturesConfig(
        pushNotificationsEnabled: _bool(
          remote,
          'pushNotificationsEnabled',
          fallback.features.pushNotificationsEnabled,
        ),
        analyticsEnabled: _bool(
          remote,
          'analyticsEnabled',
          fallback.features.analyticsEnabled,
        ),
        privacyPolicyRequired: _bool(
          remote,
          'privacyPolicyRequired',
          fallback.features.privacyPolicyRequired,
        ),
      ),
      showPrivacy: _bool(remote, 'showPrivacy', fallback.showPrivacy),
      showUsage: _bool(remote, 'showUsage', fallback.showUsage),
      privacyUrl: _decodeUrl(
        _string(remote, 'privacyURL', fallback.privacyUrl),
      ),
      usageUrl: _decodeUrl(
        _string(remote, 'usageURL', fallback.usageUrl),
      ),
      appUrl: _deriveAppUrl(
        provided: _string(remote, 'appURL', ''),
        appleId: _string(remote, 'appleAppID', fallback.appleAppId),
        fallback: fallback.appUrl,
      ),
    );
  }

  factory AppConfigData.fromRemoteExport(Map<String, dynamic> exportJson) {
    final defaults = AppConfigData.defaults();
    String getString(String key, [String? fallback]) {
      final param = exportJson['parameters']?[key] as Map<String, dynamic>?;
      final value = param?['defaultValue']?['value'];
      if (value == null) return fallback ?? '';
      return value.toString();
    }

    bool getBool(String key, [bool? fallback]) {
      final str = getString(key);
      if (str.isEmpty) return fallback ?? false;
      return str.toLowerCase() == 'true';
    }

    return AppConfigData(
      gameName: getString('gameName', defaults.gameName),
      appsFlyerDevKey: getString('appsFlyerDevKey', defaults.appsFlyerDevKey),
      appleAppId: getString('appleAppID', defaults.appleAppId),
      oneSignalAppId: getString('oneSignalAppID', defaults.oneSignalAppId),
      environment: getString('environment', defaults.environment),
      version: getString('version', defaults.version),
      lastUpdated:
          DateTime.tryParse(getString('lastUpdated')) ?? defaults.lastUpdated,
      features: FeaturesConfig(
        pushNotificationsEnabled: getBool(
          'pushNotificationsEnabled',
          defaults.features.pushNotificationsEnabled,
        ),
        analyticsEnabled: getBool(
          'analyticsEnabled',
          defaults.features.analyticsEnabled,
        ),
        privacyPolicyRequired: getBool(
          'privacyPolicyRequired',
          defaults.features.privacyPolicyRequired,
        ),
      ),
      showPrivacy: getBool('showPrivacy', defaults.showPrivacy),
      showUsage: getBool('showUsage', defaults.showUsage),
      privacyUrl: _decodeUrl(getString('privacyURL', defaults.privacyUrl)),
      usageUrl: _decodeUrl(getString('usageURL', defaults.usageUrl)),
      appUrl: _deriveAppUrl(
        provided: getString('appURL'),
        appleId: getString('appleAppID', defaults.appleAppId),
        fallback: defaults.appUrl,
      ),
    );
  }

  Map<String, dynamic> toRemoteConfigDefaults() {
    return {
      'gameName': gameName,
      'appsFlyerDevKey': appsFlyerDevKey,
      'appleAppID': appleAppId,
      'oneSignalAppID': oneSignalAppId,
      'environment': environment,
      'version': version,
      'lastUpdated': lastUpdated?.toIso8601String() ?? '',
      'pushNotificationsEnabled': features.pushNotificationsEnabled,
      'analyticsEnabled': features.analyticsEnabled,
      'privacyPolicyRequired': features.privacyPolicyRequired,
      'showPrivacy': showPrivacy,
      'showUsage': showUsage,
      'privacyURL': privacyUrl,
      'usageURL': usageUrl,
      'appURL': appUrl,
    };
  }
}

class FeaturesConfig {
  const FeaturesConfig({
    required this.pushNotificationsEnabled,
    required this.analyticsEnabled,
    required this.privacyPolicyRequired,
  });

  final bool pushNotificationsEnabled;
  final bool analyticsEnabled;
  final bool privacyPolicyRequired;
}

String _string(FirebaseRemoteConfig remote, String key, String fallback) {
  final value = remote.getString(key);
  return value.isEmpty ? fallback : value;
}

bool _bool(FirebaseRemoteConfig remote, String key, bool fallback) {
  try {
    return remote.getBool(key);
  } catch (_) {
    final str = remote.getString(key);
    if (str.isEmpty) return fallback;
    return str.toLowerCase() == 'true';
  }
}

String _deriveAppUrl({
  required String provided,
  required String appleId,
  required String fallback,
}) {
  final decodedProvided = _decodeUrl(provided);
  if (decodedProvided.isNotEmpty) {
    return decodedProvided;
  }
  if (fallback.isNotEmpty) {
    return fallback;
  }
  if (appleId.isNotEmpty) {
    return 'https://apps.apple.com/app/id$appleId';
  }
  return '';
}

String _decodeUrl(String value) {
  if (value.isEmpty) {
    return value;
  }
  try {
    var normalized = value.trim();
    final remainder = normalized.length % 4;
    if (remainder != 0) {
      normalized = normalized.padRight(normalized.length + (4 - remainder), '=');
    }
    final decoded = utf8.decode(base64.decode(normalized));
    if (decoded.startsWith('http')) {
      return decoded;
    }
  } catch (_) {}
  return value;
}
