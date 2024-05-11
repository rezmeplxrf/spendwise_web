Here's how to get started with Webdev which can be used to build statically generated webpages (This is different from the Flutter web app). For more details, see https://dart.dev/tools/webdev


### Disclaimer
This project is still in development and I am aware that code and UI are not optimal.
However the reason I opened this project is 
because I just wanted to let flutter devs know that building a static webpages is in Dart is actually not that difficult. 
For your information, I had no prior experience with web development.
You can too probably grasp how it works within an hour.

### Install
dart pub add build_runner build_web_compilers --dev
dart pub global activate webdev

### To start a project
dart create -t web [project_name]

### For those who are not familiar with Web development
html file is for the layout of the webpage. However, you can put anything in html file including style and business logic.
css file is for styling and animation. but it's optional.
dart file is for business logic. but you can do anything with it or without it.

### How to manipulate html in dart
It's similar to how web scraping works. 
Select the element in html.
and then manipulate it.

For example, 
''' final bodyElement = querySelector('body') as BodyElement; '''
This will select the body element in the html file.
''' <body> </body> '''
If you use bodyElement.style you can change the style of the element.
If you use bodyElement.text = 'Some text'; it will create or change the existing text in the element.

Also you can trigger functions written in dart when users do something.
For example, we can create a button in html like:
<button id="lang_toggle" onclick="toggleLanguage()">EN/KO</button>
and then we create toggleLanguage() function in dart, and listen to the click event.
''' querySelector('#lang_toggle')?.onClick.listen((_) => toggleLanguage()); '''

Also you can load any data from the asset or from the network:
''' await HttpRequest.getString('path/to/file'); '''
You can also use dio like you would do in Flutter app:
''' await Dio().get('path/to/file'); '''

or you can directly load it from html like:
''' <script src="path/to/file"></script> ''' (if it's script)
''' <link rel="stylesheet" href="path/to/file"> ''' (if it's css)
''' <img src="path/to/file"> ''' (if it's image)
''' <iframe src="path/to/file"> ''' (if embeddable content from the external source like Youtube)
''' <video src="path/to/file"> ''' (or directly load it if you are allowed to load it)
''' <audio src="path/to/file"> ''' (audio) 




### To deploy to Firebase Hosting
firebase init
firebae login
firebase deploy --only hosting


n 

