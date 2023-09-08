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

Firebase deploy magic builds and deploys the project automatically, but doesn't take extra args.

```shell
firebase deploy
firebase hosting:channel:deploy beta
```

If the indexes have changed on the hosting site it might be a good idea to
run `firebase firestore:indexes` and update the local `firebase.indexes.json`

### Sanity check when formatting a prompt

The prompt data is saved as stringified json in firestore. It's easy to mess up the formatting when
manipulating strings by hand so I am checking my request strings at [dart.dev](https://dart.dev/) before pasting them
into the firestore prompt.request field.

Important: make sure description (the interpolated variable) is escaped.

```dart
import 'dart:convert';


void main() {
  const str = '''
  {
    "prompt": {
      "context": "You are a wine expert. You are asked to describe the style and aroma of a particular wine.",
      "examples": [],
      "messages": [
        {
          "content": "Write one paragraph to describe this particular wine: \${description}"
        }
      ]
    },
    "candidate_count": 3,
    "temperature": 0.5
  }
  ''';
  
  print(jsonEncode(jsonDecode(str)));
}
```

## Attributions

This project borrows ideas, code, and code snippets from some open source projects I would like to
thank the authors for sharing their work.

* [Flutter codelab haiku generator](https://github.com/flutter/codelabs/tree/main/haiku_generator)
* [Andrea Bizzotto starter architecture](https://github.com/bizz84/starter_architecture_flutter_firebase/tree/master)
* more references included in the code

Please reach out if you feel that I used your code without attribution.