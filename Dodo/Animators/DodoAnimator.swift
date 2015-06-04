import UIKit

protocol DodoAnimator {
  func animate(view: UIView, onAnimationCompleted: (()->())?)
}