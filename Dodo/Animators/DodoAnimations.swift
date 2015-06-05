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
  
  /// Animation that slides the bar vertically into view.
  case SlideVertically = "Slide vertically"
  
  /**
  
  Get animation function that can be used for showing notification bar.
  
  :returns: Animation function.
  
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
  
  :returns: Animation function.
  
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
  Used to call the completion closure without animation.
  
  :param: view View supplied for animation.
  :param: completed A closure to be called after animation completes.

  */
  static func noAnimation(view: UIView, locationTop: Bool, completed: DodoAnimationCompleted) {
    completed()
  }
  
  /// Helper function for fading the view in and out.
  static func fade(showView: Bool, view: UIView,
    completed: DodoAnimationCompleted) {
      
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
  
  /// Helper function for sliding the view vertically
  static func slideVertically(showView: Bool, view: UIView, locationTop: Bool,
    completed: DodoAnimationCompleted) {
    
    var transform = CGAffineTransformMakeTranslation(0, locationTop ? -100 : 100)
      
    var start: CGAffineTransform = showView ? transform : CGAffineTransformIdentity
    var end: CGAffineTransform = showView ? CGAffineTransformIdentity : transform
    
    view.transform = start
    
    UIView.animateWithDuration(0.5,
      delay: 0,
      usingSpringWithDamping: 1,
      initialSpringVelocity: 1,
      options: nil,
      animations: {
        view.transform = end
      },
      completion: { finished in
        completed()
      }
    )
  }
  
  ///  Animation that rotates the bar around X axis in perspective with spring effect.
  static func rotate(showView: Bool, view: UIView, completed: DodoAnimationCompleted) {
    
    var start: Double = showView ? Double(M_PI / 2) : 0
    var end: Double = showView ? 0 : Double(M_PI / 2)
    var damping = showView ? 0.85 : 3
    
    let myCALayer = view.layer
    
    var transform = CATransform3DIdentity
    transform.m34 = -1.0/200.0
    myCALayer.transform = CATransform3DRotate(transform, CGFloat(end), 1, 0, 0)
    myCALayer.zPosition = 300
    
    SpringAnimation.animate(myCALayer,
      keypath: "transform.rotation.x",
      duration: 2.0,
      usingSpringWithDamping: damping,
      initialSpringVelocity: 1,
      fromValue: start,
      toValue: end,
      onFinished: completed)
  }
  
  /// Animation that swipes the bar to the right with fade-out effect.
  static func slide(right: Bool, showView: Bool, view: UIView, completed: DodoAnimationCompleted) {
    
    let distance = UIScreen.mainScreen().bounds.width
    var transform = CGAffineTransformMakeTranslation(right ? distance : -distance, 0)
    
    var start: CGAffineTransform = showView ? transform : CGAffineTransformIdentity
    var end: CGAffineTransform = showView ? CGAffineTransformIdentity : transform
    
    var alphaStart: CGFloat = showView ? 0.2 : 1
    var alphaEnd: CGFloat = showView ? 1 : 0.2

    view.transform = start
    view.alpha = alphaStart
      
    UIView.animateWithDuration(0.4, delay: 0,
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