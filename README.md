🔨🔨🔨 This is work in progress 🔨🔨🔨

# Custom notification UI widget for iOS written in Swift

This is a library for displaying a text notification messages. I can be used to show success messages and validation errors.

## Usage

### Show notification


```Swift
view.dodo.success("Success usually comes to those who are too busy to be looking for it.")
view.dodo.info("Extinction is the rule. Survival is the exception.")
view.dodo.warning("This world is but a canvas to our imagination.")
view.dodo.error("Goodness is the only investment that never fails.")

```

Note: if there is an existing notification message in a UIView it will be replaced by the new one.


### Hide notification

```Swift
view.dodo.hide()
```