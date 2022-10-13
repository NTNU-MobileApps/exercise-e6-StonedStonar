import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:exercise_e6/main.dart';

import 'test_utilities.dart';

void main() {
  testWidgets('Username input-field is present', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(findUsernameInput(), findsOneWidget);
  });

  testWidgets('Email input-field is present', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(findEmailInput(), findsOneWidget);
  });

  testWidgets('Password input-field is present', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(findPasswordInput(), findsOneWidget);
  });

  testWidgets('Submission button is present', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    final Finder button = findSubmissionButton();
    expect(button, findsOneWidget);
  });

  testWidgets('Submission button has correct text',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    final Finder button = findSubmissionButton();
    final text =
        find.descendant(of: button, matching: find.text("Submit form"));
    expect(text, findsOneWidget);
  });

  testWidgets('Username has correct label', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expectInputLabel(
        findTextField(usernameInputKey, tester), "Username", tester);
  });

  testWidgets('Email has correct label', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expectInputLabel(findTextField(emailInputKey, tester), "Email", tester);
  });

  testWidgets('Password has correct label', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expectInputLabel(
        findTextField(passwordInputKey, tester), "Password", tester);
  });

  testWidgets('Email has correct keyboard', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    final TextField emailInput = findTextField(emailInputKey, tester);
    expect(emailInput.keyboardType, equals(TextInputType.emailAddress));
  });

  testWidgets('Password has hidden characters', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    final TextField passwordInput = findTextField(passwordInputKey, tester);
    expect(passwordInput.obscureText, isTrue);
  });
}
