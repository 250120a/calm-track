import 'package:flutter/material.dart';
import 'package:app1/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../style/app_colors.dart';
import '../providers/prefs_provider.dart';
import '../widgets/glass_container.dart';
import 'shell.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  late final TextEditingController _nameController;
  int _pageIndex = 0;
  double _goal = 10;
  bool _reminders = false;
  String? _nameError;
  bool _prefilledName = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_prefilledName) {
      final existing = context.read<PrefsProvider>().userName;
      if (existing.isNotEmpty) {
        _nameController.text = existing;
      }
      _prefilledName = true;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final slides = [
      l10n.onboardingTitle1,
      l10n.onboardingTitle2,
      l10n.onboardingTitle3,
    ];
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: slides.length,
                  onPageChanged: (index) {
                    setState(() {
                      _pageIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                      physics: const BouncingScrollPhysics(),
                      child: GlassContainer(
                        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.blur_circular,
                              size: 120,
                              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.25),
                            ),
                            const SizedBox(height: 32),
                            Text(
                              slides[index],
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  slides.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _pageIndex == index ? 18 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _pageIndex == index ? AppColors.primary : AppColors.wave,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              GlassContainer(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.onboardingNameLabel,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _nameController,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        hintText: l10n.onboardingNameHint,
                        errorText: _nameError,
                      ),
                      onChanged: (_) {
                        if (_nameError != null) {
                          setState(() {
                            _nameError = null;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 24),
                    Text(
                      l10n.onboardingDailyGoalLabel,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Slider(
                            min: 5,
                            max: 60,
                            divisions: 11,
                            value: _goal,
                            label: '${_goal.round()}',
                            onChanged: (value) {
                              setState(() {
                                _goal = value;
                              });
                            },
                          ),
                        ),
                        Text('${_goal.round()} ${l10n.onboardingDailyGoalSuffix}'),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(l10n.onboardingToggleReminders),
                      value: _reminders,
                      onChanged: (value) {
                        setState(() {
                          _reminders = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => _pageIndex == slides.length - 1 ? _completeOnboarding(context) : _nextPage(),
                  child: Text(_pageIndex == slides.length - 1 ? l10n.actionStart : l10n.actionNext),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _nextPage() {
    _controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  Future<void> _completeOnboarding(BuildContext context) async {
    if (!_validateName()) {
      return;
    }
    final name = _nameController.text.trim();
    final prefs = context.read<PrefsProvider>();
    final navigator = Navigator.of(context);
    await prefs.setUserName(name);
    await prefs.setDailyGoal(_goal.round());
    await prefs.toggleReminders(_reminders);
    if (_reminders) {
      await prefs.updateReminderTimes([const TimeOfDay(hour: 9, minute: 0)]);
    } else {
      await prefs.updateReminderTimes([]);
    }
    await prefs.setOnboardingComplete(true);
    if (!prefs.isLoaded) {
      await prefs.load();
    }
    if (!mounted) {
      return;
    }
    navigator.pushReplacement(
      MaterialPageRoute(
        builder: (_) => const CalmShell(),
      ),
    );
  }

  bool _validateName() {
    final trimmed = _nameController.text.trim();
    if (trimmed.isEmpty) {
      setState(() {
        _nameError = AppLocalizations.of(context).onboardingNameValidation;
      });
      return false;
    }
    if (_nameError != null) {
      setState(() {
        _nameError = null;
      });
    }
    return true;
  }
}
