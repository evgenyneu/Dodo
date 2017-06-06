import UIKit

/**

Calling tap with closure.

*/
class OnTap: NSObject {
  var closure: ()->()

  init(view: UIView, gesture: UIGestureRecognizer, closure: @escaping ()->()) {
    self.closure = closure
    super.init()
    view.addGestureRecognizer(gesture)
    view.isUserInteractionEnabled = true
    gesture.addTarget(self, action: #selector(OnTap.didTap(_:)))
  }

  @objc func didTap(_ gesture: UIGestureRecognizer) {
    closure()
  }
}
