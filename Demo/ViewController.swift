import UIKit
import Dodo

class ViewController: UIViewController {
  
  @IBOutlet weak var testToolbar: UIToolbar!
  @IBOutlet weak var topSwitch: UISwitch!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var hideAfterDelaySwitch: UISwitch!
  @IBOutlet weak var hideOnTapSwitch: UISwitch!
  @IBOutlet weak var leftButtonSwitch: UISwitch!
  @IBOutlet weak var rightButtonSwitch: UISwitch!
  @IBOutlet weak var debugModeSwitch: UISwitch!
  @IBOutlet weak var showAnimationButton: UIButton!
  @IBOutlet weak var hideAnimationButton: UIButton!
  @IBOutlet weak var showKeyboardTextEdit: UITextField!
  @IBOutlet weak var toggleKeyboardButton: UIButton!
  
  let animations = [
    DodoAnimations.fade,
    DodoAnimations.noAnimation,
    DodoAnimations.rotate,
    DodoAnimations.slideLeft,
    DodoAnimations.slideRight,
    DodoAnimations.slideVertically
  ]
  
  var currentShowAnimationIndex = 2
  var currentHideAnimationIndex = 2
  
  var message = "Dodo, a message bar for iOS."
  
  let backgroundImages = [
    "flowers.jpg",
    "black.png",
    "white.png"
  ]
  var currentImageIndex = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.dodo.topLayoutGuide = topLayoutGuide
    updateShowAnimationButtonTitle()
    updateHideAnimationButtonTitle()
    updateKeyboardToggleButtonTitle()
    showKeyboardTextEdit.alpha = 0.01
    
    view.dodo.style.bar.onTap = {
      print("Tap tap tap 🌻🌼🐁🍃")
    }
  }
  
  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return UIStatusBarStyle.lightContent
  }
  
  private func show() {
    view.dodo.style.bar.locationTop = topSwitch.isOn
    view.dodo.style.bar.hideAfterDelaySeconds = hideAfterDelaySwitch.isOn ? 3 : 0
    view.dodo.style.bar.debugMode = debugModeSwitch.isOn
    view.dodo.style.bar.hideOnTap = hideOnTapSwitch.isOn
    view.dodo.style.label.shadowColor = DodoColor.fromHexString("#00000050")
    
    view.dodo.style.label.font = UIFont.preferredFont(forTextStyle: UIFontTextStyleHeadline)
    
    view.dodo.style.bar.animationShow = currentShowAnimation.show
    view.dodo.style.bar.animationHide = currentHideAnimation.hide
    
    addButtons()
    
    view.dodo.show(message)
  }
  
  // MARK: - UI handlers
  
  @IBAction func onSuccessButtonTapped(_ sender: AnyObject) {
    message = "Dodo, a message bar for iOS."
    view.dodo.preset = DodoPresets.success
    show()
  }
  
  @IBAction func onInfoButtonTapped(_ sender: AnyObject) {
    message = "Information is not knowledge."
    view.dodo.preset = DodoPresets.info
    show()
  }
  
  @IBAction func onWarningButtonTapped(_ sender: AnyObject) {
    message = "If the doors of perception were cleansed everything would appear to man as it is, Infinite."
    view.dodo.preset = DodoPresets.warning
    show()
  }
  
  @IBAction func onErrorButtonTapped(_ sender: AnyObject) {
    message = "Failure is success if we learn from it."
    view.dodo.preset = DodoPresets.error
    show()
  }
  
  @IBAction func onHideButtonTapped(_ sender: AnyObject) {
    view.dodo.hide()
  }
  
  @IBAction func onTopSwitchChanged(_ sender: AnyObject) {
    show()
  }
  
  @IBAction func onHideAfterDelaySwitchChanged(_ sender: UISwitch) {
    show()
  }
  
  @IBAction func onHideOnTapSwitchChanged(_ sender: AnyObject) {
    show()
  }
  
  @IBAction func onLeftButtonSwitchChanged(_ sender: AnyObject) {
    show()
  }
  
  @IBAction func onRightButtonSwitchChanged(_ sender: AnyObject) {
    show()
  }
  
  @IBAction func onDebugModeSwitchChanged(_ sender: AnyObject) {
    show()
  }
  
  @IBAction func onChangeBackgroundTapped(_ sender: AnyObject) {
    changeBackgroundImage()
  }
  
  // MARK: - Show / hide keyboard
  
  @IBAction func onToggleKeyboardTapped(_ sender: AnyObject) {
    if showKeyboardTextEdit.isEditing {
      view.endEditing(true)
    } else {
      showKeyboardTextEdit.becomeFirstResponder()
    }
    
    updateKeyboardToggleButtonTitle()
  }
  
  @IBAction func didTapView(_ sender: AnyObject) {
    view.endEditing(true)
    updateKeyboardToggleButtonTitle()
  }
  
  private func updateKeyboardToggleButtonTitle() {
    let title = showKeyboardTextEdit.isEditing ?  "Hide keyboard" : "Show keyboard"
     toggleKeyboardButton.setTitle(title, for: UIControlState())
  }
  
  // MARK: - Buttons
  
  private func addButtons() {
    view.dodo.style.leftButton.icon = nil
    view.dodo.style.rightButton.image = nil
    view.dodo.style.leftButton.tintColor = DodoColor.fromHexString("#FFFFFFAA")
    
    if leftButtonSwitch.isOn {
      // Use a built-in icon
      view.dodo.style.leftButton.icon = .close
      view.dodo.style.leftButton.accessibilityLabel = "Close the message"
      view.dodo.style.leftButton.hideOnTap = true
    }
    
    if rightButtonSwitch.isOn {
      // Use custom image
      let customImage = UIImage(named: "Dodo.png")
      view.dodo.style.rightButton.image = customImage
      view.dodo.style.rightButton.size = CGSize(width: 30, height: 30)
      view.dodo.style.rightButton.image = customImage
      view.dodo.style.rightButton.accessibilityLabel = "Picture of Dodo"
      
      view.dodo.style.rightButton.onTap = { [weak self] bar in
        self?.rotateTheView()
      }
    }
  }
  
  // MARK: - Animation
  
  @IBAction func onShowAnimationButtonTapped(_ sender: AnyObject) {
    currentShowAnimationIndex += 1
    if currentShowAnimationIndex >= animations.count { currentShowAnimationIndex = 0 }
    updateShowAnimationButtonTitle()
    show()
  }
  
  @IBAction func onHideAnimationButtonTapped(_ sender: AnyObject) {
    currentHideAnimationIndex += 1
    if currentHideAnimationIndex >= animations.count { currentHideAnimationIndex = 0 }
    updateHideAnimationButtonTitle()
    show()
  }
  
  private func updateShowAnimationButtonTitle() {
    let text = currentShowAnimation.rawValue
    showAnimationButton.setTitle(text, for: UIControlState())
  }
  
  private func updateHideAnimationButtonTitle() {
    let text = currentHideAnimation.rawValue
    hideAnimationButton.setTitle(text, for: UIControlState())
  }
  
  var currentShowAnimation: DodoAnimations {
    return animationForIndex(currentShowAnimationIndex)
  }
  
  var currentHideAnimation: DodoAnimations {
    return animationForIndex(currentHideAnimationIndex)
  }
  
  private func animationForIndex(_ index: Int) -> DodoAnimations {
    if index > (animations.count - 1) { return animations[0] }
    return animations[index]
  }
  
  private func rotateTheView() {
    let myCALayer = view.layer
    
    myCALayer.shouldRasterize = true
    myCALayer.rasterizationScale = UIScreen.main().scale
    
    var transform = CATransform3DIdentity
    transform.m34 = -1.0/300.0
    myCALayer.transform = CATransform3DRotate(transform, CGFloat(0), 0, 1, 0)
    
    SpringAnimationCALayer.animate(myCALayer,
      keypath: "transform.rotation.y",
      duration: 3.0,
      usingSpringWithDamping: 0.7,
      initialSpringVelocity: 0.7,
      fromValue: Double(0),
      toValue: Double(2 * M_PI),
      onFinished: nil)
  }
  
  // MARK: - Background image
  
  private func changeBackgroundImage() {
    currentImageIndex += 1
    if currentImageIndex >= backgroundImages.count  { currentImageIndex = 0 }
    
    // Get the new image to be shown
    
    let imageName = backgroundImages[currentImageIndex]
    let newImage = UIImage(named: imageName)
    
    // Create a new image view
    
    let newImageView = UIImageView()
    newImageView.translatesAutoresizingMaskIntoConstraints = false
    newImageView.image = newImage
    newImageView.contentMode = UIViewContentMode.scaleAspectFill
    view.insertSubview(newImageView, aboveSubview: imageView)
    TegAutolayoutConstraints.fillParent(newImageView, parentView: view, margin: 0, vertically: false)
    TegAutolayoutConstraints.fillParent(newImageView, parentView: view, margin: 0, vertically: true)
    
    // Fade in new image view
    
    newImageView.alpha = 0
    
    UIView.animate(withDuration: 0.1,
      animations: {
        newImageView.alpha = 1
      },
      completion: { [weak self] finished in
        self?.imageView.image = newImage
        newImageView.removeFromSuperview()
      }
    )
  }
}

