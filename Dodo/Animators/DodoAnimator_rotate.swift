import UIKit

/**

Rotates the bar around X axis in perspective.

*/
struct DodoAnimator_rotate: DodoAnimator {
  func animate(view: UIView, onAnimationCompleted: (()->())? = nil) {
    let myCALayer = view.layer
    
    var transform = CATransform3DIdentity
    transform.m34 = -1.0/200.0
    myCALayer.transform = CATransform3DRotate(transform, CGFloat(0), 1, 0, 0)
    myCALayer.zPosition = 300
    
    SpringAnimation.animate(myCALayer,
      keypath: "transform.rotation.x",
      duration: 2.0,
      usingSpringWithDamping: 0.85,
      initialSpringVelocity: 1,
      fromValue: Double(M_PI / 2),
      toValue: Double(0),
      onFinished: onAnimationCompleted)
  }
}