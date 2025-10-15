import 'package:flutter/material.dart';
import 'package:app1/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../config/app_config.dart';
import '../providers/prefs_provider.dart';
import '../widgets/glass_container.dart';
import 'about.dart';
import 'privacy.dart';
import 'webview_page.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final prefs = context.watch<PrefsProvider>();
    final config = AppConfig.instance;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settingsTitle),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        children: [
          _NameSection(prefs: prefs),
          const SizedBox(height: 24),
          _GoalSection(prefs: prefs),
          const SizedBox(height: 24),
          _ReminderSection(prefs: prefs),
          const SizedBox(height: 24),
          _LanguageSection(prefs: prefs),
          const SizedBox(height: 24),
          _ThemeSection(prefs: prefs),
          const SizedBox(height: 24),
          _SettingsTile(
            title: l10n.settingsRateApp,
            trailing: const Icon(Icons.open_in_new),
            onTap: () => _launchRateApp(context, config),
          ),
          const SizedBox(height: 16),
          if (config.showPrivacy) ...[
            _SettingsTile(
              title: l10n.settingsPrivacy,
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _openExternal(
                context,
                url: config.privacyUrl,
                title: l10n.settingsPrivacy,
                fallback: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const PrivacyScreen()),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
          if (config.showUsage) ...[
            _SettingsTile(
              title: l10n.settingsUsage,
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _openExternal(
                context,
                url: config.usageUrl,
                title: l10n.settingsUsage,
              ),
            ),
            const SizedBox(height: 16),
          ],
          _SettingsTile(
            title: l10n.settingsAbout,
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const AboutScreen()),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class _NameSection extends StatelessWidget {
  const _NameSection({required this.prefs});

  final PrefsProvider prefs;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return GlassContainer(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.settingsName,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          TextFormField(
            initialValue: prefs.userName,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              hintText: l10n.settingsNameHint,
            ),
            onChanged: (value) => prefs.setUserName(value),
          ),
        ],
      ),
    );
  }
}

class _GoalSection extends StatelessWidget {
  const _GoalSection({required this.prefs});

  final PrefsProvider prefs;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return GlassContainer(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.settingsDailyGoal,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          Slider(
            min: 5,
            max: 120,
            divisions: 23,
            value: prefs.dailyGoalMinutes.toDouble(),
            label: '${prefs.dailyGoalMinutes}',
            onChanged: (value) => prefs.setDailyGoal(value.round()),
          ),
        ],
      ),
    );
  }
}

class _ReminderSection extends StatelessWidget {
  const _ReminderSection({required this.prefs});

  final PrefsProvider prefs;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final times = prefs.reminderTimes;
    return GlassContainer(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.settingsReminders),
            value: prefs.remindersEnabled,
            subtitle: Text(prefs.remindersEnabled ? l10n.settingsRemindersEnabled : l10n.settingsRemindersDisabled),
            onChanged: (value) => prefs.toggleReminders(value),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final time in times)
                InputChip(
                  label: Text(time.format(context)),
                  onDeleted: () {
                    final updated = List.of(times)..remove(time);
                    prefs.updateReminderTimes(updated);
                  },
                ),
              if (times.length < 3)
                ActionChip(
                  label: Text(l10n.settingsAddReminder),
                  onPressed: () async {
                    final picked = await showTimePicker(
                      context: context,
                      initialTime: const TimeOfDay(hour: 9, minute: 0),
                    );
                    if (picked != null) {
                      final updated = List.of(times);
                      final exists = updated.any(
                        (element) => element.hour == picked.hour && element.minute == picked.minute,
                      );
                      if (!exists) {
                        updated.add(picked);
                        updated.sort((a, b) {
                          final hourDiff = a.hour.compareTo(b.hour);
                          return hourDiff != 0 ? hourDiff : a.minute.compareTo(b.minute);
                        });
                        prefs.updateReminderTimes(updated);
                      }
                    }
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LanguageSection extends StatelessWidget {
  const _LanguageSection({required this.prefs});

  final PrefsProvider prefs;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final languageLabels = <String, String>{
      'system': l10n.settingsLanguageSystem,
      'en': l10n.languageEnglish,
      'es': l10n.languageSpanish,
      'ru': l10n.languageRussian,
      'fr': l10n.languageFrench,
      'de': l10n.languageGerman,
    };
    return GlassContainer(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.settingsLanguage,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: prefs.localeCode,
              isExpanded: true,
              onChanged: (value) {
                if (value != null) {
                  prefs.setLocaleCode(value);
                }
              },
              items: languageLabels.entries
                  .map(
                    (entry) => DropdownMenuItem<String>(
                      value: entry.key,
                      child: Text(entry.value),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _ThemeSection extends StatelessWidget {
  const _ThemeSection({required this.prefs});

  final PrefsProvider prefs;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return GlassContainer(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.settingsTheme,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          DropdownButtonHideUnderline(
            child: DropdownButton<ThemeMode>(
              value: prefs.themeMode,
              isExpanded: true,
              onChanged: (mode) {
                if (mode != null) {
                  prefs.setThemeMode(mode);
                }
              },
              items: [
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: Text(l10n.settingsThemeSystem),
                ),
                DropdownMenuItem(
                  value: ThemeMode.light,
                  child: Text(l10n.settingsThemeLight),
                ),
                DropdownMenuItem(
                  value: ThemeMode.dark,
                  child: Text(l10n.settingsThemeDark),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({required this.title, required this.trailing, this.onTap});

  final String title;
  final Widget trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      onTap: onTap,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        title: Text(title),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }
}

Future<void> _launchRateApp(BuildContext context, AppConfig config) async {
  final messenger = ScaffoldMessenger.of(context);
  final Uri? uri = config.appUrl.isNotEmpty
      ? Uri.tryParse(config.appUrl)
      : (config.appleAppId.isNotEmpty
          ? Uri.tryParse('https://apps.apple.com/app/id${config.appleAppId}')
          : null);
  if (uri == null) {
    messenger.showSnackBar(const SnackBar(content: Text('Store link unavailable')));
    return;
  }
  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    messenger.showSnackBar(const SnackBar(content: Text('Unable to open store link')));
  }
}

void _openExternal(
  BuildContext context, {
  required String url,
  required String title,
  VoidCallback? fallback,
}) {
  if (url.isEmpty) {
    if (fallback != null) {
      fallback();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Link is unavailable')),
      );
    }
    return;
  }
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) => WebViewPage(title: title, url: url),
    ),
  );
}
