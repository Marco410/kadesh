import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() async {
  await initHiveForFlutter();
  final HttpLink httpLink = HttpLink(
    'http://localhost:3000/api/graphql',
  );

  final GraphQLClient client = GraphQLClient(
    cache: GraphQLCache(store: HiveStore()),
    link: httpLink,
  );

  runApp(MyApp(
    client: client,
  ));
}

class MyApp extends StatelessWidget {
  final GraphQLClient client;
  const MyApp({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: ValueNotifier(client),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter & KeystoneJS"),
      ),
      body: Query(
        options: QueryOptions(
          document: gql(r'''
            query Query {
              users {
                name
                email
                id
              }
            }
          '''),
        ),
        builder: (QueryResult result, {fetchMore, refetch}) {
          if (result.hasException) {
            return Text(result.exception.toString());
          }

          if (result.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          print("result.data");
          print(result.data);

          final users = result.data?['users'] ?? [];

          return Container(
            decoration: BoxDecoration(color: Colors.red),
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  title: Text(
                    user['name'],
                    style: TextStyle(color: Colors.white),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}