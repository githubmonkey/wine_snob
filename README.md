# wine_snob

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Deploy to firebase hosting

For now the project needs to have some secrets added as a commandline parameter. This is a problem
for the new experimental firebase deploy magic which builds and deploys the project automatically,
but doesn't take extra args.

Until the dependence on dart-define is removed I have changed firebase.json to use `public` rather
than `source` which means that I have to manually build the project before letting firebase deploy
it.

This [issue](https://github.com/firebase/firebase-tools/issues/5941) has some context.

```
flutter build web --dart-define-from-file=android/keys/api-keys.json
firebase deploy
```