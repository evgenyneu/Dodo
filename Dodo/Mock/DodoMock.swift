import UIKit

/**

The class can be used in unit tests to check the messages that were shown by the app.

    let dodoMock = DodoMock()
    view.dodo = dodoMock


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
  
  public func hide() {
//    hideTimer?.cancel()
//    
//    toolbar?.hide(onAnimationCompleted: {})
  }
}