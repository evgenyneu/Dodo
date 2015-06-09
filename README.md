🔨🔨🔨 This is work in progress 🔨🔨🔨

# A notification bar for iOS written in Swift

This is a UI widget for showing notification messages in iOS apps. It is useful for showing short messages to the user. Something like: "Message sent", "Note saved", "No Internet connection". 

* A message is shown on top or bottom of the screen.
* It has built-in style presets for common types of messages: success, info, warning and error.
* The bar can have buttons with custom tap handlers.
* Bar styles can be customized.
* Includes customizable animations for showing and hiding the bar.
* There can only be one message displayed at a time.

<img src='https://raw.githubusercontent.com/exchangegroup/Dodo/master/Graphics/Paintings/alices_adventures_in_wonderland.png'
width='300' alt="Illustration fromAlice's Adventures in Wonderland by John Tenniel" >


> At last the Dodo said, `EVERYBODY has won, and all must have prizes.'

From *Alice's Adventures in Wonderland*.

## Usage

### Show and hide notification bar


```Swift
view.dodo.success("Everybody has won and all must have prizes.")
view.dodo.info("Extinction is the rule. Survival is the exception.")
view.dodo.warning("This world is but a canvas to our imagination.")
view.dodo.error("The perception of beauty is a moral test.")

view.dodo.hide()
```

**Note**: if there is an existing notification bar in a UIView it will be replaced by the new one.

<img src='https://raw.githubusercontent.com/exchangegroup/Dodo/master/Graphics/presets/success.jpg'
alt='Dodo success presets' width='414'>

<img src='https://raw.githubusercontent.com/exchangegroup/Dodo/master/Graphics/presets/info.jpg'
alt='Dodo info presets' width='414'>

<img src='https://raw.githubusercontent.com/exchangegroup/Dodo/master/Graphics/presets/warning.jpg'
alt='Dodo warning presets' width='414'>

<img src='https://raw.githubusercontent.com/exchangegroup/Dodo/master/Graphics/presets/error.jpg'
alt='Dodo error presets' width='414'>

### Styling

Use `dodo.style` property to style the notification bar. See the [styling manual](https://github.com/exchangegroup/Dodo/wiki/Styling) for the complete list of configuration options.

```Swift
view.dodo.style.label.color = UIColor.whiteColor()
view.dodo.style.label.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
view.dodo.style.bar.backgroundColor = DodoColor.fromHexString("#00000090")
view.dodo.style.bar.cornerRadius = 0
view.dodo.style.bar.marginToSuperview = CGSize(width: 0, height: 0)
view.dodo.style.bar.hideAfterDelaySeconds = 3
view.dodo.style.bar.hideOnTap = true
view.dodo.style.bar.locationTop = false
```

### Add buttons or icons

```Swift
// Use an icon
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

```Swift
// Use existing animations
view.dodo.style.bar.animationShow = DodoAnimations.Rotate.show
view.dodo.style.bar.animationHide = DodoAnimations.SlideRight.hide

// Turn off animation
view.dodo.style.bar.animationShow = DodoAnimations.NoAnimation.show
```

See [configuring animation wiki page](https://github.com/exchangegroup/Dodo/wiki/Animating) for more information.

## Credits

* Original illustration of Alice's Adventures in Wonderland by John Tenniel, 1865. Source: [Wikimedia Commons](https://commons.wikimedia.org/wiki/File:Alice_par_John_Tenniel_09.png).
* Drawing of White Dodo byFrederick William Frohawk, 1907. Source: [Wikipedia](http://en.m.wikipedia.org/wiki/File:Dodo_reunion-Rothschild_original.jpg).
* Painting of a dodo by Jan Saverij, 1651. Source: [Wikimedia Commons](https://commons.m.wikimedia.org/wiki/File:Jan_Savery_Dodo.jpg#mw-jump-to-license).
* Painting of a dodo head by Cornelis Saftleven, 1638. Source: [Wikimedia Commons](https://commons.m.wikimedia.org/wiki/File:Saftleven_dodo.jpg#mw-jump-to-license).

