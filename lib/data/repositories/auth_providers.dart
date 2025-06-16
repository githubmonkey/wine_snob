import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider, AuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_providers.g.dart';

@Riverpod(keepAlive: true)
List<AuthProvider<AuthListener, AuthCredential>> authProviders(
    Ref ref) {
  return [
    EmailAuthProvider(),
    GoogleProvider(
      clientId:
          '512908844356-bjiophd967e8acou6ueq7bu5pn40idu4.apps.googleusercontent.com',
    ),
    //AppleProvider(),
  ];
}
