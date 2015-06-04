import UIKit

/// Defines styles related to the text label.
public class SABLabelStyle {
  
  /// The parent style is used to get the property value if the object is missing one.
  var parent: SABLabelStyle?
  
  init(parentStyle: SABLabelStyle? = nil) {
    self.parent = parentStyle
  }
  
  /// Clears the styles for all properties for this style object. The styles will be taken from parent and default properties.
  public func clear() {
    _font = nil
    _color = nil
    _shadowColor = nil
    _shadowOffset = nil
    _numberOfLines = nil
    _horizontalMargin = nil
  }

  // -----------------------------
  
  private var _font: UIFont?
  
  /// Color of the label text.
  public var font: UIFont {
    get {
      return _font ?? parent?.font ?? SABLabelDefaultStyles.font
    }
    
    set {
      _font = newValue
    }
  }
  
  // -----------------------------
  
  private var _color: UIColor?
  
  /// Color of the label text.
  public var color: UIColor {
    get {
      return _color ?? parent?.color ?? SABLabelDefaultStyles.color
    }
    
    set {
      _color = newValue
    }
  }
  
  // -----------------------------
  
  private var _shadowColor: UIColor?
  
  /// Color of text shadow.
  public var shadowColor: UIColor? {
    get {
      return _shadowColor ?? parent?.shadowColor ?? SABLabelDefaultStyles.shadowColor
    }
    
    set {
      _shadowColor = newValue
    }
  }
  
  // -----------------------------
  
  private var _shadowOffset: CGSize?
  
  /// Text shadow offset.
  public var shadowOffset: CGSize {
    get {
      return _shadowOffset ?? parent?.shadowOffset ?? SABLabelDefaultStyles.shadowOffset
    }
    
    set {
      _shadowOffset = newValue
    }
  }
  
  // -----------------------------
  
  private var _numberOfLines: Int?
  
  /// The number of lines in the label.
  public var numberOfLines: Int {
    get {
      return _numberOfLines ?? parent?.numberOfLines ??
        SABLabelDefaultStyles.numberOfLines
    }
    
    set {
      _numberOfLines = newValue
    }
  }
  
  
  // -----------------------------
  
  
  private var _horizontalMargin: CGFloat?
  
  /// Margin between the bar/button edge and the label
  public var horizontalMargin: CGFloat {
    get {
      return _horizontalMargin ?? parent?.horizontalMargin ??
        SABLabelDefaultStyles.horizontalMargin
    }
    
    set {
      _horizontalMargin = newValue
    }
  }
}