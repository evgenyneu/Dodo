import UIKit

/**

Default styles for the bar button.
Default styles are used when individual element styles are not set.

*/
public struct DodoButtonDefaultStyles {

  /// Revert the property values to their defaults
  public static func resetToDefaults() {
    accessibilityLabel = _accessibilityLabel
    hideOnTap = _hideOnTap
    horizontalMarginToBar = _horizontalMarginToBar
    icon = _icon
    image = _image
    onTap = _onTap
    size = _size
    tintColor = _tintColor
  }
  
  
  // ---------------------------
  
  
  private static let _accessibilityLabel: String? = nil
  
  /**
  
  This text is spoken by the device when it is in accessibility mode. It is recommended to always set the accessibility label for your button. The text can be a short localized description of the button function, for example: "Close the message", "Reload" etc.
  
  */
  public static var accessibilityLabel = _accessibilityLabel
  
  
  // ---------------------------
  
  
  private static let _hideOnTap = false
  
  /// When true it hides the bar when the button is tapped.
  public static var hideOnTap = _hideOnTap
  
  
  // ---------------------------
  
  
  private static let _horizontalMarginToBar: CGFloat = 10
  
  /// Margin between the bar edge and the button
  public static var horizontalMarginToBar = _horizontalMarginToBar
  
  
  // ---------------------------
  
  private static let _icon: DodoIcons? = nil
  
  /// When set it shows one of the default Dodo icons. Use `image` property to supply a custom image. The color of the image can be changed with `tintColor` property.
  public static var icon = _icon
  
  
  // ---------------------------
  
  
  private static let _image: UIImage? = nil
  
  /// Custom image for the button. One can also use the `icon` property to show one of the default Dodo icons. The color of the image can be changed with `tintColor` property.
  public static var image = _image
  
  
  // ---------------------------

  
  private static let _onTap: DodoButtonOnTap? = nil
  
  /// Supply a function that will be called when user taps the button.
  public static var onTap = _onTap
  
  
  // ---------------------------
  
  
  private static let _size = CGSize(width: 25, height: 25)
  
  /// Size of the button.
  public static var size = _size
  
  
  // ---------------------------

  
  private static let _tintColor: UIColor? = nil
  
  /// Replaces the color of the image or icon. The original colors are used when nil.
  public static var tintColor = _tintColor
  
  
  // ---------------------------
}
