
import UIKit

class DodoButtonView: UIImageView {
  private let style: DodoButtonStyle
  weak var delegate: DodoButtonViewDelegate?
  var onTap: OnTap?
  
  init(style: DodoButtonStyle) {
    self.style = style
    
    super.init(frame: CGRect())
  }

  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // Create button views for given button styles.
  static func createMany(_ styles: [DodoButtonStyle]) -> [DodoButtonView] {
      
    if !haveButtons(styles) { return [] }
    
    return styles.map { style in
      let view = DodoButtonView(style: style)
      view.setup()
      return view
    }
  }
  
  static func haveButtons(_ styles: [DodoButtonStyle]) -> Bool {
    let hasImages = styles.filter({ $0.image != nil }).count > 0
    let hasIcons = styles.filter({ $0.icon != nil }).count > 0

    return hasImages || hasIcons
  }
  
  func doLayout(onLeftSide: Bool) {
    precondition(delegate != nil, "Button view delegate can not be nil")
    translatesAutoresizingMaskIntoConstraints = false
    
    // Set button's size
    TegAutolayoutConstraints.width(self, value: style.size.width)
    TegAutolayoutConstraints.height(self, value: style.size.height)
    
    if let superview = superview {
      let alignAttribute = onLeftSide ? NSLayoutAttribute.left : NSLayoutAttribute.right
      
      let marginHorizontal = onLeftSide ? style.horizontalMarginToBar : -style.horizontalMarginToBar
      
      // Align the button to the left/right of the view
      TegAutolayoutConstraints.alignSameAttributes(self, toItem: superview,
        constraintContainer: superview,
        attribute: alignAttribute, margin: marginHorizontal)
      
      // Center the button verticaly
      TegAutolayoutConstraints.centerY(self, viewTwo: superview, constraintContainer: superview)
    }
  }
  
  func setup() {
    if let image = DodoButtonView.image(style) { applyStyle(image) }
    setupTap()
  }
  
  /// Increase the hitsize of the image view if it's less than 44px for easier tapping.
  override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
    let oprimizedBounds = DodoTouchTarget.optimize(bounds)
    return oprimizedBounds.contains(point)
  }
  
  /// Returns the image supplied by user or create one from the icon
  class func image(_ style: DodoButtonStyle) -> UIImage? {
    if style.image != nil {
      return style.image
    }
    
    if let icon = style.icon {
      let bundle = Bundle(for: self)
      let imageName = icon.rawValue
      
      return UIImage(named: imageName, in: bundle, compatibleWith: nil)
    }
    
    return nil
  }
  
  private func applyStyle(_ imageIn: UIImage) {
    var imageToShow = imageIn
    if let tintColorToShow = style.tintColor {
      // Replace image colors with the specified tint color
      imageToShow = imageToShow.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
      tintColor = tintColorToShow
    }
    
    layer.minificationFilter = kCAFilterTrilinear // make the image crisp
    image = imageToShow
    contentMode = UIViewContentMode.scaleAspectFit
    
    // Make button accessible
    if let accessibilityLabelToShow = style.accessibilityLabel {
      isAccessibilityElement = true
      accessibilityLabel = accessibilityLabelToShow
      accessibilityTraits = UIAccessibilityTraitButton
    }
  }
  
  private func setupTap() {
    onTap = OnTap(view: self, gesture: UITapGestureRecognizer()) { [weak self] in
      self?.didTap()
    }
  }
  
  private func didTap() {
    self.delegate?.buttonDelegateDidTap(self.style)
    style.onTap?()
  }
}
