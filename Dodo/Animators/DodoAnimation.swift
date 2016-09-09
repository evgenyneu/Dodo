import UIKit

/// A closure that is called for animation of the bar when it is being shown or hidden.
public typealias DodoAnimation = (UIView, _ duration: TimeInterval?,
  _ locationTop: Bool, _ completed: @escaping DodoAnimationCompleted)->()

/// A closure that is called by the animator when animation has finished.
public typealias DodoAnimationCompleted = ()->()
