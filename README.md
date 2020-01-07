# react-native-onepassword

React Native integration with the OnePassword extension.

## Install

1. Install project as a dependency:

```
npm install --save react-native-onepassword
```

2. Install with Cocoapods

```
cd ios
pod install
```

# Manually 

Link library to Xcode project (see the [React documentation](http://facebook.github.io/react-native/docs/linking-libraries-ios.html#content)).

If your app supports iOS 7.1 or earlier, view the [OnePassword documentation](https://github.com/AgileBits/onepassword-app-extension#projects-supporting-ios-71-and-earlier) for applicable steps.

## Basic usage

### Public Methods

**isSupported(): Promise**  
Checks if the OnePassword extension is availabile on the current platform.

```
var OnePassword = require("react-native-onepassword");
OnePassword.isSupported()
    .then(
        () => {
            console.log("OnePassword app is installed and ready!")
        },
        () => {
            console.log("OnePassword not available.");
        }
    );
```

**findLogin(url:String): Promise**  
Opens the OnePassword extension, filtering the list of logins by the URL you provide. When the user selects a login, the credentials are passed to the callback function as plaintext.

If you are unsure what URL to pass, see the [OnePassword documentation](https://github.com/AgileBits/onepassword-app-extension#best-practices).

```
OnePassword.findLogin("https://example.com/login")
.then((credentials) => {
    // User selected a login.
    doSomethingWith(credentials.username);
    doSomethingElseWith(credentials.password);
})
```
