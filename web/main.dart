import 'package:web/helpers.dart';
import 'package:markdown/markdown.dart';
import 'dart:html';

import 'about.dart';
import 'router.dart';

void main() async {
  final Router router = Router();
  final outputElement = querySelector('#output') as DivElement;

  // Set the dynamic title and adjust navigation
  setDynamicTitleAndNavigation();

  // Register routes for both English and Korean
  registerAllRoutes(router, outputElement);

  // Setup a listener for URL changes
  window.onPopState.listen((_) {
    router.route(window.location.pathname);
  });

  // Handle the initial route
  router.route(window.location.pathname);

  // Setup language toggle
  querySelector('#lang_toggle')?.onClick.listen((_) => toggleLanguage());
}

void registerAllRoutes(Router router, DivElement outputElement) {
  // English routes
  router.register(
      '/',
      () => outputElement.text =
          'SpendWise is available on AppStore and Google PlayStore.');
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
    document.title = '현명한소비'; // Korean title
    navEn.style.display = 'none';
    navKo.style.display = 'block';
    toggleButton.text = 'English';
  } else {
    document.title = 'SpendWise'; // English title
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
    outputElement.innerHtml =
        markdownToHtml(markdown, inlineSyntaxes: [InlineHtmlSyntax()]);
  } catch (e) {
    outputElement.text = 'Failed to load markdown content: $e';
  }
}
