import 'dart:io';
import 'package:args/args.dart';

void main(List<String> arguments) async {
  final parser = ArgParser()
    ..addOption(
      'name',
      abbr: 'n',
      help: 'The name of the module to generate (required).',
    )
    ..addOption(
      'output',
      abbr: 'o',
      help: 'The output directory for the generated module.',
      defaultsTo: 'lib/src/modules',
    )
    ..addFlag(
      'help',
      abbr: 'h',
      negatable: false,
      help: 'Prints this usage information.',
    );

  try {
    final results = parser.parse(arguments);

    if (results['help']) {
      print('Usage: dart run scripts/generate_module.dart [options]\n');
      print(parser.usage);
      exit(0);
    }

    // The module name is required
    if (results['name'] == null) {
      throw ArgumentError('The --name option is required.');
    }

    final moduleName = results['name'] as String;
    final outputDir = results['output'] as String;

    print('Generating module "$moduleName" in "$outputDir"...');

    // Build and run the Mason command
    // The 'module_name' variable is passed as a command-line argument.
    final process = await Process.run(
      'mason',
      [
        'make',
        'getx_module',
        '-o',
        outputDir,
        '--on-conflict',
        'overwrite',
        '--module_name', // The variable expected by the brick
        moduleName,
      ],
      runInShell: true,
    );

    // Show the process output
    stdout.write(process.stdout);
    stderr.write(process.stderr);

    if (process.exitCode == 0) {
      print('\n✅ Module "$moduleName" generated successfully!');
    } else {
      print('\n❌ Error generating module. Mason exited with code ${process.exitCode}.');
    }
    exit(process.exitCode);
  } catch (e) {
    print('Error: ${e.toString()}');
    print('\nUsage: dart run scripts/generate_module.dart [options]\n');
    print(parser.usage);
    exit(1);
  }
}