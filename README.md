# wine_snob

Wine Snob - become a wine expert with AI

## Getting Started

This project is part of a PaLM API demo. 

## Code generation

The project uses the riverpod code generator. To monitor the source directly and rerun the generator
on chances use

```shell
dart run build_runner watch 
```

## Deploy to firebase hosting

For now the project needs to have some secrets added as a commandline parameter. This is a problem
for the new experimental firebase deploy magic which builds and deploys the project automatically,
but doesn't take extra args.

Until the dependence on dart-define is removed I have changed firebase.json to use `public` rather
than `source` which means that I have to manually build the project before letting firebase deploy
it.

This [issue](https://github.com/firebase/firebase-tools/issues/5941) has some context.

```shell
flutter build web --dart-define-from-file=android/keys/api-keys.json
firebase deploy
```

## Attributions

This project borrows ideas, code, and code snippets from some open source projects I would like to
thank the authors for sharing their work.

* [Flutter codelab haiku generator](https://github.com/flutter/codelabs/tree/main/haiku_generator)
* [Andrea Bizzotto starter architecture](https://github.com/bizz84/starter_architecture_flutter_firebase/tree/master)
* more references included in the code

Please reach out if you feel that I used your code without attribution.