import UIKit

/// Collection of animation effects use for showing and hiding the notification bar.
public enum DodoAnimations: String {
  /// Animation that fades the bar in/out.
  case fade = "Fade"
  
  /// Used for showing notification without animation.
  case noAnimation = "No animation"
  
  /// Animation that rotates the bar around X axis in perspective with spring effect.
  case rotate = "Rotate"
  
  /// Animation that swipes the bar to/from the left with fade effect.
  case slideLeft = "Slide left"
  
  /// Animation that swipes the bar to/from the right with fade effect.
  case slideRight = "Slide right"
  
  /// Animation that slides the bar in/out vertically.
  case slideVertically = "Slide vertically"
  
  /**
  
  Get animation function that can be used for showing notification bar.
  
  - returns: Animation function.
  
  */
  public var show: DodoAnimation {
    switch self {
    case .fade:
      return DodoAnimationsShow.fade
      
    case .noAnimation:
      return DodoAnimations.doNoAnimation
      
    case .rotate:
      return DodoAnimationsShow.rotate
      
    case .slideLeft:
      return DodoAnimationsShow.slideLeft
      
    case .slideRight:
      return DodoAnimationsShow.slideRight
      
    case .slideVertically:
      return DodoAnimationsShow.slideVertically
    }
  }
  
  /**
  
  Get animation function that can be used for hiding notification bar.
  
  - returns: Animation function.
  
  */
  public var hide: DodoAnimation {
    switch self {
    case .fade:
      return DodoAnimationsHide.fade
      
    case .noAnimation:
      return DodoAnimations.doNoAnimation
      
    case .rotate:
      return DodoAnimationsHide.rotate
      
    case .slideLeft:
      return DodoAnimationsHide.slideLeft
      
    case .slideRight:
      return DodoAnimationsHide.slideRight
      
    case .slideVertically:
      return DodoAnimationsHide.slideVertically
    }
  }
  
  /**

  A empty animator which is used when no animation is supplied.
  It simply calls the completion closure.
  
  - parameter view: View supplied for animation.
  - parameter completed: A closure to be called after animation completes.

  */
  static func doNoAnimation(_ view: UIView, duration: TimeInterval?, locationTop: Bool,
    completed: DodoAnimationCompleted) {
      
    completed()
  }
  
  /// Helper function for fading the view in and out.
  static func doFade(_ duration: TimeInterval?, showView: Bool, view: UIView,
    completed: @escaping DodoAnimationCompleted) {
      
    let actualDuration = duration ?? 0.5
    let startAlpha: CGFloat = showView ? 0 : 1
    let endAlpha: CGFloat = showView ? 1 : 0

    view.alpha = startAlpha
    
    UIView.animate(withDuration: actualDuration,
      animations: {
        view.alpha = endAlpha
      },
      completion: { finished in
        completed()
      }
    )
  }
  
  /// Helper function for sliding the view vertically
  static func doSlideVertically(_ duration: TimeInterval?, showView: Bool, view: UIView,
    locationTop: Bool, completed: @escaping DodoAnimationCompleted) {
    
    let actualDuration = duration ?? 0.5
    view.layoutIfNeeded()
    
    var distance: CGFloat = 0
      
    if locationTop {
      distance = view.frame.height + view.frame.origin.y
    } else {
      distance = UIScreen.main.bounds.height - view.frame.origin.y
    }
            
    let transform = CGAffineTransform(translationX: 0, y: locationTop ? -distance : distance)
      
    let start: CGAffineTransform = showView ? transform : CGAffineTransform.identity
    let end: CGAffineTransform = showView ? CGAffineTransform.identity : transform
    
    view.transform = start
    
    UIView.animate(withDuration: actualDuration,
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
  static func doRotate(_ duration: TimeInterval?, showView: Bool, view: UIView, completed: @escaping DodoAnimationCompleted) {
    
    let actualDuration = duration ?? 2.0
    let start: Double = showView ? Double(Double.pi / 2) : 0
    let end: Double = showView ? 0 : Double(Double.pi / 2)
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
  static func doSlide(_ duration: TimeInterval?, right: Bool, showView: Bool,
    view: UIView, completed: @escaping DodoAnimationCompleted) {
      
    let actualDuration = duration ?? 0.4
    let distance = UIScreen.main.bounds.width
    let transform = CGAffineTransform(translationX: right ? distance : -distance, y: 0)
    
    let start: CGAffineTransform = showView ? transform : CGAffineTransform.identity
    let end: CGAffineTransform = showView ? CGAffineTransform.identity : transform
    
    let alphaStart: CGFloat = showView ? 0.2 : 1
    let alphaEnd: CGFloat = showView ? 1 : 0.2

    view.transform = start
    view.alpha = alphaStart
      
    UIView.animate(withDuration: actualDuration,
      delay: 0,
      options: UIViewAnimationOptions.curveEaseOut,
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
