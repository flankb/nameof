
# Motivation

Sometimes there is a need to access the names of programming language entities, such as methods, properties, constructors, etc. Unfortunately, Flutter does not have a reflection mechanism designed for this purpose. But there is code generation! It is all you need for access to names of code entities with this package.

# Index

- [Motivation](#motivation)

- [Index](#index)
- [How to use](#how-to-use)

  - [Install](#install)

  - [Run the generator](#run-the-generator)
  - [Using Nameof](#using-nameof)
    - [Simple usage](#simple-usage)
    - [Models coverage](#models-coverage)
    - [Override names](#override-names)
    - [NameofKey targets](#nameofkey-targets)
 
  - [Configurations](#configurations)
    - [Changing the behavior for a specific model](#changing-the-behavior-for-a-specific-model)
    - [Changing the behavior for the entire project](#changing-the-behavior-for-the-entire-project)

# How to use

## Install
To use `Nameof`, you will need your typical [build_runner](https://pub.dev/packages/build_runner) code-generator setup.\
First, install [build_runner](https://pub.dev/packages/build_runner) and `Nameof` by adding them to your `pubspec.yaml` file:

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
- [nameof](https://pub.dev/packages/nameof), the code generator
- [nameof_annotation](https://pub.dev/packages/nameof_annotation), a package containing annotations for `Nameof`.

## Run the generator

To run the code generator, execute the following command:

```
dart run build_runner build
```

For Flutter projects, you can also run:

```
flutter pub run build_runner build
```

Note that like most code-generators, [nameof](https://pub.dev/packages/nameof) will need you to both import the annotation ([nameof_annotation](https://pub.dev/packages/nameof_annotation))
and use the `part` keyword on the top of your files.

As such, a file that wants to use [nameof](https://pub.dev/packages/nameof) will start with:

```dart
import 'package:nameof_annotation/nameof_annotation.dart';

part 'my_file.nameof.dart';

```

## Using Nameof

### Simple usage

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
/// Container for names of elements belonging to the [Car] class
abstract class NameofCar {
  static const String className = 'Car';

  static const String constructor = '';
  static const String constructorSedan = 'sedan';

  static const String fieldPrice = 'price';
  static const String fieldWeigth = 'weigth';
  static const String fieldYear = 'year';
  static const String fieldModel = 'model';
}
```

Then use it in your code:
```dart
print(NameofCar.fieldPrice);
```

It is simple!

Also you may to use `nameof` annotation for abstract *classes* and *mixins*.

### Models coverage

You can have very precision setting of coverage of model's members with use coverage settings and `@NameofIgnore` annotation. For example two next configurations will lead to one output.
- First configuration:
```dart
@Nameof(coverage: Coverage.excludeImplicit)
class Itinerary {
  final double longStart;
  final double latStart;

  final double longEnd;
  final double latEnd;

  @nameofKey
  final String name;

  @nameofKey
  final double length;

  Itinerary(this.longStart, this.latStart, this.longEnd, this.latEnd, this.name,
      this.length);
}
```

  - Second configuration:
```dart
@Nameof(coverage: Coverage.includeImplicit)
class Itinerary {
  @nameofIgnore
  final double longStart;
  
  @nameofIgnore
  final double latStart;

  @nameofIgnore
  final double longEnd;
  
  @nameofIgnore
  final double latEnd;

  final String name;
  final double length;

  @nameofIgnore
  Itinerary(this.longStart, this.latStart, this.longEnd, this.latEnd, this.name,
      this.length);
}
```

Output: 

```dart
/// Container for names of elements belonging to the [Itinerary] class
abstract class NameofItinerary {
  static const String className = 'Itinerary';

  static const String fieldName = 'name';
  static const String fieldLength = 'length';
}
```

Take an attention for `coverage` setting, `@nameofKey` and `@nameofIgnore` annotations. 
If you do not set coverage, generator will use  `includeImplicit` setting by default.

### Override names 
If you want override name of element you can do it!
Code:

```dart
@nameof
class Ephemeral {
  @NameofKey(name: 'AbRaCadabra')
  String get flushLight => 'Purple';
}
```

Generator output:
```dart
/// Container for names of elements belonging to the [Ephemeral] class
abstract class NameofEphemeral {
  static const String className = 'Ephemeral';

  static const String constructor = '';

  static const String propertyGetFlushLight = 'AbRaCadabra';
}
```

As can you see property was renamed. Output has `AbRaCadabra` not `flushLight`.

### NameofKey targets

`@NameofKey` annotatition applyed for public fields, methods, properties and constructors.

## Configurations

Nameof offers various options to customize the generated code. For example, you
may want to change coverage behaviour of model.

To do so, there are two possibilities:

### Changing the behavior for a specific model

If you want to customize the generated code for only one specific class,
you can do so by using annotation setting:

```dart
@Nameof(coverage: Coverage.excludeImplicit)
class Empoyee {...}
```

### Changing the behavior for the entire project

Instead of applying your modification to a single class, you may want to apply it to
all Nameof models at the same time.

You can do so by customizing a file called `build.yaml`  
This file is an optional configuration file that should be placed next to your `pubspec.yaml`:

```
project_folder/
  pubspec.yaml
  build.yaml
  lib/
```

There, you will be able to change the same options as the options found in `@Nameof` (see above)
by writing:

```yaml
targets:
  $default:
    builders:
      nameof:
        options:
          coverage: includeImplicit
          
```

Two settings for coverage is available: `includeImplicit` (default) and `excludeImplicit`
