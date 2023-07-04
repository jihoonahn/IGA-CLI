import Foundation

/// An error that can occur when handling a response.
public enum ResponseError: Error {

  /// The response is missing.
  case missingResponses

  /// The prefix is missing.
  case missingPrefix
}
