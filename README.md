🔨🔨🔨 This is work in progress 🔨🔨🔨

# Text alert toolbar widget for iOS written in Swift

This is a library for displaying a text alert toolbar. The alert have a multiline message text
and an optional icon button.

## Usage

### Show alert in a UIView

If there is an existing alert in a UIView it will be replaced by the new one.

```Swift
view.swiftAlertBar.show('Hello World!')
```

### Hide alert

```Swift
view.swiftAlertBar.hide()
```

### Show alert with a button

```Swift
view.swiftAlertBar.show('Hello World!', withButton: SwiftAlertBarButtons.Cancel) {
  // Button is tapped
}
```