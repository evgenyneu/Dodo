class ButtonViewDelegateMock: DodoButtonViewDelegate {
  var didTapCalledWithStyle: DodoButtonStyle?
  
  func buttonDelegateDidTap(buttonStyle: DodoButtonStyle) {
    didTapCalledWithStyle = buttonStyle
  }
}