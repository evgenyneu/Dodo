
/**

Defines the style presets for the bar.

*/
public enum DodoPresets {
  /// A styling preset used for indicating successful completion of an operation. Usually styled with green color.
  case Success
  
  /// A styling preset for showing information messages, neutral in color.
  case Info
  
  /// A styling preset for showing warning messages. Can be styled with yellow/orange colors.
  case Warning
  
  /// A styling preset for showing critical error messages. Usually styled with red color.
  case Error
  
  /// The preset is used by default for the bar if it's not set by the user.
  static let defaultPreset = DodoPresets.Success
  
  /// The preset cache.
  private static var styles = [DodoPresets: DodoStyle]()
  
  /// Returns the style for the preset
  public var style: DodoStyle {
    var style = DodoPresets.styles[self]
    
    if style == nil {
      style = DodoPresets.makeStyle(forPreset: self)
      DodoPresets.styles[self] = style
    }
    
    precondition(style != nil, "Failed to create style")
    
    return style ?? DodoStyle()
  }
  
  /// Reset alls preset styles to their initial states.
  public static func resetAll() {
    styles = [:]
  }
  
  /// Reset the preset style to its initial state.
  public func reset() {
    DodoPresets.styles.removeValueForKey(self)
  }
  
  private static func makeStyle(forPreset preset: DodoPresets) -> DodoStyle{
    
    let style = DodoStyle()
    
    switch preset {
    case .Success:
      style.bar.backgroundColor = DodoColor.fromHexString("#00CC03C9")
      
    case .Info:
      style.bar.backgroundColor = DodoColor.fromHexString("#0057FF96")
      
    case .Warning:
      style.bar.backgroundColor = DodoColor.fromHexString("#CEC411DD")
      
    case .Error:
      style.bar.backgroundColor = DodoColor.fromHexString("#FF0B0BCC")
    }
        
    return style
  }
}