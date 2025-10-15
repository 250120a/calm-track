import 'package:flutter/material.dart';
import 'package:app1/l10n/app_localizations.dart';

class PracticeQuickActions extends StatelessWidget {
  const PracticeQuickActions({
    super.key,
    required this.onAddMinutes,
    required this.onCustomTapped,
  });

  final ValueChanged<int> onAddMinutes;
  final VoidCallback onCustomTapped;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Row(
      children: [
        Expanded(
          child: _QuickButton(
            label: '+5',
            onTap: () => onAddMinutes(5),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _QuickButton(
            label: '+10',
            onTap: () => onAddMinutes(10),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _QuickButton(
            label: l10n.homeCustomMinutes,
            onTap: onCustomTapped,
          ),
        ),
      ],
    );
  }
}

class _QuickButton extends StatelessWidget {
  const _QuickButton({
    required this.label,
    required this.onTap,
  });

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: FilledButton(
        onPressed: onTap,
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          textStyle: Theme.of(context).textTheme.titleSmall,
        ),
        child: Text(
          label,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
