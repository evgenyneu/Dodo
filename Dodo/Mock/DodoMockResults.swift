/**

Used in unit tests to verify the messages that were shown in the message bar.

*/
public struct DodoMockResults {
  public var success: [String] {
    return messages.filter({ $0.preset == DodoPresets.Success }).map({ $0.message })
  }
  
  public var info: [String] {
    return messages.filter({ $0.preset == DodoPresets.Info }).map({ $0.message })
  }
  
  public var warning: [String] {
    return messages.filter({ $0.preset == DodoPresets.Warning }).map({ $0.message })
  }
  
  public var errors: [String] {
    return messages.filter({ $0.preset == DodoPresets.Error }).map({ $0.message })
  }
  
  var messages = [DodoMockMessage]()
}