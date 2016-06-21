import UIKit

/**

Animating CALayer with spring effect in iOS with Swift

https://github.com/evgenyneu/SpringAnimationCALayer

*/
class SpringAnimationCALayer {
  // Animates layer with spring effect.
  class func animate(_ layer: CALayer,
    keypath: String,
    duration: CFTimeInterval,
    usingSpringWithDamping: Double,
    initialSpringVelocity: Double,
    fromValue: Double,
    toValue: Double,
    onFinished: (()->())?) {
      
      CATransaction.begin()
      CATransaction.setCompletionBlock(onFinished)
      
      let animation = create(keypath, duration: duration,
        usingSpringWithDamping: usingSpringWithDamping,
        initialSpringVelocity: initialSpringVelocity,
        fromValue: fromValue, toValue: toValue)
      
      layer.add(animation, forKey: keypath + " spring animation")
      CATransaction.commit()
  }
  
  // Creates CAKeyframeAnimation object
  class func create(_ keypath: String,
    duration: CFTimeInterval,
    usingSpringWithDamping: Double,
    initialSpringVelocity: Double,
    fromValue: Double,
    toValue: Double) -> CAKeyframeAnimation {
      
      let dampingMultiplier = Double(10)
      let velocityMultiplier = Double(10)
      
      let values = animationValues(fromValue, toValue: toValue,
        usingSpringWithDamping: dampingMultiplier * usingSpringWithDamping,
        initialSpringVelocity: velocityMultiplier * initialSpringVelocity)
      
      let animation = CAKeyframeAnimation(keyPath: keypath)
      animation.values = values
      animation.duration = duration
      
      return animation
  }
  
  class func animationValues(_ fromValue: Double, toValue: Double,
    usingSpringWithDamping: Double, initialSpringVelocity: Double) -> [Double]{
      
      let numOfPoints = 1000
      var values = [Double](repeating: 0.0, count: numOfPoints)
      
      let distanceBetweenValues = toValue - fromValue
      
      for point in (0..<numOfPoints) {
        let x = Double(point) / Double(numOfPoints)
        let valueNormalized = animationValuesNormalized(x,
          usingSpringWithDamping: usingSpringWithDamping, initialSpringVelocity: initialSpringVelocity)
        
        let value = toValue - distanceBetweenValues * valueNormalized
        values[point] = value
      }
      
      return values
  }
  
  private class func animationValuesNormalized(_ x: Double, usingSpringWithDamping: Double,
    initialSpringVelocity: Double) -> Double {
      
      return pow(M_E, -usingSpringWithDamping * x) * cos(initialSpringVelocity * x)
  }
}
