import UIKit

/// Collection of animation effects use for hiding the notification bar.
public struct DodoAnimationsHide {
  /**
  
  Animation that rotates the bar around X axis in perspective with spring effect.
  
  :param: view View supplied for animation.
  :param: completed A closure to be called after animation completes.
  
  */
  public static func rotate(view: UIView, locationTop: Bool, completed: DodoAnimationCompleted) {
    DodoAnimations.rotate(false, view: view, completed: completed)
  }
  
  /**
  
  Animation that swipes the bar from to the left with fade-in effect.
  
  :param: view View supplied for animation.
  :param: completed A closure to be called after animation completes.
  
  */
  public static func slideLeft(view: UIView, locationTop: Bool, completed: DodoAnimationCompleted) {
    DodoAnimations.slide(false, showView: false, view: view, completed: completed)
  }
  
  /**
  
  Animation that swipes the bar to the right with fade-out effect.
  
  :param: view View supplied for animation.
  :param: completed A closure to be called after animation completes.
  
  */
  public static func slideRight(view: UIView, locationTop: Bool, completed: DodoAnimationCompleted) {
    DodoAnimations.slide(true, showView: false, view: view, completed: completed)
  }
  
  /**
  
  Animation that fades the bar out.
  
  :param: view View supplied for animation.
  :param: completed A closure to be called after animation completes.
  
  */
  public static func fade(view: UIView, locationTop: Bool, completed: DodoAnimationCompleted) {
    DodoAnimations.fade(false, view: view, completed: completed)
  }
  
  /**
  
  Animation that slides the bar vertically out of view.
  
  :param: view View supplied for animation.
  :param: completed A closure to be called after animation completes.
  
  */
  public static func slideVertically(view: UIView, locationTop: Bool,
    completed: DodoAnimationCompleted) {
      
    DodoAnimations.slideVertically(false, view: view, locationTop: locationTop, completed: completed)
  }
}