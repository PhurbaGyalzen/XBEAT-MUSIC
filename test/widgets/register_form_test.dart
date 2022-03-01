import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xbeat/widgets/register_form.dart';

void main() {
  group("Register Form Widget Test", () {
    testWidgets('Check if all Fields and Button are built',
        (WidgetTester tester) async {
      // ignore: todo
      // TODO: Implement test

      // find text field
      final firstNameField = find.byKey(ValueKey('firstNameKey'));
      final lastNameField = find.byKey(ValueKey('lastNameKey'));
      final userNameField = find.byKey(ValueKey('usernameKey'));
      final passwordField = find.byKey(ValueKey('passwordKey'));
      final confirmPasswordField = find.byKey(ValueKey('confirmPasswordKey'));
      final regButton = find.byKey(ValueKey('regButtonKey'));

      // execute test
      await tester.pumpWidget(MaterialApp(home: RegistrationForm()));
      await tester.pump();

      // check result
      expect(firstNameField, findsOneWidget);
      expect(lastNameField, findsOneWidget);
      expect(userNameField, findsOneWidget);
      expect(passwordField, findsOneWidget);
      expect(confirmPasswordField, findsOneWidget);
      expect(regButton, findsOneWidget);
    });
    testWidgets('Check if no error message is shown after built',
        (WidgetTester tester) async {
      // ignore: todo
      // TODO: Implement test

      // execute test
      await tester.pumpWidget(MaterialApp(home: RegistrationForm()));
      await tester.pump();

      // check result
      expect(find.text("Password is required for login"), findsNothing);
      expect(find.text("Enter Valid Password(Min. 6 Character)"), findsNothing);
      expect(find.text("Last Name cannot be Empty"), findsNothing);
      expect(find.text("Password don't match"), findsNothing);
    });
  });
}
