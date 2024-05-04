import 'package:web/helpers.dart';
import 'package:markdown/markdown.dart';
import 'dart:html';

import 'router.dart';

void main() async {
  final Router router = Router();
  final outputElement = querySelector('#output') as DivElement;

  // Set the dynamic title
  setDynamicTitle();

  // Register route
  router.register(
      '/terms_ko', () => loadMarkdown('terms/ko.md', outputElement));
  router.register(
      '/terms_en', () => loadMarkdown('terms/en.md', outputElement));
  router.register(
      '/privacy_ko', () => loadMarkdown('privacy/ko.md', outputElement));
  router.register(
      '/privacy_en', () => loadMarkdown('privacy/en.md', outputElement));

  // Setup a listener for URL changes
  window.onPopState.listen((_) {
    router.route(window.location.pathname);
  });

  // Handle the initial route
  router.route(window.location.pathname);
}

void setDynamicTitle() {
  String language = window.navigator.language;
  if (language.startsWith('ko')) {
    document.title = '현명한소비 정책 안내'; // Korean title
  } else {
    document.title = 'SpendWise\'s Policies'; // Default title in English
  }
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
