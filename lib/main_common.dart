import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:kadesh/data/routes/app_router.dart';
import 'package:kadesh/data/share_prefs/prefs_usuario.dart';
import 'package:kadesh/data/theme/theme_style.dart';
import 'package:kadesh/domain/services/client_service.dart';
import 'package:kadesh/flavors/flavor_config.dart';
import 'package:sizer_pro/sizer.dart';
import 'package:toastification/toastification.dart';

Future<void> mainCommon({required Flavor flavor, required String name}) async {
  FlavorConfigOptions(flavor: flavor, name: name);

  WidgetsFlutterBinding.ensureInitialized();
  final prefs = PreferenciasUsuario();
  await prefs.initPrefs();

  FlavorConfig(
    name: name,
    color: FlavorConfigOptions.isDev() ? Colors.red : Colors.blue,
    location: BannerLocation.topStart,
    variables: {},
  );

   await Firebase.initializeApp(
    options: DefaultFirebaseConfig.platformOptions,
  );

  await dotenv.load(
      fileName: FlavorConfigOptions.isDev() ? ".env.dev" : ".env");

  runApp(ProviderScope(
    child: MyApp(
      client: await ClientGraphQL.getClient(),
    ),
  ));
}

class MyApp extends ConsumerStatefulWidget {
  final GraphQLClient client;
  const MyApp({super.key, required this.client});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    final appRouter = ref.watch(appRouterProvider);

    final app = MaterialApp.router(
      title: 'Kadesh',
      theme: appTheme,
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      //darkTheme: CustomThemes.darkTheme,
      //themeMode: EasyDynamicTheme.of(context).themeMode,
      /* builder: BotToastInit(), */
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es'),
      ],
    );

    return GraphQLProvider(
      client: ValueNotifier(widget.client),
      child: Sizer(builder: (context, orientation, deviceType) {
        return ToastificationWrapper(
          child: FlavorConfigOptions.isDev()
              ? FlavorBanner(
                  child: app,
                )
              : app,
        );
      }),
    );
  }
}
