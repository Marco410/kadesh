class AuthQueries {
  static const String searchUserName = """
  query User(\$where: UserWhereUniqueInput!) {
    user(where: \$where) {
      username
    }
  }

  """;
}
