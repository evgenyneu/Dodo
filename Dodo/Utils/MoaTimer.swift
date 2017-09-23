import UIKit

/**

Creates a timer that executes code after delay.

Usage

    var timer: MoaTimer.runAfter?
    ...

    func myFunc() {
       timer = MoaTimer.runAfter(0.010) { timer in
          ... code to run
       }
    }

Canceling the timer

Timer is Canceling automatically when it is deallocated. You can also cancel it manually:

    let timer = MoaTimer.runAfter(0.010) { timer in ... }
    timer.cancel()

*/
final class MoaTimer: NSObject {
  private let repeats: Bool
  private var timer: Timer?
  private var callback: ((MoaTimer)->())?
  
  private init(interval: TimeInterval, repeats: Bool = false, callback: @escaping (MoaTimer)->()) {
    self.repeats = repeats
    
    super.init()
    
    self.callback = callback
    timer = Timer.scheduledTimer(timeInterval: interval, target: self,
      selector: #selector(MoaTimer.timerFired(_:)), userInfo: nil, repeats: repeats)
  }
  
  /// Timer is cancelled automatically when it is deallocated.
  deinit {
    cancel()
  }
  
  /**
  
  Cancels the timer and prevents it from firing in the future.
  
  Note that timer is cancelled automatically whe it is deallocated.
  
  */
  func cancel() {
    timer?.invalidate()
    timer = nil
  }
  
  /**
  
  Runs the closure after specified time interval.
  
  - parameter interval: Time interval in milliseconds.
  :repeats: repeats When true, the code is run repeatedly.
  - returns: callback A closure to be run by the timer.
  
  */
  @discardableResult
  class func runAfter(_ interval: TimeInterval, repeats: Bool = false,
    callback: @escaping (MoaTimer)->()) -> MoaTimer {
      
    return MoaTimer(interval: interval, repeats: repeats, callback: callback)
  }
  
  @objc func timerFired(_ timer: Timer) {
    self.callback?(self)
    if !repeats { cancel() }
  }
}
