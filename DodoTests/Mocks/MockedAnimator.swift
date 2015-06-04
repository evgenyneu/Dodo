import UIKit

class MockedAnimator: SABAnimator {
  var animated = false
  
  func animate(view: UIView, onAnimationCompleted: (()->())? = nil) {
    animated = true
    onAnimationCompleted?()
  }
}