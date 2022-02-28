import 'package:flutter_test/flutter_test.dart';
import 'package:xbeat/pages/login.dart';

void main() {
  group("PasswordValidationTest", () {
    test('empty password returns error string', () async {
      // ignore: todo
      // TODO: Implement test

      //
      var result = await PasswordFieldValidator.validate('');

      expect(result, 'Password is required for login');
    });
    test('short returns error string', () async {
      // ignore: todo
      // TODO: Implement test

      var result = await PasswordFieldValidator.validate('asdf');

      expect(result, 'Enter Valid Password(Min. 6 Character)');
    });
    test('strong password returns null', () async {
      // ignore: todo
      // TODO: Implement test

      var result = await PasswordFieldValidator.validate('asdfa@134');

      expect(result, null);
    });
  });
}
