import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

const usernameError = "invalid username";
const emailError = "invalid email format";
const passwordError = "6-20 chars, uppercase, lowercase, digits";

const submitButtonKey = "submit_button";
const usernameInputKey = "username_input";
const emailInputKey = "email_input";
const passwordInputKey = "password_input";

/// Finds the username input field in the emulated app
Finder findUsernameInput() {
  return find.byKey(const Key(usernameInputKey));
}

/// Finds the email input field in the emulated app
Finder findEmailInput() {
  return find.byKey(const Key(emailInputKey));
}

/// Finds the password input field in the emulated app
Finder findPasswordInput() {
  return find.byKey(const Key(passwordInputKey));
}

/// Find a submission button in the emulated app
Finder findSubmissionButton() {
  return find.byKey(const Key(submitButtonKey));
}

/// Find a TextField widget by it's key
TextField findTextField(String key, WidgetTester tester) {
  Finder finder = find.byKey(Key(key));
  return tester.element(finder).widget as TextField;
}

/// Expect that the given text input field has a provided label
void expectInputLabel(
    TextField input, String expectedLabel, WidgetTester tester) async {
  expect(input.decoration, isNotNull);

  // There are two ways to configure the label, make sure both are accepted!
  if (input.decoration!.labelText != null) {
    expect(input.decoration!.labelText, equals(expectedLabel));
  } else {
    expect(input.decoration!.label, isNotNull);
    final Text labelWidget = input.decoration!.label as Text;
    expect(labelWidget.data, equals(expectedLabel));
  }
}

/// Expect that the input field identified by given inputFieldKey does not
/// contain an error message
void expectError(
    String inputFieldKey, String expectedError, WidgetTester tester) {
  TextField input = findTextField(inputFieldKey, tester);
  final String errorMessage = getTextInputError(input);
  expect(errorMessage, equals(expectedError));
}

/// Get the error message currently displayed for the given text input
/// Return the error message or "" if no error message is set
String getTextInputError(TextField input) {
  String errorMessage = "";
  if (input.decoration != null) {
    if (input.decoration!.errorText != null) {
      errorMessage = input.decoration!.errorText!;
    }
  }
  return errorMessage;
}

/// Check if the submission button is enabled (or disabled if enabled=false)
void expectButtonEnabled(bool enabled, WidgetTester tester) {
  final buttonFinder = find.byKey(const Key(submitButtonKey));
  expect(buttonFinder, findsOneWidget);
  ElevatedButton button = tester.element(buttonFinder).widget as ElevatedButton;
  if (enabled) {
    expect(button.onPressed, isNotNull);
  } else {
    expect(button.onPressed, isNull);
  }
}

/// Post the form - click on the button
Future<void> postForm(WidgetTester tester) async {
  final buttonFinder = findSubmissionButton();
  expect(buttonFinder, findsOneWidget);
  await tester.tap(buttonFinder);
  await tester.pump();
}

/// Set the value inside the username input field to provided value
Future<void> setUsername(String username, WidgetTester tester) async {
  await tester.enterText(findUsernameInput(), username);
  await tester.pump();
}

/// Set the value inside the email input field to provided value
Future<void> setEmail(String email, WidgetTester tester) async {
  await tester.enterText(findEmailInput(), email);
  await tester.pump();
}

/// Set the value inside the password input field to provided value
Future<void> setPassword(String password, WidgetTester tester) async {
  await tester.enterText(findPasswordInput(), password);
  await tester.pump();
}

/// Finds the spinner widget in the app
Finder findSpinner() {
  return find.byType(CircularProgressIndicator);
}

/// Submit form successfully with all inputs having valid values
Future<void> successfulFormSubmit(WidgetTester tester) async {
  await setUsername("chuck", tester);
  await setEmail("microsoft@chuck.com", tester);
  await setPassword("Nunchucks72", tester);
  await postForm(tester);
}

/// Expect that input field with given key is disabled
void expectInputDisabled(String inputKey, WidgetTester tester) {
  TextField input = findTextField(inputKey, tester);
  expect(input, isNotNull);
  expect(input.enabled, isFalse);
}
