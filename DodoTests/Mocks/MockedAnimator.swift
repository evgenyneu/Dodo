import UIKit

class MockedAnimator: DodoAnimator {
  var animated = false
  
  func animate(view: UIView, onAnimationCompleted: (()->())? = nil) {
    animated = true
    onAnimationCompleted?()
  }
}