import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app1/l10n/app_localizations.dart';

import 'calm_play/calm_play_screen.dart';
import 'home.dart';
import 'stats.dart';
import '../providers/prefs_provider.dart';
import '../services/integrations/integration_manager.dart';
import '../widgets/glass_container.dart';

class CalmShell extends StatefulWidget {
  const CalmShell({super.key});

  @override
  State<CalmShell> createState() => _CalmShellState();
}

class _CalmShellState extends State<CalmShell> {
  int _index = 0;
  bool _attPromptHandled = false;
  Future<bool>? _attDisclosureFuture;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _handleTrackingPrompt());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final pages = [
      HomeScreen(
        onOpenCalmPlay: () => _setIndex(2),
      ),
      const StatsScreen(),
      const CalmPlayScreen(),
    ];
    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: _index,
        children: pages,
      ),
      bottomNavigationBar: _BottomNavBar(
        currentIndex: _index,
        labels: [
          l10n.navHome,
          l10n.navStats,
          l10n.navCalmPlay,
        ],
        onSelected: _setIndex,
      ),
    );
  }

  void _setIndex(int value) {
    setState(() {
      _index = value;
    });
  }

  Future<void> _handleTrackingPrompt() async {
    if (_attPromptHandled || !mounted) {
      return;
    }
    _attPromptHandled = true;
    final prefs = context.read<PrefsProvider>();

    if (!Platform.isIOS) {
      await IntegrationManager.instance.init();
      return;
    }

    var status = await AppTrackingTransparency.trackingAuthorizationStatus;

    if (status == TrackingStatus.notDetermined && prefs.attPromptCompleted) {
      await prefs.setAttPromptCompleted(false);
      _attPromptHandled = false;
    }

    if (!prefs.attPromptCompleted && status == TrackingStatus.notDetermined) {
      final proceed = await _showTrackingDisclosure();
      if (!mounted) {
        return;
      }
      if (proceed) {
        status = await IntegrationManager.instance.requestATT();
      } else {
        // Allow another attempt on next app launch if the sheet was not completed.
        _attPromptHandled = false;
        return;
      }
    }

    if (!prefs.attPromptCompleted && status != TrackingStatus.notDetermined) {
      await prefs.setAttPromptCompleted(true);
    }

    await IntegrationManager.instance.init();
  }

  Future<bool> _showTrackingDisclosure() {
    if (_attDisclosureFuture != null) {
      return _attDisclosureFuture!;
    }
    final l10n = AppLocalizations.of(context);
    _attDisclosureFuture = showModalBottomSheet<bool>(
      context: context,
      isDismissible: false,
      enableDrag: false,
      builder: (context) => _TrackingPermissionSheet(l10n: l10n),
    ).then((value) {
      _attDisclosureFuture = null;
      return value ?? false;
    });
    return _attDisclosureFuture!;
  }
}

class _TrackingPermissionSheet extends StatelessWidget {
  const _TrackingPermissionSheet({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;
    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(24, 32, 24, 24 + bottomPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.trackingPermissionTitle,
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            Text(
              l10n.trackingPermissionBody,
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            Text(
              l10n.trackingPermissionSettings,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(l10n.trackingPermissionButton),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar({
    required this.currentIndex,
    required this.labels,
    required this.onSelected,
  });

  final int currentIndex;
  final List<String> labels;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final items = const [
      (inactive: Icons.home_outlined, active: Icons.home),
      (inactive: Icons.stacked_line_chart_outlined, active: Icons.stacked_line_chart),
      (inactive: Icons.spa_outlined, active: Icons.spa),
    ];
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      child: SizedBox(
        height: 78,
        child: GlassContainer(
          borderRadius: BorderRadius.circular(30),
          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 14),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final itemWidth = constraints.maxWidth / items.length;
              return Stack(
                clipBehavior: Clip.none,
                children: [
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 260),
                    curve: Curves.easeOutCubic,
                    left: currentIndex * itemWidth + 4,
                    top: 4,
                    width: itemWidth - 8,
                    height: 52,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),
                  Row(
                    children: List.generate(items.length, (index) {
                      final active = index == currentIndex;
                      final iconPair = items[index];
                      final color = active
                          ? theme.colorScheme.primary
                          : theme.colorScheme.onSurface.withValues(alpha: 0.6);
                      return Expanded(
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () => onSelected(index),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AnimatedScale(
                                duration: const Duration(milliseconds: 220),
                                scale: active ? 1.1 : 1.0,
                                curve: Curves.easeOutBack,
                                child: Icon(
                                  active ? iconPair.active : iconPair.inactive,
                                  size: 26,
                                  color: color,
                                ),
                              ),
                              const SizedBox(height: 6),
                              AnimatedDefaultTextStyle(
                                duration: const Duration(milliseconds: 180),
                                curve: Curves.easeOut,
                                style: theme.textTheme.labelSmall!.copyWith(
                                  fontWeight: active ? FontWeight.w600 : FontWeight.w500,
                                  color: color,
                                ),
                                child: Text(
                                  labels[index],
                                  maxLines: 1,
                                  overflow: TextOverflow.fade,
                                  softWrap: false,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
