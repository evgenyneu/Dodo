import UIKit
import XCTest

extension XCTest {
  func postKeyboardWillShowNotification(_ keyboardSize: CGSize) {
    let userInfo = keyboardNotificationUserInfo(keyboardSize)

    NotificationCenter.default.post(name: UIResponder.keyboardWillShowNotification,
      object: self, userInfo: userInfo)
  }
  
  func postKeyboardWillHideNotification() {
    let size = CGSize(width: 18, height: 132) // Keyboard hide notification contains the size
    let userInfo = keyboardNotificationUserInfo(size)
    
    NotificationCenter.default.post(name: UIResponder.keyboardWillHideNotification,
      object: self, userInfo: userInfo)
    
    
  }
  
  private func keyboardNotificationUserInfo(_ keyboardSize: CGSize) -> [NSObject: AnyObject]{
    let rect = CGRect(origin: CGPoint(), size: keyboardSize)
    let rectValue = NSValue(cgRect: rect)
    
    return [
      UIResponder.keyboardFrameEndUserInfoKey as NSObject: rectValue,
      UIResponder.keyboardAnimationDurationUserInfoKey as NSObject: NSNumber(value: 0),
      UIResponder.keyboardAnimationCurveUserInfoKey as NSObject: NSNumber(value: 0)
    ]
  }
}
