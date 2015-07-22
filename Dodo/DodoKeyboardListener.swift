/**

Start listening for keyboard events. Used for moving the message bar from under the keyboard when the bar is shown at the bottom of the screen.

*/
struct DodoKeyboardListener {
  static let underKeyboardLayoutConstraint = UnderKeyboardLayoutConstraint()
  
  static func startListening() {
    // Just access the static property to make it initialize itself lazily if it hasn't been already.
    underKeyboardLayoutConstraint.isAccessibilityElement = false
  }
}