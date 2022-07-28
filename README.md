# Kinde Swift iOS Starter Kits

The [Kinde Swift iOS Starter Kits](https://github.com/kinde-oss/kinde-auth-swift-ios-starter) are simple apps that demonstrate how to integrate your app with the Kinde authentication service and management API.

## Requirements

- iOS 12.4+
- Xcode 12+
- Swift 5+

## Starter Kits

This workspace contains to two iOS starter kits:

- KindeAuth - a simple app demonstrating use of the Kinde Auth service for login, authenticated API call to the Kinde Management API, and logout. KindeAuth is implemented with [SwiftUI](https://developer.apple.com/documentation/swiftui/), using programmatic view layout.
- KindeAuthUIKit - a simple app also demonstrating use of the Kinde Auth service, implemented in [UIKit](https://developer.apple.com/documentation/uikit) designed using a Storyboard.

To run either example project, run `pod install` in the app directory first. Then configure the Kinde Auth service as detailed in the following section.

## Configuration

The Kinde `Auth` service is configured with an instance of the `Config` class. The example project uses the bundled `KindeAuth.plist` for configuration. Alternatively, configuration can be supplied in JSON format with the bundled `kinde-auth.json`. Enter the values for your [Kinde business](https://kinde.com/docs/the-basics/getting-app-keys): E.g.,

```
{
  "issuer": "https://{your-business}.kinde.com",
  "clientId": "{your-client-id}",
  "redirectUri": "{your-url-scheme}://kinde_callback",
  "postLogoutRedirectUri": "{your-url-scheme}://kinde_logoutcallback",
  "scope": "offline openid"
}
```

Note: `your_url_scheme` can be any valid custom URL scheme, such as your app's bundle ID or an abbreviation.

Before `Auth` can be used, a call to `Auth.configure()` must be made, typically in `AppDelegate` as part of `application(launchOptions)` for a UIKit app, or the `@main` initialization logic for a SwiftUI app. Likewise, if the Kinde Management API client is used, `KindeManagementApiClient.configure()` must be called prior to use.

## Issue Reporting

## Kinde

## License

This project is licensed under the Apache-2.0 license. See the [LICENSE](LICENSE) file for more information.
