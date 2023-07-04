import Foundation

extension String {
    /// The approximate number  taken up by the receiver
    /// From OpenAI: https://platform.openai.com/docs/introduction/key-concepts
    var apporximate: Int {
        let divided = Double(count) / 4
        return Int(divided.rounded(.up))
    }
}
