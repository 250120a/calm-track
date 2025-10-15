import 'package:flutter/material.dart';

class RangeSelector extends StatelessWidget {
  const RangeSelector({
    super.key,
    required this.selected,
    required this.labels,
    required this.onChanged,
  });

  final int selected;
  final Map<int, String> labels;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      children: labels.entries
          .map(
            (entry) => ChoiceChip(
              label: Text(entry.value),
              selected: selected == entry.key,
              onSelected: (_) => onChanged(entry.key),
            ),
          )
          .toList(),
    );
  }
}
