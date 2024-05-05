import 'dart:html';

void loadAboutPage(DivElement outputElement) async {
  try {
    // Fetch the HTML content from about.html
    String url = 'about/about.html';
    String aboutHtmlContent = await HttpRequest.getString(url);

    outputElement.setInnerHtml(aboutHtmlContent);
    addCustomStyles();
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
