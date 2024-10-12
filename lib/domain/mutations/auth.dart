class AuthMutations {
  static const String loginMutation = """
  
  mutation AuthenticateUserWithPassword(\$email: String!, \$password: String!) {
  authenticateUserWithPassword(email: \$email, password: \$password) {
    ... on UserAuthenticationWithPasswordSuccess {
      sessionToken
      item {
        name
        lastName
        username
        email
      }
    }
  }
}""";
}
