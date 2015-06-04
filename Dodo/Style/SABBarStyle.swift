import UIKit

/// Defines styles related to the bar view in general.
public class SABBarStyle {
  
  /// The parent style is used to get the property value if the object is missing one.
  var parent: SABBarStyle?
  
  init(parentStyle: SABBarStyle? = nil) {
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
        SABBarDefaultStyles.hideAfterDelaySeconds
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
        SABBarDefaultStyles.hideOnTap
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
      return _locationTop ?? parent?.locationTop ?? SABBarDefaultStyles.locationTop
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
        SABBarDefaultStyles.marginToSuperview
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
      return _cornerRadius ?? parent?.cornerRadius ?? SABBarDefaultStyles.cornerRadius
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
      return _borderWidth ?? parent?.borderWidth ?? SABBarDefaultStyles.borderWidth
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
      return _borderColor ?? parent?.borderColor ?? SABBarDefaultStyles.borderColor
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
      return _backgroundColor ?? parent?.backgroundColor ?? SABBarDefaultStyles.backgroundColor
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
      return _debugMode ?? parent?.debugMode ?? SABBarDefaultStyles.debugMode
    }
    
    set {
      _debugMode = newValue
    }
  }
}