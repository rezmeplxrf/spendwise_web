# Getting Started with Webdev for Statically Generated Webpages

This guide will help you get started with Webdev, which is useful for building statically generated webpages. This is distinct from Flutter web apps. For more comprehensive details, visit the [Dart webdev tool page](https://dart.dev/tools/webdev).

## Disclaimer

This project is under development, and both the code and UI are not yet optimized. The primary purpose of making this project public is to demonstrate to Flutter developers that creating static web pages with Dart is relatively straightforward. Even without prior web development experience, you might grasp the basics within an hour.

Feel free to modify the code as per your needs or use it to understand how Dart for web functions. However, since the codebase includes my app's landing page, privacy policy, and terms of use, please do not use it as is.

## Installation

To install necessary packages, run the following commands:

```bash
dart pub add build_runner build_web_compilers --dev
dart pub global activate webdev
```

## Starting a Project

To create a new project, use:

```bash
dart create -t web [project_name]
```

## Introduction to Web Development Components

- **HTML File**: Used for the layout of the webpage. You can include styles and business logic directly within an HTML file.
- **CSS File**: Optional, used for styling and animations.
- **Dart File**: Primarily for business logic, but flexible for various uses.

## Manipulating HTML with Dart

Manipulating HTML in Dart is somewhat akin to web scraping. Here’s how you can interact with HTML elements:

### Example: Select and Manipulate an Element

```dart
final bodyElement = querySelector('body') as BodyElement;
// This selects the body element in the HTML file.
// <body> </body>

// Changing the style of the element
bodyElement.style.backgroundColor = 'blue';

// Modifying text
bodyElement.text = 'Some text';
```

### Trigger Functions on User Actions

```dart
// HTML button
<button id="lang_toggle" onclick="toggleLanguage()">EN/KO</button>

// Dart function listening to the click event
querySelector('#lang_toggle')?.onClick.listen((_) => toggleLanguage());
```

### Loading External Resources

You can load data from assets or a network:

```dart
// Using HttpRequest to fetch data (you can also load local file)
await HttpRequest.getString('path/to/file');

// Using Dio (just like in  Flutter)
final dio = Dio();
await dio.get('path/to/file');

// Directly in HTML
<script src="path/to/file"></script>  <!-- If it's a script -->
<link rel="stylesheet" href="path/to/file">  <!-- If it's CSS -->
<img src="path/to/file">  <!-- If it's an image -->
<iframe src="path/to/file">  <!-- For embeddable content like YouTube videos -->
<video src="path/to/file">  <!-- For direct video loading -->
<audio src="path/to/file">  <!-- For audio -->
```

## Deploying to Firebase Hosting

To deploy your project to Firebase Hosting, follow these steps:

```bash
firebase init
firebase login
firebase deploy --only hosting
```
