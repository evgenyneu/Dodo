import UIKit

/// Combines various styles for the toolbar element.
public class DodoStyle {
  
  /// The parent style is used to get the property value if the object is missing one.
  var parent: DodoStyle? {
    didSet {
      changeParent()
    }
  }
  
  init(parentStyle: DodoStyle? = nil) {
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
    DodoBarDefaultStyles.resetToDefaults()
    DodoLabelDefaultStyles.resetToDefaults()
    DodoButtonDefaultStyles.resetToDefaults()
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
  public lazy var bar: DodoBarStyle = self.initBarStyle()
  
  private func initBarStyle() -> DodoBarStyle {
    return DodoBarStyle(parentStyle: parent?.bar)
  }
  

  /**

  Styles for the text label.

  */
  public lazy var label: DodoLabelStyle = self.initLabelStyle()
  
  private func initLabelStyle() -> DodoLabelStyle {
    return DodoLabelStyle(parentStyle: parent?.label)
  }
  
  /**

  Styles for the left button.

  */
  public lazy var leftButton: DodoButtonStyle = self.initLeftButtonStyle()
  
  private func initLeftButtonStyle() -> DodoButtonStyle {
    return DodoButtonStyle(parentStyle: parent?.leftButton)
  }
  
  /**

  Styles for the right button.

  */
  public lazy var rightButton: DodoButtonStyle = self.initRightButtonStyle()
  
  private func initRightButtonStyle() -> DodoButtonStyle {
    return DodoButtonStyle(parentStyle: parent?.rightButton)
  }
}