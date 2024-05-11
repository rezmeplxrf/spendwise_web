import 'package:web/helpers.dart';
import 'package:markdown/markdown.dart';
import 'dart:html';

import 'about.dart';

void main() {
  final Router router = Router();
  final outputElement = querySelector('#content') as DivElement;
  final bodyElement = querySelector('body') as BodyElement;

  setDynamicTitleAndNavigation();
  registerAllRoutes(router, outputElement);
  bodyElement.style.visibility = 'visible';
  // Setup a listener for URL changes
  window.onPopState.listen((_) {
    router.route(window.location.pathname);
  });
  // Handle the initial route
  router.route(window.location.pathname);
  // Setup language toggle
  querySelector('#lang_toggle')?.onClick.listen((_) => toggleLanguage());
}

/* 
Note: the reason why I am registering all routes is because 
the terms and privacy pages of both languages can be accessed by url like "https://example.com/terms_en" directly 
without having to visiting the root page "https://example.com/" 
*/

void registerAllRoutes(Router router, DivElement outputElement) {
  // English routes

  // root url
  router.register(
      '/', () => redirectToLocalizedAboutPage(router, outputElement));

  router.register('/about_en', () => loadAboutPage(outputElement));
  router.register(
      '/terms_en', () => loadMarkdown('terms/en.md', outputElement));
  router.register(
      '/privacy_en', () => loadMarkdown('privacy/en.md', outputElement));

  // Korean routes
  router.register('/about_ko', () => loadAboutPage(outputElement));
  router.register(
      '/terms_ko', () => loadMarkdown('terms/ko.md', outputElement));
  router.register(
      '/privacy_ko', () => loadMarkdown('privacy/ko.md', outputElement));
}

void redirectToLocalizedAboutPage(Router router, DivElement outputElement) {
  String language = window.navigator.language;
  bool isKorean = language.startsWith('ko');
  if (isKorean) {
    router.route('/about_ko');
  } else {
    router.route('/about_en');
  }
}

void setDynamicTitleAndNavigation() {
  String language = window.navigator.language;
  bool isKorean = language.startsWith('ko');
  updateLanguageUI(isKorean);
}

void updateLanguageUI(bool isKorean) {
  DivElement navEn = querySelector('#nav_en') as DivElement;
  DivElement navKo = querySelector('#nav_ko') as DivElement;
  ButtonElement toggleButton = querySelector('#lang_toggle') as ButtonElement;

  if (isKorean) {
    document.title = '현명한소비';
    navEn.style.display = 'none';
    navKo.style.display = 'block';
    toggleButton.text = 'English';
  } else {
    document.title = 'SpendWise';
    navEn.style.display = 'block';
    navKo.style.display = 'none';
    toggleButton.text = 'Korean';
  }
}

void toggleLanguage() {
  ButtonElement toggleButton = querySelector('#lang_toggle') as ButtonElement;
  bool isCurrentlyKorean = toggleButton.text == 'English';
  updateLanguageUI(!isCurrentlyKorean);
}

void loadMarkdown(String path, DivElement outputElement) async {
  try {
    final markdown = await HttpRequest.getString(path);
    // remove background
    outputElement.style.backgroundColor = 'white';
    outputElement.innerHtml =
        markdownToHtml(markdown, inlineSyntaxes: [InlineHtmlSyntax()]);
  } catch (e) {
    outputElement.text = 'Failed to load the content: $e';
  }
}

class Router {
  final Map<String, Function> _routes = {};

  void register(String routePath, Function callback) {
    _routes[routePath] = callback;
  }

  void route(String path) {
    _routes[path]?.call();
  }
}
