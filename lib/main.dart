import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pet_app/data/routes/app_router.dart';
import 'package:pet_app/data/share_prefs/prefs_usuario.dart';
import 'package:pet_app/data/theme/themes.dart';
import 'package:pet_app/domain/services/client_service.dart';
import 'package:pet_app/data/theme/theme_style.dart';
import 'package:sizer_pro/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = PreferenciasUsuario();
  await prefs.initPrefs();
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

    return GraphQLProvider(
      client: ValueNotifier(widget.client),
      child: Sizer(builder: (context, orientation, deviceType) {
        return MaterialApp.router(
          title: 'Kadesh',
          theme: appTheme,
          routerConfig: appRouter,
          //darkTheme: CustomThemes.darkTheme,
          //themeMode: EasyDynamicTheme.of(context).themeMode,
          /* builder: BotToastInit(), */
          /*  localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ], */
          /*   supportedLocales: const [
            Locale('es'),
          ], */
        );
      }),
    );
  }
}
