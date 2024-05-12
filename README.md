# Getting Started with Webdev for Statically Generated Webpages

I hope this repo can help you get started with Webdev, which is useful for building statically generated webpages. This is distinct from Flutter web apps. For more comprehensive details, visit the [Dart webdev tool page](https://dart.dev/tools/webdev).

## Disclaimer

This project is still under development, and both the code and UI are not great. The primary purpose of making this project public is to demonstrate to Flutter developers that creating static web pages with Dart is relatively straightforward. Even without prior web development experience (just like I didn't), you might grasp the basics within an hour.

Feel free to modify the code as per your needs or use it to understand how Dart for web functions. However, since the codebase includes my app's actual landing page, privacy policy, and terms of use, please do not use it as is.

## Check out the actual web page (still in development)
https://pacific-nuance-389111.web.app/


## Starting a Project

To create a new project, use:

```bash
dart create -t web [project_name]
```


## Installation

To install necessary packages, run the following commands:

```bash
dart pub add build_runner build_web_compilers --dev
dart pub global activate webdev
```


## If you are new to Web Development

- **HTML File**: Used for the layout of the webpage. You can also include styles and business logic directly within an HTML file or use it only for layout.
- **CSS File**: Optional, used for styling and animations.
- **Dart File**: Primarily for business logic. You can dynamically load text, images, and more.
Note: you can do however you want. You can choose to do everything in html or dart. 
Also, you can easily intergrate existing css libraries just like how you use packages from pub.dev

<br>For example, you can easily use [Bulma CSS](https://bulma.io/) by adding:

```html
<link
  rel="stylesheet"
  href="https://cdn.jsdelivr.net/npm/bulma@1.0.0/css/bulma.min.css"
/>
```d
and use its prebuilt components by using 'class=' in any html element.
```html
<div class="block">
  This text is within a <strong>block</strong>.
</div>
```


## Manipulating HTML with Dart

Manipulating HTML in Dart is actually the same as Javascript.
Here’s how you can interact with HTML elements:

### Example: Select and Manipulate an Element

```dart
final bodyElement = querySelector('body') as BodyElement;
// This selects the body element in the HTML file.
// <body> </body>

// Changing the style of the element
bodyElement.style.backgroundColor = 'blue';

// Modifying text
bodyElement.text = 'Some text';

// or use setInnerHtml() - note: NodeTreeSanitizer.trusted shouldn't be used for user generated contents
bodyElement.setInnerHtml('<p>This is a paragraph added via Dart.</p>', treeSanitizer: NodeTreeSanitizer.trusted);

```

### Trigger Functions on User Actions

```dart
// HTML button
<button id="lang_toggle" onclick="toggleLanguage()">EN/KO</button>

// Dart function listening to the click event
querySelector('#lang_toggle')?.onClick.listen((_) => toggleLanguage());
```

### Loading External Resources

You can load data from local assets or a network:

```dart
void main() async {
  // Using HttpRequest to load data
  String data = await HttpRequest.getString('path/to/data.json');
  print(data);

  // Using Dio for HTTP requests
  final dio = Dio();
  var response = await dio.get('https://api.example.com/data');
  print(response.data);
  // Note: These tags would be part of your HTML file
}

// Directly in HTML
<script src="path/to/file"></script> 
<link rel="stylesheet" href="path/to/file">
<img src="path/to/file"> 
<iframe src="path/to/file"> 
<video src="path/to/file"> 
<audio src="path/to/file">
```


## Routing example of single page webpage

- index.html
```html
<script>
    function navigateTo(event, path) {
      event.preventDefault();
      window.history.pushState({}, '', path);
      window.dispatchEvent(new PopStateEvent('popstate'));
    }
  </script>
  <nav id="nav" style="visibility: hidden;">
    <div id="nav_links">
      <div id="nav_en">
        <a href="/about_en" onclick="navigateTo(event, '/about_en')">About</a>
        <a href="/terms_en" onclick="navigateTo(event, '/terms_en')">Terms of Service</a>
        <a href="/privacy_en" onclick="navigateTo(event, '/privacy_en')">Privacy Policy</a>
      </div>
      <div id="nav_ko">
        <a href="/about_ko" onclick="navigateTo(event, '/about_ko')">소개</a>
        <a href="/terms_ko" onclick="navigateTo(event, '/terms_ko')">이용약관</a>
        <a href="/privacy_ko" onclick="navigateTo(event, '/privacy_ko')">개인정보처리방침</a>
      </div>
      <button id="lang_toggle" onclick="toggleLanguage()">EN/KO</button>
    </div>
  </nav>
```

- main.dart
```dart
class Router {
  final Map<String, Function> _routes = {};

  void register(String routePath, Function callback) {
    _routes[routePath] = callback;
  }

  void route(String path) {
    _routes[path]?.call();
  }
}

void main() {
      final Router router = Router();
  final outputElement = querySelector('#content') as DivElement;
  registerAllRoutes(router, outputElement);
   window.onPopState.listen((_) {
    router.route(window.location.pathname);
  });
  // Handle the initial route
  router.route(window.location.pathname);
  // Setup language toggle
  querySelector('#lang_toggle')?.onClick.listen((_) => toggleLanguage());
}

void registerAllRoutes(Router router, DivElement outputElement) {
  router.register(
      '/', () => redirectToLocalizedAboutPage(router, outputElement));

  // English routes
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

```

- If you don't want it to be a single page web, then you can create a folder in /web then create another index.html


## Compiling
```bash
webdev build
```

## Deploying to Firebase Hosting

To deploy your project to Firebase Hosting, follow these steps:

```bash
firebase init
firebase login
firebase deploy --only hosting
```
