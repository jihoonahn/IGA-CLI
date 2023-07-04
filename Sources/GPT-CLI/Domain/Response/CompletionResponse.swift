import ThirdParty

struct CompletionResponse: Decodable {
    var choices: [Choice]
    struct Choice: Decodable {
        var message: Message
    }
}
