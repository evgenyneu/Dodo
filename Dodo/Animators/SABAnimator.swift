import UIKit

protocol SABAnimator {
  func animate(view: UIView, onAnimationCompleted: (()->())?)
}