import UIKit

private var sabAssociationKey: UInt8 = 0

/**

UIView extension for showing a notification widget.

    let view = UIView()
    view.dodo.show("Hello World!")

*/
public extension UIView {
  /**
  
  Message bar extension.
  Call `dodo.show`, `dodo.success`, dodo.error` functions to show a notification widget in the view.
  
      let view = UIView()
      view.dodo.show("Hello World!")
  
  */
  public var dodo: DodoInterface {
    get {
      if let value = objc_getAssociatedObject(self, &sabAssociationKey) as? DodoInterface {
        return value
      } else {
        let dodo = Dodo(superview: self)
        
        objc_setAssociatedObject(self, &sabAssociationKey, dodo,
          objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        
        return dodo
      }
    }
    
    set {
      objc_setAssociatedObject(self, &sabAssociationKey, newValue,
        objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
  }
}
