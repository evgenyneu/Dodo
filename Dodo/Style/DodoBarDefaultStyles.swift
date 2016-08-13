import UIKit

/**

Default styles for the bar view.
Default styles are used when individual element styles are not set.

*/
public struct DodoBarDefaultStyles {
  
  /// Revert the property values to their defaults
  public static func resetToDefaults() {
    animationHide = _animationHide
    animationHideDuration = _animationHideDuration
    animationShow = _animationShow
    animationShowDuration = _animationShowDuration
    backgroundColor = _backgroundColor
    borderColor = _borderColor
    borderWidth = _borderWidth
    cornerRadius = _cornerRadius
    debugMode = _debugMode
    hideAfterDelaySeconds = _hideAfterDelaySeconds
    hideOnTap = _hideOnTap
    locationTop = _locationTop
    marginToSuperview = _marginToSuperview
    onTap = _onTap
  }
  
  // ---------------------------
  
  
  private static let _animationHide: DodoAnimation = DodoAnimationsHide.rotate
  
  /// Specify a function for animating the bar when it is hidden.
  public static var animationHide: DodoAnimation = _animationHide
  
  
  // ---------------------------
  
  
  private static let _animationHideDuration: TimeInterval? = nil
  
  /// Duration of hide animation. When nil it uses default duration for selected animation function.
  public static var animationHideDuration: TimeInterval? = _animationHideDuration
  
  
  // ---------------------------
  
  
  private static let _animationShow: DodoAnimation = DodoAnimationsShow.rotate
  
  /// Specify a function for animating the bar when it is shown.
  public static var animationShow: DodoAnimation = _animationShow
  
  
  // ---------------------------
  
  
  private static let _animationShowDuration: TimeInterval? = nil
  
  /// Duration of show animation. When nil it uses default duration for selected animation function.
  public static var animationShowDuration: TimeInterval? = _animationShowDuration
  
  
  // ---------------------------
  
  
  private static let _backgroundColor: UIColor? = nil
  
  /// Background color of the bar.
  public static var backgroundColor = _backgroundColor
  
  
  // ---------------------------
  
  
  private static let _borderColor: UIColor? = nil
  
  /// Color of the bar's border.
  public static var borderColor = _borderColor
  
  
  // ---------------------------
  
  
  private static let _borderWidth: CGFloat  = 1 / UIScreen.main.scale
  
  /// Border width of the bar.
  public static var borderWidth = _borderWidth
  
  
  // ---------------------------
  
  
  private static let _cornerRadius: CGFloat = 20
  
  /// Corner radius of the bar view.
  public static var cornerRadius = _cornerRadius
  
  
  // ---------------------------
  
  
  private static let _debugMode = false
  
  /// When true it highlights the view background for spotting layout issues.
  public static var debugMode = _debugMode
  
  
  // ---------------------------
  
  
  private static let _hideAfterDelaySeconds: TimeInterval = 0
  
  /**
  
  Hides the bar automatically after the specified number of seconds.
  The bar is kept on screen indefinitely if the value is zero.
  
  */
  public static var hideAfterDelaySeconds = _hideAfterDelaySeconds
  
  
  // ---------------------------
  
  
  private static let _hideOnTap = false
  
  /// When true the bar is hidden when user taps on it.
  public static var hideOnTap = _hideOnTap
  
  
  // ---------------------------

  
  private static let _locationTop = true
  
  /// Position of the bar. When true the bar is shown on top of the screen.
  public static var locationTop = _locationTop
  

  // ---------------------------
  
  
  private static let _marginToSuperview = CGSize(width: 5, height: 5)
  
  /// Margin between the bar edge and its superview.
  public static var marginToSuperview = _marginToSuperview
  

  // ---------------------------
  
  
  private static let _onTap: DodoBarOnTap? = nil
  
  /// Supply a function that will be called when user taps the bar.
  public static var onTap = _onTap
  
  // ---------------------------
}
