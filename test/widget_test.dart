import 'package:flutter_test/flutter_test.dart';
import 'package:app1/main.dart';
import 'package:app1/services/notifications/notification_service.dart';
import 'package:app1/services/storage/storage_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    await StorageService.instance.init();
    await NotificationService.instance.init();
  });
  testWidgets('Onboarding loads', (tester) async {
    await tester.pumpWidget(const CalmTrackApp());
    await tester.pumpAndSettle();
    expect(find.text('Track emotions in three taps'), findsOneWidget);
  });
}
