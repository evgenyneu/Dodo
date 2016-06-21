import UIKit

/**

This class is for testing the code that uses Dodo. It helps verifying the messages that were shown in the message bar without actually showing them.

Here is how to use it in your unit test.

1. Create an instance of DodoMock.
2. Set it to the `view.dodo` property of the view.
3. Run the code that you are testing.
4. Finally, verify which messages were shown in the message bar.

Example:

    // Supply mock to the view
    let dodoMock = DodoMock()
    view.dodo = dodoMock

    // Run the code from the app
    runSomeAppCode()

    // Verify the message is visible
    XCTAssert(dodoMock.results.visible)

    // Check total number of messages shown
    XCTAssertEqual(1, dodoMock.results.total)

    // Verify the text of the success message
    XCTAssertEqual("To be prepared is half the victory.", dodoMock.results.success[0])

*/
public class DodoMock: DodoInterface {
  /// This property is used in unit tests to verify which messages were displayed in the message bar.
  public var results = DodoMockResults()
  
  /// Specify optional layout guide for positioning the bar view.
  public var topLayoutGuide: UILayoutSupport?
  
  /// Specify optional layout guide for positioning the bar view.
  public var bottomLayoutGuide: UILayoutSupport?
  
  /// Defines styles for the bar.
  public var style = DodoStyle(parentStyle: DodoPresets.defaultPreset.style)
  
  /// Creates an instance of DodoMock class
  public init() { }
  
  /// Changes the style preset for the bar widget.
  public var preset: DodoPresets = DodoPresets.defaultPreset {
    didSet {
      if preset != oldValue  {
        style.parent = preset.style
      }
    }
  }
  
  /**
   
   Shows the message bar with *.success* preset. It can be used to indicate successful completion of an operation.
   
   - parameter message: The text message to be shown.
   
   */
  public func success(_ message: String) {
    preset = .success
    show(message)
  }
  
  /**
   
   Shows the message bar with *.Info* preset. It can be used for showing information messages that have neutral emotional value.
   
   - parameter message: The text message to be shown.
   
   */
  public func info(_ message: String) {
    preset = .info
    show(message)
  }
  
  /**
   
   Shows the message bar with *.warning* preset. It can be used for for showing warning messages.
   
   - parameter message: The text message to be shown.
   
   */
  public func warning(_ message: String) {
    preset = .warning
    show(message)
  }
  
  /**
   
   Shows the message bar with *.warning* preset. It can be used for showing critical error messages
   
   - parameter message: The text message to be shown.
   
   */
  public func error(_ message: String) {
    preset = .error
    show(message)
  }
  
  /**
   
   Shows the message bar. Set `preset` property to change the appearance of the message bar, or use the shortcut methods: `success`, `info`, `warning` and `error`.
   
   - parameter message: The text message to be shown.
   
   */
  public func show(_ message: String) {
    let mockMessage = DodoMockMessage(preset: preset, message: message)
    results.messages.append(mockMessage)
    results.visible = true
  }
  
  /// Hide the message bar if it's currently shown.
  public func hide() {
    results.visible = false
  }
}
