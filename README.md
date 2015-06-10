🔨🔨🔨 This is work in progress 🔨🔨🔨

<img src='https://raw.githubusercontent.com/exchangegroup/Dodo/master/Graphics/buttons/dodo_ios_message_widget_written_in_swift.jpg' alt='Dodo, a message widget for iOS' width='414'>


# Dodo, a message widget for iOS written in Swift

This is a UI widget for showing notification messages in iOS apps. It is useful for showing short messages to the user, something like: "Message sent", "Note saved", "No Internet connection".

* Dodo includes styles for success, info, warning and error type messages.
* The bar can have buttons with custom tap handlers.
* Bar styles can be customized.
* You can provide custom animations for showing and hiding the bar or use one of the default animation presets.

<img src='https://raw.githubusercontent.com/exchangegroup/Dodo/master/Graphics/Paintings/alices_adventures_in_wonderland.png'
width='300' alt="Illustration fromAlice's Adventures in Wonderland by John Tenniel" >


> At last the Dodo said, `EVERYBODY has won, and all must have prizes.'

From *Alice's Adventures in Wonderland*.

## Setup

There are three ways you can add Dodo to your project.

**Add source (iOS 7+)**

Simply add [DodoDistrib.swift](https://github.com/exchangegroup/Dodo/blob/master/Distrib/DodoDistrib.swift) file into your Xcode project.

**Setup with Carthage (iOS 8+)**

Alternatively, add `github "exchangegroup/Dodo" ~> 1.0` to your Cartfile and run `carthage update`.

**Setup with CocoaPods (iOS 8+)**

If you are using CocoaPods add this text to your Podfile and run `pod install`.

    use_frameworks!
    pod 'Dodo', '~> 1.0'


## Usage

Add `import Dodo` to your source code if you used Carthage or CocoaPods setup methods.


### Show and hide notification bar

```Swift
view.dodo.success("Everybody has won and all must have prizes.")
view.dodo.info("Extinction is the rule. Survival is the exception.")
view.dodo.warning("This world is but a canvas to our imagination.")
view.dodo.error("The perception of beauty is a moral test.")

view.dodo.hide()
```

If you are showing the bar in the top view you may need to provide top or bottom layout guides. This will prevent the message from overlapping with the status or the tab bar.

```Swift
view.dodo.topLayoutGuide = topLayoutGuide
view.dodo.bottomLayoutGuide = bottomLayoutGuide
view.dodo.success("Success is how high you bounce when you hit bottom.")
```

<img src='https://raw.githubusercontent.com/exchangegroup/Dodo/master/Graphics/presets/success.jpg'
alt='Dodo success presets' width='414'>

<img src='https://raw.githubusercontent.com/exchangegroup/Dodo/master/Graphics/presets/info.jpg'
alt='Dodo info presets' width='414'>

<img src='https://raw.githubusercontent.com/exchangegroup/Dodo/master/Graphics/presets/warning.jpg'
alt='Dodo warning presets' width='414'>

<img src='https://raw.githubusercontent.com/exchangegroup/Dodo/master/Graphics/presets/error.jpg'
alt='Dodo error presets' width='414'>

### Styling

Set `dodo.style` property to style the notification bar before it is shown. See the [styling manual](https://github.com/exchangegroup/Dodo/wiki/Styling) for the complete list of configuration options.

```Swift
// Set the text color
view.dodo.style.label.color = UIColor.whiteColor()

// Set background color
view.dodo.style.bar.backgroundColor = DodoColor.fromHexString("#00000090")

// Make the bar close after 3 seconds
view.dodo.style.bar.hideAfterDelaySeconds = 3

// Make the bar close when it is tapped
view.dodo.style.bar.hideOnTap = true

// Show bar at the bottom of the screen
view.dodo.style.bar.locationTop = false
```

### Add buttons or icons

```Swift
// Use a built-in icon
view.dodo.style.leftButton.icon = DodoIcons.close

// Supply your image
view.dodo.style.leftButton.image = UIImage(named: "CloseIcon")

// Change button's image color
view.dodo.style.leftButton.tintColor = DodoColor.fromHexString("#FFFFFF90")

// Do something on tap
view.dodo.style.leftButton.onTap = { /* Button tapped */ }

// Close the bar when the button is tapped
view.dodo.style.leftButton.hideOnTap = true
```

<img src='https://raw.githubusercontent.com/exchangegroup/Dodo/master/Graphics/buttons/left_button.jpg'
alt='Dodo bar with left buttons' width='414'>

<img src='https://raw.githubusercontent.com/exchangegroup/Dodo/master/Graphics/buttons/left_and_right_button.jpg'
alt='Dodo bar with right and left buttons' width='414'>

### Customize animation

Configure the bar animation before it is shown. See [configuring animation wiki page](https://github.com/exchangegroup/Dodo/wiki/Animating) for more information.


```Swift
// Use existing animations
view.dodo.style.bar.animationShow = DodoAnimations.Rotate.show
view.dodo.style.bar.animationHide = DodoAnimations.SlideRight.hide

// Turn off animation
view.dodo.style.bar.animationShow = DodoAnimations.NoAnimation.show
```

## Credits

* Original illustration of Alice's Adventures in Wonderland by John Tenniel, 1865. Source: [Wikimedia Commons](https://commons.wikimedia.org/wiki/File:Alice_par_John_Tenniel_09.png).
* Drawing of White Dodo byFrederick William Frohawk, 1907. Source: [Wikipedia](http://en.m.wikipedia.org/wiki/File:Dodo_reunion-Rothschild_original.jpg).
* Painting of a dodo by Jan Saverij, 1651. Source: [Wikimedia Commons](https://commons.m.wikimedia.org/wiki/File:Jan_Savery_Dodo.jpg#mw-jump-to-license).
* Painting of a dodo head by Cornelis Saftleven, 1638. Source: [Wikimedia Commons](https://commons.m.wikimedia.org/wiki/File:Saftleven_dodo.jpg#mw-jump-to-license).

