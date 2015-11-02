import UIKit

/// Collection of animation effects use for showing and hiding the notification bar.
public enum DodoAnimations: String {
  /// Animation that fades the bar in/out.
  case Fade = "Fade"
  
  /// Used for showing notification without animation.
  case NoAnimation = "No animation"
  
  /// Animation that rotates the bar around X axis in perspective with spring effect.
  case Rotate = "Rotate"
  
  /// Animation that swipes the bar to/from the left with fade effect.
  case SlideLeft = "Slide left"
  
  /// Animation that swipes the bar to/from the right with fade effect.
  case SlideRight = "Slide right"
  
  /// Animation that slides the bar in/out vertically.
  case SlideVertically = "Slide vertically"
  
  /**
  
  Get animation function that can be used for showing notification bar.
  
  - returns: Animation function.
  
  */
  public var show: DodoAnimation {
    switch self {
    case .Fade:
      return DodoAnimationsShow.fade
      
    case .NoAnimation:
      return DodoAnimations.noAnimation
      
    case .Rotate:
      return DodoAnimationsShow.rotate
      
    case .SlideLeft:
      return DodoAnimationsShow.slideLeft
      
    case .SlideRight:
      return DodoAnimationsShow.slideRight
      
    case .SlideVertically:
      return DodoAnimationsShow.slideVertically
    }
  }
  
  /**
  
  Get animation function that can be used for hiding notification bar.
  
  - returns: Animation function.
  
  */
  public var hide: DodoAnimation {
    switch self {
    case .Fade:
      return DodoAnimationsHide.fade
      
    case .NoAnimation:
      return DodoAnimations.noAnimation
      
    case .Rotate:
      return DodoAnimationsHide.rotate
      
    case .SlideLeft:
      return DodoAnimationsHide.slideLeft
      
    case .SlideRight:
      return DodoAnimationsHide.slideRight
      
    case .SlideVertically:
      return DodoAnimationsHide.slideVertically
    }
  }
  
  /**

  A empty animator which is used when no animation is supplied.
  It simply calls the completion closure.
  
  - parameter view: View supplied for animation.
  - parameter completed: A closure to be called after animation completes.

  */
  static func noAnimation(view: UIView, duration: NSTimeInterval?, locationTop: Bool,
    completed: DodoAnimationCompleted) {
      
    completed()
  }
  
  /// Helper function for fading the view in and out.
  static func fade(duration: NSTimeInterval?, showView: Bool, view: UIView,
    completed: DodoAnimationCompleted) {
      
    let actualDuration = duration ?? 0.5
    let startAlpha: CGFloat = showView ? 0 : 1
    let endAlpha: CGFloat = showView ? 1 : 0

    view.alpha = startAlpha
    
    UIView.animateWithDuration(actualDuration,
      animations: {
        view.alpha = endAlpha
      },
      completion: { finished in
        completed()
      }
    )
  }
  
  /// Helper function for sliding the view vertically
  static func slideVertically(duration: NSTimeInterval?, showView: Bool, view: UIView,
    locationTop: Bool, completed: DodoAnimationCompleted) {
    
    let actualDuration = duration ?? 0.5
    view.layoutIfNeeded()
    
    var distance: CGFloat = 0
      
    if locationTop {
      distance = view.frame.height + view.frame.origin.y
    } else {
      distance = UIScreen.mainScreen().bounds.height - view.frame.origin.y
    }
            
    let transform = CGAffineTransformMakeTranslation(0, locationTop ? -distance : distance)
      
    let start: CGAffineTransform = showView ? transform : CGAffineTransformIdentity
    let end: CGAffineTransform = showView ? CGAffineTransformIdentity : transform
    
    view.transform = start
    
    UIView.animateWithDuration(actualDuration,
      delay: 0,
      usingSpringWithDamping: 1,
      initialSpringVelocity: 1,
      options: [],
      animations: {
        view.transform = end
      },
      completion: { finished in
        completed()
      }
    )
  }
  
  static weak var timer: MoaTimer?
  
  /// Animation that rotates the bar around X axis in perspective with spring effect.
  static func rotate(duration: NSTimeInterval?, showView: Bool, view: UIView, completed: DodoAnimationCompleted) {
    
    let actualDuration = duration ?? 2.0
    let start: Double = showView ? Double(M_PI / 2) : 0
    let end: Double = showView ? 0 : Double(M_PI / 2)
    let damping = showView ? 0.85 : 3
    
    let myCALayer = view.layer
    
    var transform = CATransform3DIdentity
    transform.m34 = -1.0/200.0
    myCALayer.transform = CATransform3DRotate(transform, CGFloat(end), 1, 0, 0)
    myCALayer.zPosition = 300
    
    SpringAnimationCALayer.animate(myCALayer,
      keypath: "transform.rotation.x",
      duration: actualDuration,
      usingSpringWithDamping: damping,
      initialSpringVelocity: 1,
      fromValue: start,
      toValue: end,
      onFinished: showView ? completed : nil)
    
    // Hide the bar prematurely for better looks
    timer?.cancel()
    if !showView {
      timer = MoaTimer.runAfter(0.3) { timer in
        completed()
      }
    }
  }
  
  /// Animation that swipes the bar to the right with fade-out effect.
  static func slide(duration: NSTimeInterval?, right: Bool, showView: Bool,
    view: UIView, completed: DodoAnimationCompleted) {
      
    let actualDuration = duration ?? 0.4
    let distance = UIScreen.mainScreen().bounds.width
    let transform = CGAffineTransformMakeTranslation(right ? distance : -distance, 0)
    
    let start: CGAffineTransform = showView ? transform : CGAffineTransformIdentity
    let end: CGAffineTransform = showView ? CGAffineTransformIdentity : transform
    
    let alphaStart: CGFloat = showView ? 0.2 : 1
    let alphaEnd: CGFloat = showView ? 1 : 0.2

    view.transform = start
    view.alpha = alphaStart
      
    UIView.animateWithDuration(actualDuration,
      delay: 0,
      options: UIViewAnimationOptions.CurveEaseOut,
      animations: {
        view.transform = end
        view.alpha = alphaEnd
      },
      completion: { finished in
        completed()
      }
    )
  }
}