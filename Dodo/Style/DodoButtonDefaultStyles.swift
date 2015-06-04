import UIKit

/**

Default styles for the bar button.
Default styles are used when individual element styles are not set.

*/
public struct DodoButtonDefaultStyles {

  /// Revert the property values to their defaults
  public static func resetToDefaults() {
    image = _image
    accessibilityLabel = _accessibilityLabel
    onTap = _onTap
    size = _size
    tintColor = _tintColor
  }
  
  
  // ---------------------------
  

  private static let _image: UIImage? = nil

  /// Button image. Button only shown when the image is present. The color of the image can be changes with tintColor property.
  public static var image = _image

  
  // ---------------------------
  
  
  private static let _accessibilityLabel: String? = nil
  
  /**

  This text is spoken by the device when it is in accessibility mode. It is recommended to always set the accessibility label for your button. The text can be a short localized description of the button function, for example: "Close", "Reload" etc.

  */
  public static var accessibilityLabel = _accessibilityLabel
  
  
  // ---------------------------
  
  
  private static let _onTap: DodoButtonOnTap? = nil
  
  /// Closure that is called when user taps the button.
  public static var onTap = _onTap
  
  
  // ---------------------------
  
  
  private static let _size = CGSize(width: 25, height: 25)
  
  /// Size of the button.
  public static var size = _size
  
  
  // ---------------------------
  
  
  public static let _horizontalMarginToBar: CGFloat = 10
  
  /// Margin between the bar edge and the button
  public static var horizontalMarginToBar = _horizontalMarginToBar
  
  
  // ---------------------------

  
  public static let _tintColor: UIColor? =  DodoColor.fromHexString("#FFFFFF90")
  
  /// Button tint color. When set it is used to replace the image colors.
  public static var tintColor = _tintColor
}
