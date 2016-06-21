import UIKit

/**

Coordinates the process of showing and hiding of the message bar.

The instance is created automatically in the `dodo` property of any UIView instance.
It is not expected to be instantiated manually anywhere except unit tests.

For example:

let view = UIView()
view.dodo.info("Horses are blue?")

*/
public protocol DodoInterface: class {  
  /// Specify optional layout guide for positioning the bar view.
  var topLayoutGuide: UILayoutSupport? { get set }
  
  /// Specify optional layout guide for positioning the bar view.
  var bottomLayoutGuide: UILayoutSupport? { get set }
  
  /// Defines styles for the bar.
  var style: DodoStyle { get set }
  
  /// Changes the style preset for the bar widget.
  var preset: DodoPresets { get set }
  
  /**
  
  Shows the message bar with *.success* preset. It can be used to indicate successful completion of an operation.
  
  - parameter message: The text message to be shown.
  
  */
  func success(_ message: String)
  
  /**
  
  Shows the message bar with *.Info* preset. It can be used for showing information messages that have neutral emotional value.
  
  - parameter message: The text message to be shown.
  
  */
  func info(_ message: String)
  
  /**
  
  Shows the message bar with *.warning* preset. It can be used for for showing warning messages.
  
  - parameter message: The text message to be shown.
  
  */
  func warning(_ message: String)
  
  /**
  
  Shows the message bar with *.warning* preset. It can be used for showing critical error messages
  
  - parameter message: The text message to be shown.
  
  */
  func error(_ message: String)
  
  /**
  
  Shows the message bar. Set `preset` property to change the appearance of the message bar, or use the shortcut methods: `success`, `info`, `warning` and `error`.
  
  - parameter message: The text message to be shown.
  
  */
  func show(_ message: String)
  
  /// Hide the message bar if it's currently shown.
  func hide()
}
