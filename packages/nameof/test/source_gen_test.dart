import 'package:nameof/src/nameof_generator.dart';
import 'package:nameof_annotation/nameof_annotation.dart';
import 'package:source_gen_test/source_gen_test.dart';

Future<void> main() async {
  final reader =
      await initializeLibraryReaderForDirectory('test', 'source_gen_src.dart');

  initializeBuildLogTracking();

  testAnnotatedElements<Nameof>(reader, NameofGenerator({}));
}
