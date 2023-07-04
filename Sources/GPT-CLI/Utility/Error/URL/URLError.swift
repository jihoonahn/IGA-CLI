import Foundation

public enum URLError: Error {
    case validationError(String)
}

extension URLError: CustomStringConvertible {
    public var description: String {
        switch self {
        case let .validationError(error):
            return error
        }
    }
}
