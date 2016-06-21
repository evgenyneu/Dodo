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
    _animationHide = nil
    _animationHideDuration = nil
    _animationShow = nil
    _animationShowDuration = nil
    _backgroundColor = nil
    _borderColor = nil
    _borderWidth = nil
    _cornerRadius = nil
    _debugMode = nil
    _hideAfterDelaySeconds = nil
    _hideOnTap = nil
    _locationTop = nil
    _marginToSuperview = nil
    _onTap = nil
  }
  
  // -----------------------------
  
  private var _animationHide: DodoAnimation?
  
  /// Specify a function for animating the bar when it is hidden.
  public var animationHide: DodoAnimation {
    get {
      return (_animationHide ?? parent?.animationHide) ?? DodoBarDefaultStyles.animationHide
    }
    
    set {
      _animationHide = newValue
    }
  }
  
  // ---------------------------
  
  private var _animationHideDuration: TimeInterval?
  
  /// Duration of hide animation. When nil it uses default duration for selected animation function.
  public var animationHideDuration: TimeInterval? {
    get {
      return (_animationHideDuration ?? parent?.animationHideDuration) ??
        DodoBarDefaultStyles.animationHideDuration
    }
    
    set {
      _animationHideDuration = newValue
    }
  }
  
  // ---------------------------
  
  private var _animationShow: DodoAnimation?
  
  /// Specify a function for animating the bar when it is shown.
  public var animationShow: DodoAnimation {
    get {
      return (_animationShow ?? parent?.animationShow) ?? DodoBarDefaultStyles.animationShow
    }
    
    set {
      _animationShow = newValue
    }
  }
  
  // ---------------------------
  
  private var _animationShowDuration: TimeInterval?
  
  /// Duration of show animation. When nil it uses default duration for selected animation function.
  public var animationShowDuration: TimeInterval? {
    get {
      return (_animationShowDuration ?? parent?.animationShowDuration) ??
        DodoBarDefaultStyles.animationShowDuration
    }
    
    set {
      _animationShowDuration = newValue
    }
  }
  
  // ---------------------------
  
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
  
  private var _borderColor: UIColor?
  
  /// Color of the bar's border.
  public var borderColor: UIColor? {
    get {
      return _borderColor ?? parent?.borderColor ?? DodoBarDefaultStyles.borderColor
    }
    
    set {
      _borderColor = newValue
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
  
  private var _cornerRadius: CGFloat?
  
  /// Corner radius of the bar view.
  public var cornerRadius: CGFloat {
    get {
      return _cornerRadius ?? parent?.cornerRadius ?? DodoBarDefaultStyles.cornerRadius
    }
    
    set {
      _cornerRadius = newValue
    }
  }
  
  // -----------------------------
  
  private var _debugMode: Bool?
  
  /// When true it highlights the view background for spotting layout issues.
  public var debugMode: Bool {
    get {
      return _debugMode ?? parent?.debugMode ?? DodoBarDefaultStyles.debugMode
    }
    
    set {
      _debugMode = newValue
    }
  }
  
  // ---------------------------
  
  private var _hideAfterDelaySeconds: TimeInterval?
  
  /**
  
  Hides the bar automatically after the specified number of seconds.
  If nil the bar is kept on screen.
  
  */
  public var hideAfterDelaySeconds: TimeInterval {
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
  
  /// When true the bar is hidden when user taps on it.
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

  /// Margin between the bar edge and its superview.
  public var marginToSuperview: CGSize {
    get {
      return _marginToSuperview ?? parent?.marginToSuperview ??
        DodoBarDefaultStyles.marginToSuperview
    }
    
    set {
      _marginToSuperview = newValue
    }
  }
  
  // ---------------------------
  
  private var _onTap: DodoBarOnTap?
  
  /// Supply a function that will be called when user taps the bar.
  public var onTap: DodoBarOnTap? {
    get {
      return _onTap ?? parent?.onTap ?? DodoBarDefaultStyles.onTap
    }
    
    set {
      _onTap = newValue
    }
  }
  
  // -----------------------------
}
