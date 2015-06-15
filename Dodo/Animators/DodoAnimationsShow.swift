import UIKit

/// Collection of animation effects use for showing the notification bar.
struct DodoAnimationsShow {
  /**
  
  Animation that rotates the bar around X axis in perspective with spring effect.
  
  - parameter view: View supplied for animation.
  - parameter completed: A closure to be called after animation completes.
  
  */
  static func rotate(view: UIView, duration: NSTimeInterval?,
    locationTop: Bool, completed: DodoAnimationCompleted) {
      
    DodoAnimations.rotate(duration, showView: true, view: view, completed: completed)
  }
  
  /**
  
  Animation that swipes the bar from the left with fade-in effect.
  
  - parameter view: View supplied for animation.
  - parameter completed: A closure to be called after animation completes.
  
  */
  static func slideLeft(view: UIView, duration: NSTimeInterval?, locationTop: Bool,
    completed: DodoAnimationCompleted) {
      
    DodoAnimations.slide(duration, right: false, showView: true, view: view, completed: completed)
  }
  
  /**
  
  Animation that swipes the bar from the right with fade-in effect.
  
  - parameter view: View supplied for animation.
  - parameter completed: A closure to be called after animation completes.
  
  */
  static func slideRight(view: UIView, duration: NSTimeInterval?, locationTop: Bool,
    completed: DodoAnimationCompleted) {
      
    DodoAnimations.slide(duration, right: true, showView: true, view: view, completed: completed)
  }
  
  /**
  
  Animation that fades the bar in.
  
  - parameter view: View supplied for animation.
  - parameter completed: A closure to be called after animation completes.
  
  */
  static func fade(view: UIView, duration: NSTimeInterval?, locationTop: Bool,
    completed: DodoAnimationCompleted) {
      
    DodoAnimations.fade(duration, showView: true, view: view, completed: completed)
  }
  
  /**
  
  Animation that slides the bar in/out vertically.
  
  - parameter view: View supplied for animation.
  - parameter completed: A closure to be called after animation completes.
  
  */
  static func slideVertically(view: UIView, duration: NSTimeInterval?, locationTop: Bool,
    completed: DodoAnimationCompleted) {
      
    DodoAnimations.slideVertically(duration, showView: true, view: view,
      locationTop: locationTop,completed: completed)
  }
}
