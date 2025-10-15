import 'package:flutter/material.dart';
import 'package:app1/l10n/app_localizations.dart';

import 'breathing_tab.dart';
import 'game_tab.dart';
import 'timer_tab.dart';

class CalmPlayScreen extends StatelessWidget {
  const CalmPlayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.navCalmPlay),
          bottom: TabBar(
            tabs: [
              Tab(text: l10n.calmPlayBreathing),
              Tab(text: l10n.calmPlayTimer),
              Tab(text: l10n.calmPlayGame),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            BreathingTab(),
            TimerTab(),
            GameTab(),
          ],
        ),
      ),
    );
  }
}
