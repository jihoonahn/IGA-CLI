import ThirdParty

struct CompletionParameters: Encodable {
    var model: String
    var messages: [Message]
    var temperature: Double
}

struct Message: Codable {
    var role: String
    var content: String
}

extension Message {
    var total: Int {
        content.apporximate + 6
    }
}
