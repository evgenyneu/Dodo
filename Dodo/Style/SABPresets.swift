
/**

Defines the style presets for the bar.

*/
public enum SABPresets {
  /// A styling preset used for indicating successful completion of an operation. Usually styled with green color.
  case Success
  
  /// A styling preset for showing information messages, neutral in color.
  case Info
  
  /// A styling preset for showing warning messages. Can be styled with yellow/orange colors.
  case Warning
  
  /// A styling preset for showing critical error messages. Usually styled with red color.
  case Error
  
  /// The preset is used by default for the bar if it's not set by the user.
  static let defaultPreset = SABPresets.Success
  
  /// The preset cache.
  private static var styles = [SABPresets: SABStyle]()
  
  /// Returns the style for the preset
  public var style: SABStyle {
    var style = SABPresets.styles[self]
    
    if style == nil {
      style = SABPresets.makeStyle(forPreset: self)
      SABPresets.styles[self] = style
    }
    
    precondition(style != nil, "Failed to create style")
    
    return style ?? SABStyle()
  }
  
  /// Reset alls preset styles to their initial states.
  public static func resetAll() {
    styles = [:]
  }
  
  /// Reset the preset style to its initial state.
  public func reset() {
    SABPresets.styles.removeValueForKey(self)
  }
  
  private static func makeStyle(forPreset preset: SABPresets) -> SABStyle{
    
    let style = SABStyle()
    
    switch preset {
    case .Success:
      style.bar.backgroundColor = TegUIColor.fromHexString("#00CC03C9")
      style.bar.borderColor = TegUIColor.fromHexString("#003C00")

      
    case .Info:
      style.bar.backgroundColor = TegUIColor.fromHexString("#0057FF96")
      style.bar.borderColor = TegUIColor.fromHexString("#132066")

      
    case .Warning:
      style.bar.backgroundColor = TegUIColor.fromHexString("#CEC411DD")
      style.bar.borderColor = TegUIColor.fromHexString("#574608")
      
      
    case .Error:
      style.bar.backgroundColor = TegUIColor.fromHexString("#FF0B0BCC")
      style.bar.borderColor = TegUIColor.fromHexString("#691716")
    }
    
    return style
  }
}