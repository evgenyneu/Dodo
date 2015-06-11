import UIKit

/**

The class can be used in unit tests to verify the messages that were shown by the app.

    // Supply mock to the view
    let dodoMock = DodoMock()
    view.dodo = dodoMock

    runSomeAppCode()

    // Verify the messages
    XCTAssertEqual(1, dodoMock.results.success.count)
    XCTAssertEqual("To be prepared is half the victory.", dodoMock.results.success[0])

*/
public class DodoMock: DodoInterface {
  /// This property is used in unit tests to verify which messages were displayed in the message bar.
  public var results = DodoMockResults()
  
  public var topLayoutGuide: UILayoutSupport?
  public var bottomLayoutGuide: UILayoutSupport?
  public var style = DodoStyle(parentStyle: DodoPresets.defaultPreset.style)
  
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
  }
  
  public func hide() { }
}