
import UIKit

/**
 
 This is a sample file that can be used in your ObjC project for showing Dodo messages.
 Extend this file to add other functionality for your app.
 
 Usage example:
 
 1. Import swift code in your ObjC file:
 
 #import "YOUR_PRODUCT_MODULE_NAME-Swift.h"
 
 2. Use Dodo in your ObjC code:
 
   - (void)viewDidLoad {
     [super viewDidLoad];
     
     [DodoObjCBridge style: self.view];
     [DodoObjCBridge topLayoutGuide:self.topLayoutGuide inView:self.view];
     [DodoObjCBridge success: @"Hello from ObjC" inView: self.view];
   }
 */
@objc public class DodoObjCBridge: NSObject {
  /**
   
   Specify optional layout guide for positioning the bar view.
   
   - parameter guide: top layout guide.
   - parameter inView: view where the Dodo message is shown.
   
   */
  public class func topLayoutGuide(guide: UILayoutSupport, inView view: UIView) {
    view.dodo.topLayoutGuide = guide
  }
  
  /**
   
   Shows the message bar with *.success* preset. It can be used to indicate successful completion of an operation.
   
   - parameter message: The text message to be shown.
   - parameter inView: view where the message is shown.
   
   */
  public class func success(message: String, inView view: UIView) {
    view.dodo.success(message)
  }
  
  /**
   
   Shows the message bar with *.error* preset. It can be used for showing critical error messages
   
   - parameter message: The text message to be shown.
   - parameter inView: view where the message is shown.
   
   */
  public class func error(message: String, inView view: UIView) {
    view.dodo.error(message)
  }
  
  /**
   
   Shows the message bar with *.warning* preset. It can be used for for showing warning messages.
   
   - parameter message: The text message to be shown.
   - parameter inView: view where the message is shown.
   
   */
  public class func warning(message: String, inView view: UIView) {
    view.dodo.warning(message)
  }
  
  /**
   
   Shows the message bar with *.Info* preset. It can be used for showing information messages that have neutral emotional value.
   
   - parameter message: The text message to be shown.
   - parameter inView: view where the message is shown.
   
   */
  public class func info(message: String, inView view: UIView) {
    view.dodo.info(message)
  }
  
  /**
   
   Hide the message bar if it's currently open.
   
   - parameter message: The text message to be shown.
   - parameter view: view where the Dodo message is shown.
   
   */
  public class func hide(view: UIView) {
    view.dodo.hide()
  }
  
  /**
   
   Style the message bar for your app here.
   
   - parameter view: view where the Dodo message is shown.
   
   */
  public class func style(view: UIView) {
    view.dodo.style.bar.hideOnTap = true // Example
  }
}
