import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:daymark_tracking/core/present/widgets/global_snackbar.dart';
import 'package:daymark_tracking/core/theme/app_theme.dart';

void main() {
  Widget buildTestApp(Widget child) {
    return MaterialApp(
      theme: AppTheme.darkTheme,
      scaffoldMessengerKey: GlobalSnackbar.messengerKey,
      home: Scaffold(body: child),
    );
  }

  testWidgets('displays success, error, warning, and info snackbars', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      buildTestApp(
        Column(
          children: <Widget>[
            ElevatedButton(
              onPressed: () => GlobalSnackbar.showSuccess('Saved!'),
              child: const Text('Success'),
            ),
            ElevatedButton(
              onPressed: () => GlobalSnackbar.showError('Failed!'),
              child: const Text('Error'),
            ),
            ElevatedButton(
              onPressed: () => GlobalSnackbar.showWarning('Careful!'),
              child: const Text('Warning'),
            ),
            ElevatedButton(
              onPressed: () => GlobalSnackbar.showInfo('Heads up!'),
              child: const Text('Info'),
            ),
          ],
        ),
      ),
    );

    await tester.tap(find.text('Success'));
    await tester.pump();
    expect(find.text('Saved!'), findsOneWidget);
    expect(find.byIcon(Icons.check_circle_outline_rounded), findsOneWidget);

    await tester.tap(find.text('Error'));
    await tester.pump();
    expect(find.text('Failed!'), findsOneWidget);
    expect(find.byIcon(Icons.error_outline_rounded), findsOneWidget);

    await tester.tap(find.text('Warning'));
    await tester.pump();
    expect(find.text('Careful!'), findsOneWidget);
    expect(find.byIcon(Icons.warning_amber_rounded), findsOneWidget);

    await tester.tap(find.text('Info'));
    await tester.pump();
    expect(find.text('Heads up!'), findsOneWidget);
    expect(find.byIcon(Icons.info_outline_rounded), findsOneWidget);
  });
}
