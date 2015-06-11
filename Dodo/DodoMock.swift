import UIKit

/**

The class can be used in unit tests to check the messages that were shown by the app.

    let dodoMock = DodoMock()
    view.dodo = dodoMock


*/
public class DodoMock: DodoInterface {
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
//    removeExistingBars()
//    setupHideTimer()
//    
//    var bar = DodoToolbar(witStyle: style)
//    setupHideOnTap(bar)
//    bar.layoutGuide = style.bar.locationTop ? topLayoutGuide : bottomLayoutGuide
//    bar.buttonViewDelegate = self
//    bar.show(inSuperview: superview, withMessage: message)
  }
  
  public func hide() {
//    hideTimer?.cancel()
//    
//    toolbar?.hide(onAnimationCompleted: {})
  }
}