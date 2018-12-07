# react-native-onepassword

React Native integration with the OnePassword extension.

## Install

1. Install project as a dependency:

```sh
npm install --save react-native-onepassword
```

2. Link library to Xcode project (see the [React documentation](http://facebook.github.io/react-native/docs/linking-libraries-ios.html#content)).

```sh
react-native link react-native-onepassword
```

3. If your app supports iOS 7.1 or earlier, view the [OnePassword documentation](https://github.com/AgileBits/onepassword-app-extension#projects-supporting-ios-71-and-earlier) for applicable steps.

4. Add the following to your project's `Info.plist`

```xml
<key>LSApplicationQueriesSchemes</key>
<array>
  <string>org-appextension-feature-password-management</string>
</array>
```

## Basic usage

### Public Methods

**isSupported(): Promise**

Checks if the OnePassword extension is available on the current platform.

```js
import OnePassword from 'react-native-onepassword'

try {
  const isSupported = await OnePassword.isSupported()
} catch (e) {
  console.log('OnePassword not installed on this device.')
}
```

**findLogin(url: String): Promise**

Opens the OnePassword extension, filtering the list of logins by the URL you provide.
When the user selects a login, the credentials are passed to the callback function as plain text.

If you are unsure what URL to pass, see the [OnePassword documentation](https://github.com/AgileBits/onepassword-app-extension#best-practices).

```js
import OnePassword from 'react-native-onepassword'

try {
  const creds = await OnePassword.findLogin("https://example.com/login")
  const { username, password } = creds
  console.log(`Found user ${username} with a ${password.length} character password`)
} catch (e) {
  console.warn('User did not choose a login in the OnePassword prompt.')
}
```
