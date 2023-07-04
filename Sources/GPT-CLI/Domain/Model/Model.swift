import ThirdParty

struct Model: ExpressibleByArgument {
    let id: String
    let contextLength: Int
    
    init?(argument: String) {
        self.id = argument
        switch id {
        case "gpt-4", "gpt-4-0613":
            contextLength = 8_192
        case "gpt-4-32k", "gpt-4-32k-0613":
            contextLength = 32_768
        case "gpt-3.5-turbo", "gpt-3.5-turbo-0301", "gpt-3.5-turbo-0613":
            contextLength = 4_096
        case "gpt-3.5-turbo-16k", "gpt-3.5-turbo-16k-0613":
            contextLength = 16_384
        default:
            return nil
        }
    }
}
