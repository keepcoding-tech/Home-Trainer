import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:home_trainer/authentication/services/authenticationController.dart';

class MockUser extends Mock implements User {}

final MockUser _mockUser = new MockUser();

class MockFirebaseAuth extends Mock implements FirebaseAuth {
  @override
  Stream<User> authStateChanges() {
    return Stream.fromIterable([_mockUser]);
  }
}

void main() {
  final MockFirebaseAuth mockFirebaseAuth = new MockFirebaseAuth();
  final AuthenticationController auth =
      new AuthenticationController(mockFirebaseAuth);

  setUp(() {});
  tearDown(() {});

  // EMIT OCCURS
  test('emit occurs', () async {
    expectLater(auth.authStateChanges, emitsInOrder([_mockUser]));
  });

  // SIGN IN
  test('login', () async {
    when(mockFirebaseAuth.signInWithEmailAndPassword(
            email: 'testingflutterapp@gmail.com', password: '123456'))
        .thenAnswer((realInvocation) => null);

    expect(
        await auth.signIn(
            email: 'testingflutterapp@gmail.com', password: '123456'),
        'Signed in');
  });
  test('login exception', () async {
    when(mockFirebaseAuth.signInWithEmailAndPassword(
            email: 'testingflutterapp@gmail.com', password: '123456'))
        .thenAnswer((realInvocation) =>
            throw FirebaseAuthException(code: null, message: 'error'));

    expect(
        await auth.signIn(
            email: 'testingflutterapp@gmail.com', password: '123456'),
        'error');
  });

  // SIGN UP
  test('create account', () async {
    when(mockFirebaseAuth.createUserWithEmailAndPassword(
            email: 'testingflutterapp@gmail.com', password: '123456'))
        .thenAnswer((realInvocation) => null);

    expect(
        await auth.signUp(
            email: 'testingflutterapp@gmail.com', password: '123456'),
        'Signed up');
  });
  test('create account exception', () async {
    when(mockFirebaseAuth.createUserWithEmailAndPassword(
            email: 'testingflutterapp@gmail.com', password: '123456'))
        .thenAnswer((realInvocation) =>
            throw FirebaseAuthException(code: null, message: 'error'));

    expect(
        await auth.signUp(
            email: 'testingflutterapp@gmail.com', password: '123456'),
        'error');
  });

  // // SIGN OUT
  // test('logout', () async {
  //   when(mockFirebaseAuth.signOut()).thenAnswer((realInvocation) => null);

  //   expect(await auth.signOut(), 'Signed Out');
  // });
  // test('logout exception', () async {
  //   when(mockFirebaseAuth.signOut()).thenAnswer((realInvocation) =>
  //       throw FirebaseAuthException(code: null, message: 'error'));

  //   expect(await auth.signOut(), 'error');
  // });
}
