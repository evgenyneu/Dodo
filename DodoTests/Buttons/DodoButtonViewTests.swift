import UIKit
import XCTest

class DodoButtonViewTests: XCTestCase {
  
  var buttonDelegate: ButtonViewDelegateMock!
  
  override func setUp() {
    super.setUp()
    
    DodoStyle.resetDefaultStyles()
    buttonDelegate = ButtonViewDelegateMock()
  }
  
  // MARK: - Create many
  // ------------------------------
  
  func testCreateMany() {
    let styleOne = DodoButtonStyle(parentStyle: nil)
    let image = TestBundle.image("96px.png")!
    styleOne.image = image
    
    let styleTwo = DodoButtonStyle(parentStyle: nil)
    
    let styles = [styleOne, styleTwo]

    let result = DodoButtonView.createMany(styles)
    
    XCTAssertEqual(2, result.count)
    XCTAssertEqual(96, result[0].image!.size.width)
    
    XCTAssert(result[1].image == nil)
  }
  
  
  func testDoNotCreateButtonsWhenImagesAreNotSupplied() {
    let styleOne = DodoButtonStyle(parentStyle: nil)
    let styleTwo = DodoButtonStyle(parentStyle: nil)
    
    let styles = [styleOne, styleTwo]
    
    let result = DodoButtonView.createMany(styles)
    
    XCTAssert(result.isEmpty)
  }
  
  // MARK: - Check if we have buttons
  // ------------------------------

  func testHaveButtons_yesHasOneImage() {
    let styleOne = DodoButtonStyle(parentStyle: nil)
    let image = TestBundle.image("96px.png")!
    styleOne.image = image
    
    let styleTwo = DodoButtonStyle(parentStyle: nil)
    
    let styles = [styleOne, styleTwo]
    
    let result = DodoButtonView.haveButtons(styles)
    
    XCTAssert(result)
  }
  
  func testHaveButtons_yesHasOneIcon() {
    let styleOne = DodoButtonStyle(parentStyle: nil)
    styleOne.icon = DodoIcons.close
    
    let styleTwo = DodoButtonStyle(parentStyle: nil)
  
    let styles = [styleOne, styleTwo]
    
    let result = DodoButtonView.haveButtons(styles)
    
    XCTAssert(result)
  }
  
  func testHaveButtons_noHasNoImagesOrIcons() {
    let styleOne = DodoButtonStyle(parentStyle: nil)
    let styleTwo = DodoButtonStyle(parentStyle: nil)
    
    let styles = [styleOne, styleTwo]
    
    let result = DodoButtonView.haveButtons(styles)
    
    XCTAssertFalse(result)
  }
  
  // MARK: - Setup image view
  // ------------------------------
  
  func testSetupView_withImage() {
    let style = DodoButtonStyle(parentStyle: nil)
    let image = TestBundle.image("67px.png")!
    style.image = image
    
    let view = DodoButtonView(style: style)
    view.setup()
    
    XCTAssertEqual(67, view.image!.size.width)
    XCTAssertEqual(UIView.ContentMode.scaleAspectFit, view.contentMode)
  }
  
  func testSetupView_no_image() {
    let style = DodoButtonStyle(parentStyle: nil)
    style.image = nil
    
    let view = DodoButtonView(style: style)
    view.setup()
    
    XCTAssert(view.image == nil)
  }
  
  func testSetupView_withTintColor() {
    let style = DodoButtonStyle(parentStyle: nil)
    let image = TestBundle.image("67px.png")!
    style.image = image
    style.tintColor = UIColor.purple
    
    let view = DodoButtonView(style: style)
    view.setup()
    
    XCTAssertEqual(UIImage.RenderingMode.alwaysTemplate, view.image!.renderingMode)
    XCTAssertEqual(UIColor.purple, view.tintColor)
  }
  
  func testSetupView_noOriginalImageColor() {
    DodoButtonDefaultStyles.tintColor = nil

    let style = DodoButtonStyle(parentStyle: nil)
    let image = TestBundle.image("67px.png")!
    style.image = image
    style.tintColor = nil
    
    let view = DodoButtonView(style: style)
    view.setup()
    
    XCTAssertEqual(UIImage.RenderingMode.automatic, view.image!.renderingMode)
  }
  
  func testSetupView_withIcon() {
    let style = DodoButtonStyle(parentStyle: nil)
    style.icon = DodoIcons.close
    
    let view = DodoButtonView(style: style)
    view.setup()
    
    XCTAssertEqual(256, view.image!.size.width)
  }
  
  func testAccessibility() {
    let style = DodoButtonStyle(parentStyle: nil)
    let image = TestBundle.image("67px.png")!
    style.image = image
    style.accessibilityLabel = "Test bar button"
    
    let view = DodoButtonView(style: style)
    view.setup()
    
    XCTAssertEqual("Test bar button", view.accessibilityLabel!)
    XCTAssertEqual(UIAccessibilityTraits.button, view.accessibilityTraits)
    XCTAssert(view.isAccessibilityElement)
  }
  
  func testAccessibility_notAccessible() {
    let style = DodoButtonStyle(parentStyle: nil)
    let image = TestBundle.image("67px.png")!
    style.image = image
    style.accessibilityLabel = nil
    
    let view = DodoButtonView(style: style)
    view.setup()
    
    XCTAssert(view.accessibilityLabel == nil)
    XCTAssertEqual(0, Int(view.accessibilityTraits.rawValue))
    XCTAssertFalse(view.isAccessibilityElement)
  }
  
  func testOnTapClosureIsCalledWhenImageIsTapped() {
    let style = DodoButtonStyle(parentStyle: nil)
    var tapClosureCalledTimes = 0
    
    style.onTap = {
      tapClosureCalledTimes += 1
    }
    
    let view = DodoButtonView(style: style)
    view.setup()
    
    view.onTap?.didTap(UITapGestureRecognizer())
    
    XCTAssertEqual(1, tapClosureCalledTimes)
  }
  
  func testOnTapDelegateIsCalled() {
    let style = DodoButtonStyle(parentStyle: nil)
    style.size = CGSize(width: 81, height: 81)
    
    let view = DodoButtonView(style: style)
    view.setup()
    view.delegate = buttonDelegate
    view.onTap?.didTap(UITapGestureRecognizer())
    
    XCTAssertEqual(81, buttonDelegate.didTapCalledWithStyle!.size.width)
  }
  
  // MARK: - Get button image 
  
  func testButtonImage_withSuppliedImage() {
    let style = DodoButtonStyle(parentStyle: nil)
    let image = TestBundle.image("67px.png")!
    style.image = image
    
    let actualImage = DodoButtonView.image(style)!
    XCTAssertEqual(67, actualImage.size.width)
  }
  
  func testButtonImage_withIcon() {
    let style = DodoButtonStyle(parentStyle: nil)
    style.icon = DodoIcons.close
    
    let actualImage = DodoButtonView.image(style)!
    XCTAssertEqual(256, actualImage.size.width)
  }
  
  func testButtonImage_noImageOrIcon() {
    let style = DodoButtonStyle(parentStyle: nil)
    
    let actualImage = DodoButtonView.image(style)
    XCTAssert(actualImage == nil)
  }
}
