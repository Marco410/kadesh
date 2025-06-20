enum Flavor { dev, prod }

class FlavorConfigOptions {
  final Flavor flavor;
  final String name;

  static FlavorConfigOptions? _instance;

  FlavorConfigOptions._({required this.flavor, required this.name});

  factory FlavorConfigOptions({required Flavor flavor, required String name}) {
    _instance ??= FlavorConfigOptions._(flavor: flavor, name: name);
    return _instance!;
  }

  static FlavorConfigOptions get instance {
    if (_instance == null) {
      throw Exception("FlavorConfigOptions not initialized");
    }
    return _instance!;
  }

  static bool isDev() => instance.flavor == Flavor.dev;

  static bool isProd() => instance.flavor == Flavor.prod;
}
