import UIKit

/// Defines styles related to the bar view in general.
public class DodoBarStyle {
  
  /// The parent style is used to get the property value if the object is missing one.
  var parent: DodoBarStyle?
  
  init(parentStyle: DodoBarStyle? = nil) {
    self.parent = parentStyle
  }
  
  /// Clears the styles for all properties for this style object. The styles will be taken from parent and default properties.
  public func clear() {
    _hideAfterDelaySeconds = nil
    _locationTop = nil
    _marginToSuperview = nil
    _cornerRadius = nil
    _borderWidth = nil
    _borderColor = nil
    _backgroundColor = nil
    _debugMode = nil
    _showAnimator = nil
    _hideAnimator = nil
  }
  
  
  // -----------------------------
  
  
  private var _hideAfterDelaySeconds: NSTimeInterval?
  
  /**
  
  Hides the bar automatically after the specified number of seconds.
  If nil the bar is kept on screen.
  
  */
  public var hideAfterDelaySeconds: NSTimeInterval {
    get {
      return _hideAfterDelaySeconds ?? parent?.hideAfterDelaySeconds ??
        DodoBarDefaultStyles.hideAfterDelaySeconds
    }
    
    set {
      _hideAfterDelaySeconds = newValue
    }
  }
  
  // -----------------------------
  
  private var _hideOnTap: Bool?
  
  /// When true it hides the bar when it is tapped
  public var hideOnTap: Bool {
    get {
      return _hideOnTap ?? parent?.hideOnTap ??
        DodoBarDefaultStyles.hideOnTap
    }
    
    set {
      _hideOnTap = newValue
    }
  }
  
  // -----------------------------
  
  private var _locationTop: Bool?
  
  /// Position of the bar. When true the bar is shown on top of the screen.
  public var locationTop: Bool {
    get {
      return _locationTop ?? parent?.locationTop ?? DodoBarDefaultStyles.locationTop
    }
    
    set {
      _locationTop = newValue
    }
  }
  
  // -----------------------------
  
  private var _marginToSuperview: CGSize?

  /// Margin between the bar edge and its superiew.
  public var marginToSuperview: CGSize {
    get {
      return _marginToSuperview ?? parent?.marginToSuperview ??
        DodoBarDefaultStyles.marginToSuperview
    }
    
    set {
      _marginToSuperview = newValue
    }
  }
  
  // -----------------------------
  
  private var _cornerRadius: CGFloat?
  
  /// Corner radius of bar edges
  public var cornerRadius: CGFloat {
    get {
      return _cornerRadius ?? parent?.cornerRadius ?? DodoBarDefaultStyles.cornerRadius
    }
    
    set {
      _cornerRadius = newValue
    }
  }
  
  // -----------------------------
  
  private var _borderWidth: CGFloat?
  
  /// Border width of the bar.
  public var borderWidth: CGFloat {
    get {
      return _borderWidth ?? parent?.borderWidth ?? DodoBarDefaultStyles.borderWidth
    }
    
    set {
      _borderWidth = newValue
    }
  }
  
  // -----------------------------
  
  private var _borderColor: UIColor?
  
  /// Color of toolbar border.
  public var borderColor: UIColor? {
    get {
      return _borderColor ?? parent?.borderColor ?? DodoBarDefaultStyles.borderColor
    }
    
    set {
      _borderColor = newValue
    }
  }
  
  // -----------------------------
  
  private var _backgroundColor: UIColor?
  
  /// Background color of the bar.
  public var backgroundColor: UIColor? {
    get {
      return _backgroundColor ?? parent?.backgroundColor ?? DodoBarDefaultStyles.backgroundColor
    }
    
    set {
      _backgroundColor = newValue
    }
  }
  
  // -----------------------------
  
  private var _debugMode: Bool?
  
  /// Highlights the view backgrounds for spotting layout issues.
  public var debugMode: Bool {
    get {
      return _debugMode ?? parent?.debugMode ?? DodoBarDefaultStyles.debugMode
    }
    
    set {
      _debugMode = newValue
    }
  }
  
  // ---------------------------
  
  private var _showAnimator: DodoAnimatorX?
  
  /// Callback for animating the bar when it is shown. No animation when nil.
  public var showAnimator: DodoAnimatorX? {
    get {
      return _showAnimator ?? parent?.showAnimator ?? DodoBarDefaultStyles.showAnimator
    }
    
    set {
      _showAnimator = newValue
    }
  }

  // ---------------------------
  
  private var _hideAnimator: DodoAnimatorX?
  
  /// Callback for animating the bar when it is hidden. No animation when nil.
  public var hideAnimator: DodoAnimatorX? {
    get {
      return _hideAnimator ?? parent?.hideAnimator ?? DodoBarDefaultStyles.hideAnimator
    }
    
    set {
      _hideAnimator = newValue
    }
  }
  
  // ---------------------------
}