import UIKit

/// Collection of animation effects use for showing the notification bar.
public struct DodoAnimationsShow {
  /**
  
  Animation that rotates the bar around X axis in perspective with spring effect.
  
  :param: view View supplied for animation.
  :param: completed A closure to be called after animation completes.
  
  */
  public static func rotate(view: UIView, locationTop: Bool, completed: DodoAnimationCompleted) {
    DodoAnimations.rotate(true, view: view, completed: completed)
  }
  
  /**
  
  Animation that swipes the bar from the left with fade-in effect.
  
  :param: view View supplied for animation.
  :param: completed A closure to be called after animation completes.
  
  */
  public static func slideLeft(view: UIView, locationTop: Bool, completed: DodoAnimationCompleted) {
    DodoAnimations.slide(false, showView: true, view: view, completed: completed)
  }
  
  /**
  
  Animation that swipes the bar from the right with fade-in effect.
  
  :param: view View supplied for animation.
  :param: completed A closure to be called after animation completes.
  
  */
  public static func slideRight(view: UIView, locationTop: Bool, completed: DodoAnimationCompleted) {
    DodoAnimations.slide(true, showView: true, view: view, completed: completed)
  }
  
  /**
  
  Animation that fades the bar in.
  
  :param: view View supplied for animation.
  :param: completed A closure to be called after animation completes.
  
  */
  public static func fade(view: UIView, locationTop: Bool, completed: DodoAnimationCompleted) {
    DodoAnimations.fade(true, view: view, completed: completed)
  }
  
  /**
  
  Animation that slides the bar vertically into view.
  
  :param: view View supplied for animation.
  :param: completed A closure to be called after animation completes.
  
  */
  public static func slideVertically(view: UIView, locationTop: Bool,
    completed: DodoAnimationCompleted) {
      
    DodoAnimations.slideVertically(true, view: view, locationTop: locationTop, completed: completed)
  }
}
