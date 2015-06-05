import UIKit

/// Collection of animation effects use for hiding the notification bar.
struct DodoAnimationsHide {
  /**
  
  Animation that rotates the bar around X axis in perspective with spring effect.
  
  :param: view View supplied for animation.
  :param: completed A closure to be called after animation completes.
  
  */
  static func rotate(view: UIView, duration: NSTimeInterval?, locationTop: Bool,
    completed: DodoAnimationCompleted) {
      
    DodoAnimations.rotate(duration, showView: false, view: view, completed: completed)
  }
  
  /**
  
  Animation that swipes the bar from to the left with fade-in effect.
  
  :param: view View supplied for animation.
  :param: completed A closure to be called after animation completes.
  
  */
  static func slideLeft(view: UIView, duration: NSTimeInterval?, locationTop: Bool,
    completed: DodoAnimationCompleted) {
      
    DodoAnimations.slide(duration, right: false, showView: false, view: view, completed: completed)
  }
  
  /**
  
  Animation that swipes the bar to the right with fade-out effect.
  
  :param: view View supplied for animation.
  :param: completed A closure to be called after animation completes.
  
  */
  static func slideRight(view: UIView, duration: NSTimeInterval?, locationTop: Bool,
    completed: DodoAnimationCompleted) {
      
    DodoAnimations.slide(duration, right: true, showView: false, view: view, completed: completed)
  }
  
  /**
  
  Animation that fades the bar out.
  
  :param: view View supplied for animation.
  :param: completed A closure to be called after animation completes.
  
  */
  static func fade(view: UIView, duration: NSTimeInterval?, locationTop: Bool,
    completed: DodoAnimationCompleted) {
      
    DodoAnimations.fade(duration, showView: false, view: view, completed: completed)
  }
  
  /**
  
  Animation that slides the bar vertically out of view.
  
  :param: view View supplied for animation.
  :param: completed A closure to be called after animation completes.
  
  */
  static func slideVertically(view: UIView, duration: NSTimeInterval?, locationTop: Bool,
    completed: DodoAnimationCompleted) {
      
      DodoAnimations.slideVertically(duration, showView: false, view: view,
        locationTop: locationTop, completed: completed)
  }
}