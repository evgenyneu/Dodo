import UIKit
import XCTest

class DodoButtonViewTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
    
    DodoStyle.resetDefaultStyles()
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
  
  // MARK: - Setup image view
  // ------------------------------
  
  func testSetupView_withImage() {
    let style = DodoButtonStyle(parentStyle: nil)
    let image = TestBundle.image("67px.png")!
    style.image = image
    
    let view = DodoButtonView(style: style)
    view.setup()
    
    XCTAssertEqual(67, view.image!.size.width)
    XCTAssertEqual(UIViewContentMode.ScaleAspectFit, view.contentMode)
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
    style.tintColor = UIColor.purpleColor()
    
    let view = DodoButtonView(style: style)
    view.setup()
    
    XCTAssertEqual(UIImageRenderingMode.AlwaysTemplate, view.image!.renderingMode)
    XCTAssertEqual(UIColor.purpleColor(), view.tintColor)
  }
  
  func testSetupView_noOriginalImageColor() {
    DodoButtonDefaultStyles.tintColor = nil

    let style = DodoButtonStyle(parentStyle: nil)
    let image = TestBundle.image("67px.png")!
    style.image = image
    style.tintColor = nil
    
    let view = DodoButtonView(style: style)
    view.setup()
    
    XCTAssertEqual(UIImageRenderingMode.Automatic, view.image!.renderingMode)
  }
  
  func testAccessibility() {
    let style = DodoButtonStyle(parentStyle: nil)
    let image = TestBundle.image("67px.png")!
    style.image = image
    style.accessibilityLabel = "Test bar button"
    
    let view = DodoButtonView(style: style)
    view.setup()
    
    XCTAssertEqual("Test bar button", view.accessibilityLabel)
    XCTAssertEqual(UIAccessibilityTraitButton, view.accessibilityTraits)
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
    XCTAssertEqual(0, view.accessibilityTraits)
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
}