import UIKit
import XCTest

extension XCTest {
  func postKeyboardWillShowNotification(_ keyboardSize: CGSize) {
    let userInfo = keyboardNotificationUserInfo(keyboardSize)

    NotificationCenter.default().post(name: NSNotification.Name.UIKeyboardWillShow,
      object: self, userInfo: userInfo)
  }
  
  func postKeyboardWillHideNotification() {
    let size = CGSize(width: 18, height: 132) // Keyboard hide notification contains the size
    let userInfo = keyboardNotificationUserInfo(size)
    
    NotificationCenter.default().post(name: NSNotification.Name.UIKeyboardWillHide,
      object: self, userInfo: userInfo)
  }
  
  private func keyboardNotificationUserInfo(_ keyboardSize: CGSize) -> [NSObject: AnyObject]{
    let rect = CGRect(origin: CGPoint(), size: keyboardSize)
    let rectValue = NSValue(cgRect: rect)
    
    return [
      UIKeyboardFrameEndUserInfoKey: rectValue,
      UIKeyboardAnimationDurationUserInfoKey: NSNumber(value: 0),
      UIKeyboardAnimationCurveUserInfoKey: NSNumber(value: 0)
    ]
  }
}
