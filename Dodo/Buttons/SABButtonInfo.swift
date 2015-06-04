import UIKit

/**

Describes the button for the bar.

*/
public struct SABButtonInfo {
  
  public init(image: UIImage, accessibilityLabel: String,
    onTap: (()->())?) {
   
    self.image = image
    self.accessibilityLabel = accessibilityLabel
    self.onTap = onTap
  }
  
  /// Image for the button.
  public let image: UIImage
  
  /// The label is used for accesibility. Examples: "Close", "Reload" etc.
  public let accessibilityLabel: String
  
  /// Optional closure that is called when user taps the button
  public let onTap: (()->())?
}