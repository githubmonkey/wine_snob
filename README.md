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

## Firebase emulators

In debugging mode, I use the firebase emulator suite. 

```shell
firebase emulators:start --import ./data --export-on-exit
```

## Deploy to firebase hosting

Firebase deploy magic  builds and deploys the project automatically, but doesn't take extra args.

```shell
firebase deploy
firebase hosting:channel:deploy beta
```

## Attributions

This project borrows ideas, code, and code snippets from some open source projects I would like to
thank the authors for sharing their work.

* [Flutter codelab haiku generator](https://github.com/flutter/codelabs/tree/main/haiku_generator)
* [Andrea Bizzotto starter architecture](https://github.com/bizz84/starter_architecture_flutter_firebase/tree/master)
* more references included in the code

Please reach out if you feel that I used your code without attribution.