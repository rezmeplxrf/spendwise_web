import 'dart:html';
import 'translation.dart';
import 'dart:js_util' as js_util;

void loadAboutPage(DivElement outputElement) async {
  String language = window.navigator.language;
  bool isKorean =
      (language.startsWith('ko') && window.location.pathname != '/about_en');

  try {
    String url = 'about/about.html';
    String aboutHtmlContent = await HttpRequest.getString(url);
    DivElement tempContainer = DivElement();

    // NodeTreeSanitizer.trusted shouldn't be used if user generated contents are included in that element
    tempContainer.setInnerHtml(aboutHtmlContent,
        treeSanitizer: NodeTreeSanitizer.trusted);
    if (isKorean) {
      translate(tempContainer, true);
    } else {
      translate(tempContainer, false);
    }

    outputElement.setInnerHtml(tempContainer.innerHtml,
        treeSanitizer: NodeTreeSanitizer.trusted);
    outputElement.style.backgroundColor = null;
    addCustomStyles();
    setupFormListener();

    bool shouldRun = true;
    if (window.location.pathname != '/') {
      shouldRun = false;
    }

    initAOS(shouldRun);
  } catch (e) {
    outputElement.text = 'Failed to load page: $e';
  }
}

void initAOS(bool shouldRun) {
  // This demonstrates how to use JS function from Dart
  // Initialize AOS in Dart
  // because AOS has some strange behavior when navigating back to the page where it's supposed to run
  // so this function will make AOS run only when route is in '/' and won't run if in '/about_ko' or '/about_en'

  var aos = js_util.getProperty(js_util.globalThis, 'AOS');
  if (aos != null) {
    var options = js_util.newObject();
    js_util.setProperty(options, 'startEvent', 'DOMContentLoaded');
    js_util.setProperty(options, 'initClassName', 'aos-init');
    js_util.setProperty(options, 'animatedClassName', 'aos-animate');
    js_util.setProperty(options, 'useClassNames', false);
    js_util.setProperty(options, 'offset', -20);
    js_util.setProperty(options, 'delay', 0);
    js_util.setProperty(options, 'duration', 1200);
    js_util.setProperty(options, 'easing', 'ease');
    js_util.setProperty(options, 'once', true);
    js_util.setProperty(options, 'anchorPlacement', 'bottom-center');
    js_util.setProperty(options, 'disable', !shouldRun);

    js_util.callMethod(aos, 'init', [options]);
  } else {
    print('AOS is not defined');
  }
}

void translate(DivElement outputElement, bool isKorean) {
  outputElement.querySelectorAll('[data-translate]').forEach((element) {
    var key = element.getAttribute('data-translate');
    if (isKorean) {
      if (key != null && translationsKo.containsKey(key)) {
        element.text = translationsKo[key]!;
      }
    } else {
      if (key != null && translationEn.containsKey(key)) {
        element.text = translationEn[key]!;
      }
    }
  });
}

void addCustomStyles() async {
  StyleElement style = StyleElement();
  try {
    String path = 'about/about.css';
    String aboutCssContent = await HttpRequest.getString(path);
    style.setInnerHtml(aboutCssContent);
    document.head?.append(style);
    querySelector('.container')?.style.visibility = 'visible';

    final footerElement = querySelector('#footerText') as HtmlElement;
    footerElement.style.visibility = 'visible';
  } catch (e) {
    print(e);
  }
}

void setupFormListener() {
  FormElement form = querySelector('#contactForm') as FormElement;
  form.onSubmit.listen((Event e) async {
    e.preventDefault();
    const supportEmail = "support@rfway.org";
    window.open(
        'mailto:$supportEmail?subject=Inquery about SpendWise&body=', '_email');
  });
}
