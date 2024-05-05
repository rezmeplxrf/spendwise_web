import 'dart:html';

void loadAboutPage(DivElement outputElement) async {
    String language = window.navigator.language;
  bool isKorean = language.startsWith('ko');
  
  try {
    // Fetch the HTML content from about.html
     String url = isKorean ? 'about/about_ko.html' : 'about/about_en.html';
    String aboutHtmlContent = await HttpRequest.getString(url);

    outputElement.setInnerHtml(aboutHtmlContent,
        treeSanitizer: NodeTreeSanitizer.trusted);

    addCustomStyles();
    setupFormListener();
  } catch (e) {
    // Handle errors if the file can't be loaded
    outputElement.text = 'Failed to load page: $e';
  }
}

void addCustomStyles() async {
  StyleElement style = StyleElement();
  try {
    String url = 'about/about.css';
    String aboutCssContent = await HttpRequest.getString(url);
    style.setInnerHtml(aboutCssContent);
    document.head?.append(style);
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
