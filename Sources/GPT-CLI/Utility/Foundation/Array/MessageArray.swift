import Foundation

extension Array where Element == Message {
    var total: Int {
        reduce(0, { $0 + $1.total })
    }
}
