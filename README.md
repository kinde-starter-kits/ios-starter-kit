# Kinde Starter Kits - iOS

The [Kinde iOS Starter Kits](https://github.com/kinde-starter-kits/ios-starter-kit) are simple apps
that demonstrate how to integrate your app with the Kinde authentication service and management API.

## Register an account on Kinde

To get started set up an account on [Kinde](https://app.kinde.com/register).

## Setup your local environment

Clone this repo.

This workspace contains two iOS starter kits:

- KindeAuth - a simple app demonstrating use of the Kinde Auth service for login, authenticated API call to the Kinde Management API, and logout.
  KindeAuth is implemented with [SwiftUI](https://developer.apple.com/documentation/swiftui/), using programmatic view layout.
- KindeAuthUIKit - a simple app also demonstrating use of the Kinde Auth service,
  implemented in [UIKit](https://developer.apple.com/documentation/uikit) designed using a Storyboard.

To setup either example project, run `pod install` in the app directory first.

Then find this configuration block in the `KindeAuth.plist` file(s):

```
<dict>
	<key>Issuer</key>
	<string>https://<your_subdomain>.kinde.com</string>
	<key>ClientId</key>
	<string><your_kinde_client_id></string>
	<key>RedirectUri</key>
	<string><your-url-scheme>://kinde_callback</string>
	<key>PostLogoutRedirectUri</key>
	<string><your-url-scheme>://kinde_logoutcallback</string>
	<key>Scope</key>
	<string>offline openid email profile</string>
</dict>
```

In the configuration block above replace the following placeholders with values from your Kinde [App Keys](https://kinde.com/docs/the-basics/getting-app-keys) page:

- `https://<your_subdomain>.kinde.com` with the `Token host` value
- `<your_kinde_client_id>` with the `Client ID` value.

## Set your Callback and Logout URLs

Your user will be redirected to Kinde to authenticate. After they have logged in or registered they will be redirected back to your iOS app.

You need to specify in Kinde which url you would like your user to be redirected to in order to authenticate your app.

On the App Keys page set `Allowed callback URLs` to `<your-url-scheme>://kinde_callback`, where `your_url_scheme` can be any valid custom url scheme,
such as your app's bundle ID or an abbreviation.

> Important! This is required for your users to successfully log in to your app.

You will also need to set the url they will be redirected to upon logout. Set the `Allowed logout redirect URLs` to `<your-url-scheme>://kinde_logoutcallback`.

## Start your app

Start your app in XCode, click on `Sign up` and register your first user for your business!

## View users in Kinde

If you navigate to the "Users" page within Kinde you will see your newly registered user there. 🚀
