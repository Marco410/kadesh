import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pet_app/config/routes/app_router.dart';
import 'package:pet_app/config/service/client_service.dart';
import 'package:pet_app/config/theme/theme_style.dart';

void main() async {
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
      child: MaterialApp.router(
        title: 'Kadesh',
        theme: appTheme,
        routerConfig: appRouter,
        /* builder: BotToastInit(), */
        /*   localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ], */
        /* supportedLocales: const [
          Locale('es'),
        ], */
      ),
    );
  }
}
