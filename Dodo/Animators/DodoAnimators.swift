/**

Collection of animation presets that can be assigned to `style.showAnimator` and `shile.hideAnimator'

*/
public struct DodoAnimators {
  
  /// Rotates the bar around X axis in perspective with spring effect. Used for showing the bar.
  public static func rotateIn(view: UIView, onAnimationCompleted: DodoAnimationCompleted) {
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
  
  /// Swipes the bar to the right with fade-out effect. Used for hiding the bar.
  public static func moveToRightOut(view: UIView, onAnimationCompleted: DodoAnimationCompleted) {
    UIView.animateWithDuration(0.4, delay: 0,
      options: UIViewAnimationOptions.CurveEaseOut,
      animations: {
        // Swipe to the right
        let screenWidth = UIScreen.mainScreen().bounds.width
        view.frame.origin.x = screenWidth
        
        // Make less opaque
        view.alpha = 0.2
      },
      completion: { finished in
        onAnimationCompleted()
      }
    )
  }
}