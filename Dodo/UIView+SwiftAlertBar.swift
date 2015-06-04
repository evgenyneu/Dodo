import UIKit

private var sabAssociationKey: UInt8 = 0

/**

UIView extension for showing an alert bar.

    let view = UIView()
    view.swiftAlertBar.show("Hello World!")

*/
public extension UIView {
  /**
  
  Message bar extension.
  Call `swiftAlertBar.show` to shown an alert bar in the view.
  
      let view = UIView()
      view.swiftAlertBar.show("Hello World!")
  
  */
  public var swiftAlertBar: SwiftAlertBar {
    get {
      if let value = objc_getAssociatedObject(self, &sabAssociationKey) as? SwiftAlertBar {
        return value
      } else {
        let swiftAlertBar = SwiftAlertBar(superview: self)
        
        objc_setAssociatedObject(self, &sabAssociationKey, swiftAlertBar,
          objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN))
        
        return swiftAlertBar
      }
    }
    
    set {
      objc_setAssociatedObject(self, &sabAssociationKey, newValue,
        objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN))
    }
  }
}