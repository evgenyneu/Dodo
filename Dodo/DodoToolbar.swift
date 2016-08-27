import UIKit

class DodoToolbar: UIView {
  var layoutGuide: UILayoutSupport?
  var style: DodoStyle
  weak var buttonViewDelegate: DodoButtonViewDelegate?
  private var didCallHide = false
  
  convenience init(witStyle style: DodoStyle) {
    self.init(frame: CGRect())
    
    self.style = style
  }
  
  override init(frame: CGRect) {
    style = DodoStyle()
    
    super.init(frame: frame)
  }
  
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func show(inSuperview parentView: UIView, withMessage message: String) {
      
    if superview != nil { return } // already being shown
  
    parentView.addSubview(self)
    applyStyle()
    layoutBarInSuperview()
      
    let buttons = createButtons()

    createLabel(message, withButtons: buttons)
    
    style.bar.animationShow(self, style.bar.animationShowDuration, style.bar.locationTop, {})
  }
  
  func hide(_ onAnimationCompleted: @escaping ()->()) {
    // Respond only to the first hide() call
    if didCallHide { return }
    didCallHide = true
    
    style.bar.animationHide(self, style.bar.animationHideDuration,
                            style.bar.locationTop, { [weak self] in
        
      self?.removeFromSuperview()
      onAnimationCompleted()
    })
  }
    
  // MARK: - Label
  
  private func createLabel(_ message: String, withButtons buttons: [UIView]) {
    let label = UILabel()
    
    label.font = style.label.font
    label.text = message
    label.textColor = style.label.color
    label.textAlignment = NSTextAlignment.center
    label.numberOfLines = style.label.numberOfLines
    
    if style.bar.debugMode {
      label.backgroundColor = UIColor.red
    }
    
    if let shadowColor = style.label.shadowColor {
      label.shadowColor = shadowColor
      label.shadowOffset = style.label.shadowOffset
    }
    
    addSubview(label)
    layoutLabel(label, withButtons: buttons)
  }
  
  private func layoutLabel(_ label: UILabel, withButtons buttons: [UIView]) {
    label.translatesAutoresizingMaskIntoConstraints = false
    
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
  
  private func layoutLabelWithButtons(_ label: UILabel, withButtons buttons: [UIView]) {
    if buttons.count != 2 { return }
    
    let views = [buttons[0], label, buttons[1]]
    
    if let superview = superview {
      TegAutolayoutConstraints.viewsNextToEachOther(views,
        constraintContainer: superview, margin: style.label.horizontalMargin, vertically: false)
    }
  }
  
  // MARK: - Buttons
  
  private func createButtons() -> [DodoButtonView] {
    precondition(buttonViewDelegate != nil, "Button view delegate can not be nil")
    let buttonStyles = [style.leftButton, style.rightButton]
    
    let buttonViews = DodoButtonView.createMany(buttonStyles)
    
    for (index, button) in buttonViews.enumerated() {
      addSubview(button)
      button.delegate = buttonViewDelegate
      button.doLayout(onLeftSide: index == 0)

      if style.bar.debugMode {
        button.backgroundColor = UIColor.yellow
      }
    }
    
    return buttonViews
  }
  
  // MARK: - Style the bar
  
  private func applyStyle() {
    backgroundColor = style.bar.backgroundColor
    layer.cornerRadius = style.bar.cornerRadius
    layer.masksToBounds = true
    
    if let borderColor = style.bar.borderColor , style.bar.borderWidth > 0 {
      layer.borderColor = borderColor.cgColor
      layer.borderWidth = style.bar.borderWidth
    }
  }
  
  private func layoutBarInSuperview() {
    translatesAutoresizingMaskIntoConstraints = false
    
    if let superview = superview {
      // Stretch the toobar horizontally to the width if its superview
      TegAutolayoutConstraints.fillParent(self, parentView: superview,
        margin: style.bar.marginToSuperview.width, vertically: false)
      
      let vMargin = style.bar.marginToSuperview.height
      let verticalMargin = style.bar.locationTop ? -vMargin : vMargin
      
      var verticalConstraints = [NSLayoutConstraint]()
      
      if let layoutGuide = layoutGuide {
        
        // Align the top/bottom edge of the toolbar with the top/bottom layout guide
        // (a tab bar, for example)
        verticalConstraints = TegAutolayoutConstraints.alignVerticallyToLayoutGuide(self,
          onTop: style.bar.locationTop,
          layoutGuide: layoutGuide,
          constraintContainer: superview,
          margin: verticalMargin)
        
      } else {
        
        // Align the top/bottom of the toolbar with the top/bottom of its superview
        verticalConstraints = TegAutolayoutConstraints.alignSameAttributes(superview, toItem: self,
          constraintContainer: superview,
          attribute: style.bar.locationTop ? NSLayoutAttribute.top : NSLayoutAttribute.bottom,
          margin: verticalMargin)
      }
      
      setupKeyboardEvader(verticalConstraints)
    }
  }
  
  // Moves the message bar from under the keyboard
  private func setupKeyboardEvader(_ verticalConstraints: [NSLayoutConstraint]) {
    if let bottomConstraint = verticalConstraints.first,
      let superview = superview
      , !style.bar.locationTop {
      
      DodoKeyboardListener.underKeyboardLayoutConstraint.setup(bottomConstraint,
        view: superview, bottomLayoutGuide: layoutGuide)
    }
  }
}
