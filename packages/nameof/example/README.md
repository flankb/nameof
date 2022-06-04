
# Motivation

Sometimes there is a need to access the names of programming language entities, such as methods, properties, constructors, etc. Unfortunately Flutter has not reflection mechanism. But there is code generation! It is all you need for access to names of code entities with this package.

# Index

- [Motivation](#motivation)

- [Index](#index)
- [How to use](#how-to-use)

  - [Install](#install)

  - [Run the generator](#run-the-generator)
  - [Using Nameof](#creating-a-model-using-Nameof)
 
  - [Configurations](#configurations)
    - [Changing the behavior for a specific model](#changing-the-behavior-for-a-specific-model)
    - [Changing the behavior for the entire project](#changing-the-behavior-for-the-entire-project)

# How to use

## Install
To use [Nameof], you will need your typical [build_runner]/code-generator setup.\
First, install [build_runner] and [Nameof] by adding them to your `pubspec.yaml` file:

If you are using creating a Flutter project:

```console
$ flutter pub add nameof_annotation
$ flutter pub add --dev build_runner
$ flutter pub add --dev nameof
```

If you are using creating a Dart project:

```console
$ dart pub add nameof_annotation
$ dart pub add --dev build_runner
$ dart pub add --dev nameof
```

This installs three packages:

- [build_runner](https://pub.dev/packages/build_runner), the tool to run code-generators
- [nameof], the code generator
- [nameof_annotation](https://pub.dev/packages/nameof_annotation), a package containing annotations for [Nameof].

## Run the generator

To run the code generator, execute the following command:

```
dart run build_runner build
```

For Flutter projects, you can also run:

```
flutter pub run build_runner build
```

Note that like most code-generators, [nameof] will need you to both import the annotation ([nameof_annotation])
and use the `part` keyword on the top of your files.

As such, a file that wants to use [nameof] will start with:

```dart
import 'package:nameof_annotation/nameof_annotation.dart';

part 'my_file.nameof.dart';

```

## Using Nameof

For example we have a class `Car`. For names generation of this class you need to tell generator some instructions with `nameof` annotation:

```dart
@nameof
class Car {
  final double price;
  final double weigth;

  final int year;
  final String model;

  Car(this.price, this.weigth, this.year, this.model);

  Car.sedan(double price, double weigth, int year)
      : this(price, weigth, year, 'Sedan');
}
```

Then you need to run generator [Run the generator](#run-the-generator)

It will generate next code:

```dart
class _$NameofCar {
  const _$NameofCar();
  final String className = 'Car';

  final String constructor = '';
  final String constructorSedan = 'sedan';

  final String fieldPrice = 'price';
  final String fieldWeigth = 'weigth';
  final String fieldYear = 'year';
  final String fieldModel = 'model';
}

const nameofCar = _$NameofCar();
```

Then use it in your code:
```dart
print(nameofCar.fieldPrice);
```

It is simple!

Also you may to use `nameof` annotation for abstract *classes* and *mixins*.