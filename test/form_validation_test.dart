import 'package:exercise_e6/main.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_utilities.dart';

void main() {
  testWidgets("Validation turned off by default", (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expectError(usernameInputKey, "", tester);
    expectError(emailInputKey, "", tester);
    expectError(passwordInputKey, "", tester);
    expectButtonEnabled(true, tester);
  });

  testWidgets("Submission disabled on error", (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await postForm(tester);
    expectButtonEnabled(false, tester);
  });

  testWidgets("Username error - empty", (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await postForm(tester);
    expectError(usernameInputKey, usernameError, tester);
  });

  testWidgets("Username error - too short", (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await setUsername("me", tester);
    await postForm(tester);
    expectError(usernameInputKey, usernameError, tester);
  });

  testWidgets("Username error - too long", (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await setUsername("VeryLongNameIndeed", tester);
    await postForm(tester);
    expectError(usernameInputKey, usernameError, tester);
  });

  testWidgets("Username error - invalid characters",
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await setUsername("robocup3", tester);
    await postForm(tester);
    expectError(usernameInputKey, usernameError, tester);
    await setUsername("Bjørn", tester);
    expectError(usernameInputKey, usernameError, tester);
    await setUsername("robo cup", tester);
    expectError(usernameInputKey, usernameError, tester);
  });

  testWidgets("No error when username is valid", (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await setUsername("RoboChuck", tester);
    await postForm(tester);
    expectError(usernameInputKey, "", tester);
  });

  testWidgets("Email error - invalid format", (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await setEmail("chuck", tester);
    await postForm(tester);
    expectError(emailInputKey, emailError, tester);
    await setEmail("@chuck", tester);
    expectError(emailInputKey, emailError, tester);
    await setEmail("chuck@", tester);
    expectError(emailInputKey, emailError, tester);
    await setEmail("chuck@microsoft", tester);
    expectError(emailInputKey, emailError, tester);
    await setEmail("@chuck@microsoft.com", tester);
    expectError(emailInputKey, emailError, tester);
    await setEmail("chuck@micr@osoft.com", tester);
    expectError(emailInputKey, emailError, tester);
    await setEmail("chuck@microsoft.com@", tester);
    expectError(emailInputKey, emailError, tester);
    await setEmail("  chuck@microsoft.com", tester);
    expectError(emailInputKey, emailError, tester);
    await setEmail("chuck@microsoft.com ", tester);
    expectError(emailInputKey, emailError, tester);
    await setEmail("chuck@microsoft.com.", tester);
    expectError(emailInputKey, emailError, tester);
  });

  testWidgets("Password error", (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await setPassword("pass", tester);
    await postForm(tester);
    expectError(passwordInputKey, passwordError, tester);
    await setPassword("password", tester);
    expectError(passwordInputKey, passwordError, tester);
    await setPassword("pAs3", tester);
    expectError(passwordInputKey, passwordError, tester);
    await setPassword("paSsword", tester);
    expectError(passwordInputKey, passwordError, tester);
    await setPassword("password3", tester);
    expectError(passwordInputKey, passwordError, tester);
    await setPassword("ThisIsTooLongPassword2022", tester);
    expectError(passwordInputKey, passwordError, tester);
  });

  testWidgets("Form enabled again when all values are valid",
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await postForm(tester);
    expectButtonEnabled(false, tester);
    await setUsername("chuck", tester);
    await setEmail("microsoft@chuck.com", tester);
    await setPassword("Nunchucks72", tester);
    expectButtonEnabled(true, tester);
  });

  testWidgets("No spinner by default", (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(findSpinner(), findsNothing);
  });

  testWidgets("Spinner shown when form is submitted",
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await successfulFormSubmit(tester);
    expect(findSpinner(), findsOneWidget);
  });

  testWidgets("Button removed when form is submitted",
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await successfulFormSubmit(tester);
    expect(findSubmissionButton(), findsNothing);
  });

  testWidgets("Inputs disabled when form is submitted",
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await successfulFormSubmit(tester);
    expectInputDisabled(usernameInputKey, tester);
    expectInputDisabled(emailInputKey, tester);
    expectInputDisabled(passwordInputKey, tester);
  });
}

