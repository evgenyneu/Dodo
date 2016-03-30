import UIKit

/**

Calling tap with closure.

*/
class OnTap: NSObject {
  var closure: ()->()

  init(view: UIView, gesture: UIGestureRecognizer, closure:()->()) {
    self.closure = closure
    super.init()
    view.addGestureRecognizer(gesture)
    view.userInteractionEnabled = true
    gesture.addTarget(self, action: #selector(OnTap.didTap(_:)))
  }

  func didTap(gesture: UIGestureRecognizer) {
    closure()
  }
}