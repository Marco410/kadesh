import 'package:graphql_flutter/graphql_flutter.dart';

class ClientGraphQL {
  static Future<GraphQLClient> getClient() async {
    await initHiveForFlutter();
    final HttpLink httpLink = HttpLink(
      'http://localhost:3000/api/graphql',
    );

    final GraphQLClient client = GraphQLClient(
      cache: GraphQLCache(store: HiveStore()),
      link: httpLink,
    );
    return client;
  }
}
