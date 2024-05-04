import 'dart:html';

void loadAboutPage(DivElement outputElement) {
  outputElement.innerHtml = '''
    <div id="app-promotion">
      <h1>Welcome to SpendWise</h1>
      <p>Manage your expenses smartly with our easy-to-use app!</p>
      <div id="carousel" class="scrolling-wrapper">
        <img src="http://127.0.0.1:56498/about/test.jpg" alt="App Screenshot 1" style="width:100%">
        <img src="http://127.0.0.1:56498/about/test2.jpg" alt="App Screenshot 2" style="width:100%">
      </div>
      <div id="additional-images">
        <img src="http://127.0.0.1:56498/about/test.jpg" alt="App Screenshot 3" style="width:100%">
      </div>
      <p>Available on both Android and iOS platforms.</p>
      <a href="https://play.google.com/store/apps/details?id=example.spendwise" target="_blank">
        <img src="assets/google_play.png" alt="Google Play Store">
      </a>
      <a href="https://apps.apple.com/app/id123456789" target="_blank">
        <img src="assets/app_store.png" alt="Apple App Store">
      </a>
    </div>
  ''';

  addCustomStyles();
}

void addCustomStyles() {
  StyleElement style = StyleElement();
  style.innerHtml = '''
    #app-promotion h1 {
      color: #2c3e50;
      text-align: center;
    }
    #app-promotion p {
      text-align: center;
      font-size: 18px;
      color: #34495e;
    }
    .scrolling-wrapper {
      overflow-x: auto;
      white-space: nowrap;
      text-align: center;
      padding: 20px 0;
    }
    .scrolling-wrapper img {
      display: inline-block;
      width: calc(100% - 20px); /* 100% minus padding for mobile */
      max-width: 100%; /* To prevent overflow */
      margin: 0 10px;
      border-radius: 8px;
      box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    }
    #additional-images img, #additional-images2 img {
      width: calc(100% - 20px); /* 100% minus margins for mobile */
      margin: 10px;
      border-radius: 8px;
      box-shadow: 0 4px 8px rgba(0,0,0,0.1);
      display: block; /* To take full line */
      box-sizing: border-box; /* Include padding and borders in width */
    }
    #app-promotion a img {
      width: 150px;
      margin: 20px;
    }

    /* Desktop Specific Styles */
    @media (min-width: 768px) {
      .scrolling-wrapper img {
        width: calc(80%); /* Increased padding for desktop */
        margin: 0 100px; /* Increased margin for desktop */
      }
      #additional-images img, #additional-images2 img {
        width: calc(80%); /* 100% minus margins for desktop */
        margin: 100px; /* Increased margin for desktop */
      }
    }
  ''';
  document.head?.append(style);
}
