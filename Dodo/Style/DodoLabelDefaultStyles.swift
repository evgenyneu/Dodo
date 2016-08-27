import UIKit

/**

Default styles for the text label.
Default styles are used when individual element styles are not set.

*/
public struct DodoLabelDefaultStyles {
  
  /// Revert the property values to their defaults
  public static func resetToDefaults() {
    color = _color
    font = _font
    horizontalMargin = _horizontalMargin
    numberOfLines = _numberOfLines
    shadowColor = _shadowColor
    shadowOffset = _shadowOffset
  }
  
  // ---------------------------
  
  
  private static let _color = UIColor.white
  
  /// Color of the label text.
  public static var color = _color
  
  
  // ---------------------------
  
  
  private static let _font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)
  
  /// Font of the label text.
  public static var font = _font
  
  
  // ---------------------------

  
  private static let _horizontalMargin: CGFloat = 10
  
  /// Margin between the bar/button edge and the label.
  public static var horizontalMargin = _horizontalMargin
  
  
  // ---------------------------
  
  
  private static let _numberOfLines: Int = 3
  
  /// The maximum number of lines in the label.
  public static var numberOfLines = _numberOfLines
  
  
  // ---------------------------
  
  
  private static let _shadowColor: UIColor? = nil
  
  /// Color of text shadow.
  public static var shadowColor = _shadowColor
  

  // ---------------------------

  
  private static let _shadowOffset = CGSize(width: 0, height: 1)
  
  /// Text shadow offset.
  public static var shadowOffset = _shadowOffset
  
  
  // ---------------------------
}
