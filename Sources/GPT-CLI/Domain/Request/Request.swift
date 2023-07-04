import Foundation

struct Request {
    var messages: [Message]
    var model: Model

    init(
        messages: [Message],
        model: Model
    ) {
        self.messages = messages
        self.model = model
    }
    
    var parameters: CompletionParameters {
        return CompletionParameters(
            model: model.id,
            messages: messages,
            temperature: 0
        )
    }
}
