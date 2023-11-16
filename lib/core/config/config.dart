class AppConfig {
  AppConfig._();
  static const String githubRedirectUrl = 'https://traka-b796b.firebaseapp.com/__/auth/handler';
  static const String githubClientId =
      String.fromEnvironment('GITHUB_CLIENT_ID');
  static const String githubClientSecret =
      String.fromEnvironment('GITHUB_CLIENT_SECRET');
  static const String githubAuthorizedUrl =
      'https://github.com/login/oauth/authorize';
  static const String githubAccessTokenUrl =
      'https://github.com/login/oauth/access_token';
}
