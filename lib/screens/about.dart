import 'package:app1/config/app_config.dart';
import 'package:app1/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final config = AppConfig.instance;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.aboutTitle)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.aboutVersion(config.version),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            Text(l10n.aboutAuthor),
            const SizedBox(height: 8),
            Text(l10n.aboutContact),
            const SizedBox(height: 16),
            Text(l10n.aboutDisclaimer),
            const SizedBox(height: 24),
            Text(
              'Why SoulTrack?',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            const _AboutBullet('Log your emotions in seconds and review trends over time.'),
            const _AboutBullet('Unlock calming practices, breathing tools, and mini-games when stress spikes.'),
            const _AboutBullet('Stay on track with gentle reminders and daily minute goals.'),
            const _AboutBullet('Your data stays on-device by default—remote features can be toggled any time.'),
            const SizedBox(height: 24),
            Text('Need help?', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(
              config.usageUrl.isNotEmpty
                  ? 'For support contact fazalbinkaramat@gmail.com or visit ${config.usageUrl}.'
                  : 'For support contact binkDEV@gmail.com and we will be happy to help.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class _AboutBullet extends StatelessWidget {
  const _AboutBullet(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyMedium;
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• '),
          Expanded(child: Text(text, style: style)),
        ],
      ),
    );
  }
}
