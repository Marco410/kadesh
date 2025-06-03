import 'package:graphql_flutter/graphql_flutter.dart';

String handleGraphQLError(OperationException? error) {
  if (error == null || error.graphqlErrors.isEmpty) {
    return "Ocurrió un error. Intenta más tarde.";
  }

  final graphqlError = error.graphqlErrors.first;

  final code = graphqlError.extensions?['code'];
  final prisma = graphqlError.extensions?['prisma'];
  final target = prisma?['meta']?['target'];

  if (code == 'KS_PRISMA_ERROR' && prisma?['code'] == 'P2002') {
    if (target != null && target.contains('username')) {
      return "Este nombre de usuario ya está en uso. Intenta iniciar sesión.";
    } else if (target != null && target.contains('email')) {
      return "Este correo electrónico ya está en uso. Intenta iniciar sesión.";
    } else {
      return "Error de restricción única.";
    }
  }

  return "Intente de nuevo más tarde.";
}
