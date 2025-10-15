import 'package:flutter/material.dart';
import 'package:app1/l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/emotion_type.dart';
import '../providers/emotion_provider.dart';
import '../utils/localized_texts.dart';
import '../widgets/emotion_entry_card.dart';

class EmotionLogScreen extends StatefulWidget {
  const EmotionLogScreen({super.key});

  @override
  State<EmotionLogScreen> createState() => _EmotionLogScreenState();
}

class _EmotionLogScreenState extends State<EmotionLogScreen> {
  EmotionType? _filter;
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final provider = context.watch<EmotionProvider>();
    final filtered = provider.entries.where((entry) {
      final matchesFilter = _filter == null || entry.type == _filter;
      final matchesQuery = _query.isEmpty || (entry.note?.toLowerCase().contains(_query.toLowerCase()) ?? false);
      return matchesFilter && matchesQuery;
    }).toList();
    final grouped = <DateTime, List<int>>{};
    for (var i = 0; i < filtered.length; i++) {
      final entry = filtered[i];
      final day = DateTime(entry.timestamp.year, entry.timestamp.month, entry.timestamp.day);
      final list = grouped.putIfAbsent(day, () => []);
      list.add(i);
    }
    final sortedKeys = grouped.keys.toList()..sort((a, b) => b.compareTo(a));
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.logTitle),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.logFilterLabel, style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ChoiceChip(
                        label: Text(l10n.logFilterAll),
                        selected: _filter == null,
                        onSelected: (_) => setState(() => _filter = null),
                      ),
                      ...EmotionType.values.map(
                        (type) => Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: ChoiceChip(
                            label: Text(type.label(l10n)),
                            selected: _filter == type,
                            onSelected: (_) => setState(() => _filter = type),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(hintText: l10n.logSearchHint),
                  onChanged: (value) => setState(() => _query = value),
                ),
              ],
            ),
          ),
          Expanded(
            child: filtered.isEmpty
                ? Center(child: Text(l10n.logEmpty))
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    itemCount: sortedKeys.length,
                    itemBuilder: (context, index) {
                      final day = sortedKeys[index];
                      final dayEntries = grouped[day]!
                          .map((i) => filtered[i])
                          .toList()
                        ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
                      final label = DateFormat.yMMMMd().format(day);
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(label, style: Theme.of(context).textTheme.titleSmall),
                            const SizedBox(height: 12),
                            ...dayEntries.map(
                              (entry) => Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: EmotionEntryCard(entry: entry),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
