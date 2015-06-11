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
  
  public var topLayoutGuide: UILayoutSupport?
  public var bottomLayoutGuide: UILayoutSupport?
  public var style = DodoStyle(parentStyle: DodoPresets.defaultPreset.style)
  
  public init() { }
  
  public var preset: DodoPresets = DodoPresets.defaultPreset {
    didSet {
      if preset != oldValue  {
        style.parent = preset.style
      }
    }
  }
  
  public func success(message: String) {
    preset = .Success
    show(message)
  }
  
  public func info(message: String) {
    preset = .Info
    show(message)
  }
  
  public func warning(message: String) {
    preset = .Warning
    show(message)
  }
  
  public func error(message: String) {
    preset = .Error
    show(message)
  }
  
  public func show(message: String) {
    let mockMessage = DodoMockMessage(preset: preset, message: message)
    results.messages.append(mockMessage)
    results.visible = true
  }
  
  public func hide() {
    results.visible = false
  }
}