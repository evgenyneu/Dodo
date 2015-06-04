import UIKit

class SABToolbar: UIView {
  var layoutGuide: UILayoutSupport?
  var style: SABStyle
  
  convenience init(witStyle style: SABStyle) {
    self.init(frame: CGRect())
    
    self.style = style
  }
  
  override init(frame: CGRect) {
    style = SABStyle()
    
    super.init(frame: frame)
  }
  
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func show(inSuperview parentView: UIView,
    withMessage message: String,
    withAnimator animator: SABAnimator) {
      
    if superview != nil { return } // already being shown
  
    parentView.addSubview(self)
    applyStyle()
    layoutBarInSuperview()
      
    let buttons = createButtons()

    createLabel(message, withButtons: buttons)
    
    animator.animate(self, onAnimationCompleted: nil)
  }
  
  func hide(animator: SABAnimator, onAnimationCompleted: ()->()) {
    animator.animate(self, onAnimationCompleted: {
      self.removeFromSuperview()
      onAnimationCompleted()
    })
  }
    
  // MARK: - Label
  
  private func createLabel(message: String, withButtons buttons: [UIView]) {
    let label = UILabel()
    
    label.font = style.label.font
    label.text = message
    label.textColor = style.label.color
    label.textAlignment = NSTextAlignment.Center
    label.numberOfLines = style.label.numberOfLines
    
    if style.bar.debugMode {
      label.backgroundColor = UIColor.redColor()
    }
    
    if let shadowColor = style.label.shadowColor {
      label.shadowColor = shadowColor
      label.shadowOffset = style.label.shadowOffset
    }
    
    addSubview(label)
    layoutLabel(label, withButtons: buttons)
  }
  
  private func layoutLabel(label: UILabel, withButtons buttons: [UIView]) {
    label.setTranslatesAutoresizingMaskIntoConstraints(false)
    
    // Stretch the label vertically
    TegAutolayoutConstraints.fillParent(label, parentView: self,
      margin: style.label.horizontalMargin, vertically: true)
    
    if buttons.count == 0 {
      if let superview = superview {
        // If there are no buttons - stretch the label to the entire width of the view
        TegAutolayoutConstraints.fillParent(label, parentView: superview,
          margin: style.label.horizontalMargin, vertically: false)
      }
    } else {
      layoutLabelWithButtons(label, withButtons: buttons)
    }
  }
  
  private func layoutLabelWithButtons(label: UILabel, withButtons buttons: [UIView]) {
    if buttons.count != 2 { return }
    
    let views = [buttons[0], label, buttons[1]]
    
    if let superview = superview {
      TegAutolayoutConstraints.viewsNextToEachOther(views,
        constraintContainer: superview, margin: style.label.horizontalMargin, vertically: false)
    }
  }
  
  // MARK: - Buttons
  
  private func createButtons() -> [SABButtonView] {
    let buttonStyles = [style.leftButton, style.rightButton]
    let buttonViews = SABButtonView.createMany(buttonStyles)
    
    for (index, button) in enumerate(buttonViews) {
      addSubview(button)
      button.doLayout(onLeftSide: index == 0)

      if style.bar.debugMode {
        button.backgroundColor = UIColor.yellowColor()
      }
    }
    
    return buttonViews
  }
  
  // MARK: - Style the bar
  
  private func applyStyle() {
    backgroundColor = style.bar.backgroundColor
    layer.cornerRadius = style.bar.cornerRadius
    layer.masksToBounds = true
    
    if let borderColor = style.bar.borderColor where style.bar.borderWidth > 0 {
      layer.borderColor = borderColor.CGColor
      layer.borderWidth = style.bar.borderWidth
    }
  }
  
  private func layoutBarInSuperview() {
    setTranslatesAutoresizingMaskIntoConstraints(false)
    
    if let superview = superview {
      // Stretch the toobar horizontally to the width if its superview
      TegAutolayoutConstraints.fillParent(self, parentView: superview,
        margin: style.bar.marginToSuperview.width, vertically: false)
      
      let vMargin = style.bar.marginToSuperview.height
      let verticalMargin = style.bar.locationTop ? -vMargin : vMargin
      
      if let layoutGuide = layoutGuide {
        
        // Align the top/bottom edge of the toolbar with the top/bottom layout guide
        // (a tab bar, for example)
        TegAutolayoutConstraints.alignVerticallyToLayoutGuide(self,
          onTop: style.bar.locationTop,
          layoutGuide: layoutGuide,
          constraintContainer: superview,
          margin: verticalMargin)
        
      } else {
        
        // Align the top/bottom of the toolbar with the top/bottom of its superview
        TegAutolayoutConstraints.alignSameAttributes(superview, toItem: self,
          constraintContainer: superview,
          attribute: style.bar.locationTop ? NSLayoutAttribute.Top : NSLayoutAttribute.Bottom,
          margin: verticalMargin)
        
      }
    }
  }
}