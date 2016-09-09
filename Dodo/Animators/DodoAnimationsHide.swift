import UIKit

/// Collection of animation effects use for hiding the notification bar.
struct DodoAnimationsHide {
  /**
  
  Animation that rotates the bar around X axis in perspective with spring effect.
  
  - parameter view: View supplied for animation.
  - parameter completed: A closure to be called after animation completes.
  
  */
  static func rotate(_ view: UIView, duration: TimeInterval?, locationTop: Bool,
    completed: @escaping DodoAnimationCompleted) {
      
    DodoAnimations.doRotate(duration, showView: false, view: view, completed: completed)
  }
  
  /**
  
  Animation that swipes the bar from to the left with fade-in effect.
  
  - parameter view: View supplied for animation.
  - parameter completed: A closure to be called after animation completes.
  
  */
  static func slideLeft(_ view: UIView, duration: TimeInterval?, locationTop: Bool,
    completed: @escaping DodoAnimationCompleted) {
      
    DodoAnimations.doSlide(duration, right: false, showView: false, view: view, completed: completed)
  }
  
  /**
  
  Animation that swipes the bar to the right with fade-out effect.
  
  - parameter view: View supplied for animation.
  - parameter completed: A closure to be called after animation completes.
  
  */
  static func slideRight(_ view: UIView, duration: TimeInterval?, locationTop: Bool,
    completed: @escaping DodoAnimationCompleted) {
      
    DodoAnimations.doSlide(duration, right: true, showView: false, view: view, completed: completed)
  }
  
  /**
  
  Animation that fades the bar out.
  
  - parameter view: View supplied for animation.
  - parameter completed: A closure to be called after animation completes.
  
  */
  static func fade(_ view: UIView, duration: TimeInterval?, locationTop: Bool,
    completed: @escaping DodoAnimationCompleted) {
      
    DodoAnimations.doFade(duration, showView: false, view: view, completed: completed)
  }
  
  /**
  
  Animation that slides the bar vertically out of view.
  
  - parameter view: View supplied for animation.
  - parameter completed: A closure to be called after animation completes.
  
  */
  static func slideVertically(_ view: UIView, duration: TimeInterval?, locationTop: Bool,
    completed: @escaping DodoAnimationCompleted) {
      
      DodoAnimations.doSlideVertically(duration, showView: false, view: view,
        locationTop: locationTop, completed: completed)
  }
}
