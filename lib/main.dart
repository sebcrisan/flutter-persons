import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

// provider scope
void main() {
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

// The person class
@immutable
class Person {
  final String name;
  final int age;
  final String uuid;

  /// If no uuid, we get default uuid from package
  Person({
    required this.name,
    required this.age,
    String? uuid,
  }) : uuid = uuid ?? const Uuid().v4();

  /// Creates a new person upon updating a person
  Person updated([String? name, int? age]) => Person(
        name: name ?? this.name,
        age: age ?? this.age,
        uuid: uuid,
      );

  /// Returns the display name for a person
  String get displayName => '$name is ($age years old)';

  /// If we do this, we can compare equality of persons
  @override
  bool operator ==(covariant Person other) => uuid == other.uuid;

  /// We also need to be able to provide the hashcode of the uuid in order to compare them
  @override
  int get hashCode => uuid.hashCode;

  /// Alternatively, we could compare multiple fields like this:
  /// @override
  /// int get hashCode => Object.hash(name, age, uuid);

  /// toString for a person returns their name, age and uuid in a string
  @override
  String toString() => 'Person(name: $name, age: $age, uuid: $uuid)';
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Persons App',
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Persons App'),
    );
  }
}

// Home page screen
class MyHomePage extends ConsumerWidget {
  /// Init homepage
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  /// The title of the homepage
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Persons'),
      ),
    );
  }
}
