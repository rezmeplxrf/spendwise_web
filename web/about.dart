import 'dart:html';
import 'translation.dart';

void loadAboutPage(DivElement outputElement) async {
  bool isKorean = window.location.pathname == '/about_ko';

  try {
    String url = 'about/about.html';
    String aboutHtmlContent = await HttpRequest.getString(url);
    DivElement tempContainer = DivElement();
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
  } catch (e) {
    outputElement.text = 'Failed to load page: $e';
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
    String url = 'about/about.css';
    String aboutCssContent = await HttpRequest.getString(url);
    style.setInnerHtml(aboutCssContent);
    document.head?.append(style);
    querySelector('.container')?.style.visibility = 'visible';
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
