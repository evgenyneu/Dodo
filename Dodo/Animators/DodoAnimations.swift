import UIKit

/// Collection of animation effects use for showing and hiding the notification bar.
public struct DodoAnimations {
  
  /**

  Animation that rotates the bar around X axis in perspective with spring effect. Used for showing the bar.

  :param: view View supplied for animation.
  :param: completed A closure to be called after animation completes.
  
  */
  public static func rotateIn(view: UIView, completed: DodoAnimationCompleted) {
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
      onFinished: completed)
  }
  
  /**

  Animation that swipes the bar to the right with fade-out effect. Used for hiding the bar.
  
  :param: view View supplied for animation.
  :param: completed A closure to be called after animation completes.

  */
  public static func moveOutRight(view: UIView, completed: DodoAnimationCompleted) {
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
        completed()
      }
    )
  }
  
  /**

  A empty animator which is used when no animation is supplied.
  Used to call the completion closure without animation.
  
  :param: view View supplied for animation.
  :param: completed A closure to be called after animation completes.

  */
  public static func noAnimation(view: UIView, completed: DodoAnimationCompleted) {
    completed()
  }
  
  /**
  
  Animation that fades the bar in.
  
  :param: view View supplied for animation.
  :param: completed A closure to be called after animation completes.
  
  */
  public static func fadeIn(view: UIView, completed: DodoAnimationCompleted) {
    fade(true, view: view, completed: completed)
  }
  
  /**
  
  Animation that fades the bar out.
  
  :param: view View supplied for animation.
  :param: completed A closure to be called after animation completes.
  
  */
  public static func fadeOut(view: UIView, completed: DodoAnimationCompleted) {
    fade(false, view: view, completed: completed)
  }
  
  /// Helper function for fading the view in and out.
  private static func fade(showView: Bool, view: UIView, completed: DodoAnimationCompleted) {
    let startAlpha: CGFloat = showView ? 0 : 1
    let endAlpha: CGFloat = showView ? 1 : 0

    view.alpha = startAlpha
    
    UIView.animateWithDuration(0.5,
      animations: {
        view.alpha = endAlpha
      },
      completion: { finished in
        completed()
      }
    )
  }
}