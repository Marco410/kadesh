import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ClientGraphQL {
  static Future<GraphQLClient> getClient() async {
    await initHiveForFlutter();
    final HttpLink httpLink = HttpLink(
      dotenv.env['API_LINK']!,
    );

    final GraphQLClient client = GraphQLClient(
      cache: GraphQLCache(store: HiveStore()),
      link: httpLink,
    );
    return client;
  }
}
