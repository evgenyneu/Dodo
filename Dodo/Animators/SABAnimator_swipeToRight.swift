import UIKit

/**

Swipes the bar to the right with fade-out effect.

*/
struct SABAnimator_swipeToRight: SABAnimator {
  func animate(view: UIView, onAnimationCompleted: (()->())? = nil) {
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
        onAnimationCompleted?()
      }
    )
  }
}