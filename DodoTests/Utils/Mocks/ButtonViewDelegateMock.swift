class ButtonViewDelegateMock: DodoButtonViewDelegate {
  var didTapCalledWithStyle: DodoButtonStyle?
  
  func buttonDelegateDidTap(_ buttonStyle: DodoButtonStyle) {
    didTapCalledWithStyle = buttonStyle
  }
}
