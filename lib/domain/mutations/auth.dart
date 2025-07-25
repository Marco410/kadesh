class AuthMutations {
  static const String loginMutation = """
  
  mutation AuthenticateUserWithPassword(\$email: String!, \$password: String!) {
  authenticateUserWithPassword(email: \$email, password: \$password) {
    ... on UserAuthenticationWithPasswordSuccess {
      sessionToken
      item {
        name
        lastName
        secondLastName
        username
        email
        phone
        role
        profileImage {
          url
        }
        birthday
        age
      }
    }
  }
}""";

  static const String customLoginMutation = """
    mutation CustomAuth(\$email: String!, \$name: String, \$lastName: String) {
      customAuth(email: \$email, name: \$name, lastName: \$lastName) {
        data
        message
        success
      }
    }
  """;

  static const String createUser = """
  
  mutation Mutation(\$data: UserCreateInput!) {
    createUser(data: \$data) {
      name
    }
  }

""";
}
