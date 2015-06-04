import UIKit

/// Combines various styles in the toolbar element.
public class SABStyle {
  
  /// The parent style is used to get the property value if the object is missing one.
  var parent: SABStyle? {
    didSet {
      changeParent()
    }
  }
  
  init(parentStyle: SABStyle? = nil) {
    self.parent = parentStyle
  }
  
  private func changeParent() {
    bar.parent = parent?.bar
    label.parent = parent?.label
    leftButton.parent = parent?.leftButton
    rightButton.parent = parent?.rightButton
  }
  
  /**
  
  Reverts all the default styles to their initial values. Usually used in setUp() function in the unit tests.
  
  */
  public static func resetDefaultStyles() {
    SABBarDefaultStyles.resetToDefaults()
    SABLabelDefaultStyles.resetToDefaults()
    SABButtonDefaultStyles.resetToDefaults()
  }
  
  
  /// Clears the styles for all properties for this style object. The styles will be taken from parent and default properties.
  public func clear() {
    bar.clear()
    label.clear()
    leftButton.clear()
    rightButton.clear()
  }
  
  /**

  Styles for the bar view.

  */
  public lazy var bar: SABBarStyle = self.initBarStyle()
  
  private func initBarStyle() -> SABBarStyle {
    return SABBarStyle(parentStyle: parent?.bar)
  }
  

  /**

  Styles for the text label.

  */
  public lazy var label: SABLabelStyle = self.initLabelStyle()
  
  private func initLabelStyle() -> SABLabelStyle {
    return SABLabelStyle(parentStyle: parent?.label)
  }
  
  /**

  Styles for the left button.

  */
  public lazy var leftButton: SABButtonStyle = self.initLeftButtonStyle()
  
  private func initLeftButtonStyle() -> SABButtonStyle {
    return SABButtonStyle(parentStyle: parent?.leftButton)
  }
  
  /**

  Styles for the right button.

  */
  public lazy var rightButton: SABButtonStyle = self.initRightButtonStyle()
  
  private func initRightButtonStyle() -> SABButtonStyle {
    return SABButtonStyle(parentStyle: parent?.rightButton)
  }
}