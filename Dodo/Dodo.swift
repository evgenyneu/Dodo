import UIKit

/**

Main class that coordinates the process of showing and hiding of the message bar.

Instance of this class is created automatically in the `dodo` property of any UIView instance.
It is not expected to be instantiated manually anywhere except unit tests.

For example:

    let view = UIView()
    view.dodo.info("Horses are blue?")

*/
final class Dodo: DodoInterface, DodoButtonViewDelegate {
  private weak var superview: UIView!
  private var hideTimer: MoaTimer?
  
  // Gesture handler that hides the bar when it is tapped
  var onTap: OnTap?
  
  /// Specify optional layout guide for positioning the bar view.
  var topLayoutGuide: UILayoutSupport?
  
  /// Specify optional layout guide for positioning the bar view.
  var bottomLayoutGuide: UILayoutSupport?
  
  /// Defines styles for the bar.
  var style = DodoStyle(parentStyle: DodoPresets.defaultPreset.style)

  /// Creates an instance of Dodo class
  init(superview: UIView) {
    self.superview = superview
    
    DodoKeyboardListener.startListening()
  }
  
  /// Changes the style preset for the bar widget.
  var preset: DodoPresets = DodoPresets.defaultPreset {
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
  func success(_ message: String) {
    preset = .success
    show(message)
  }
  
  /**
  
  Shows the message bar with *.Info* preset. It can be used for showing information messages that have neutral emotional value.
  
  - parameter message: The text message to be shown.
  
  */
  func info(_ message: String) {
    preset = .info
    show(message)
  }
  
  /**
  
  Shows the message bar with *.warning* preset. It can be used for for showing warning messages.
  
  - parameter message: The text message to be shown.
  
  */
  func warning(_ message: String) {
    preset = .warning
    show(message)
  }
  
  /**
  
  Shows the message bar with *.warning* preset. It can be used for showing critical error messages
  
  - parameter message: The text message to be shown.
  
  */
  func error(_ message: String) {
    preset = .error
    show(message)
  }
  
  /**
    
  Shows the message bar. Set `preset` property to change the appearance of the message bar, or use the shortcut methods: `success`, `info`, `warning` and `error`.
    
  - parameter message: The text message to be shown.
    
  */
  func show(_ message: String) {
    removeExistingBars()
    setupHideTimer()

    let bar = DodoToolbar(witStyle: style)
    setupHideOnTap(bar)
    bar.layoutGuide = style.bar.locationTop ? topLayoutGuide : bottomLayoutGuide
    bar.buttonViewDelegate = self
    bar.show(inSuperview: superview, withMessage: message)
  }
  
  /// Hide the message bar if it's currently shown.
  func hide() {
    hideTimer?.cancel()
    
    toolbar?.hide({})
  }
  
  func listenForKeyboard() {
    
  }
  
  private var toolbar: DodoToolbar? {
    get {
      return superview.subviews.filter { $0 is DodoToolbar }.map { $0 as! DodoToolbar }.first
    }
  }
  
  private func removeExistingBars() {
    for view in superview.subviews {
      if let existingToolbar = view as? DodoToolbar {
        existingToolbar.removeFromSuperview()
      }
    }
  }
  
  // MARK: - Hiding after delay
  
  private func setupHideTimer() {
    hideTimer?.cancel()
    
    if style.bar.hideAfterDelaySeconds > 0 {
      hideTimer = MoaTimer.runAfter(style.bar.hideAfterDelaySeconds) { [weak self] timer in
        
        DispatchQueue.main.async {
          self?.hide()
        }
      }
    }
  }
  
  // MARK: - Reacting to tap
  
  private func setupHideOnTap(_ toolbar: UIView) {
    onTap = OnTap(view: toolbar, gesture: UITapGestureRecognizer()) { [weak self] in
      self?.didTapTheBar()
    }
  }
  
  /// The bar has been tapped
  private func didTapTheBar() {
    style.bar.onTap?()
    
    if style.bar.hideOnTap {
      hide()
    }
  }
  
  // MARK: - DodoButtonViewDelegate
  
  func buttonDelegateDidTap(_ buttonStyle: DodoButtonStyle) {
    if buttonStyle.hideOnTap {
      hide()
    }
  }
}
