/**

Used in unit tests to verify the messages that were shown in the message bar.

*/
public struct DodoMockResults {
  /// An array of success messages displayed in the message bar.
  public var success: [String] {
    return messages.filter({ $0.preset == DodoPresets.success }).map({ $0.message })
  }
  
  /// An array of information messages displayed in the message bar.
  public var info: [String] {
    return messages.filter({ $0.preset == DodoPresets.info }).map({ $0.message })
  }
  
  /// An array of warning messages displayed in the message bar.
  public var warning: [String] {
    return messages.filter({ $0.preset == DodoPresets.warning }).map({ $0.message })
  }
  
  /// An array of error messages displayed in the message bar.
  public var errors: [String] {
    return messages.filter({ $0.preset == DodoPresets.error }).map({ $0.message })
  }
  
  /// Total number of messages shown.
  public var total: Int {
    return messages.count
  }
  
  /// Indicates whether the message is visible
  public var visible = false
  
  var messages = [DodoMockMessage]()
}
