import Foundation
import ThirdParty
import NIO
import NIOHTTP1

final class GPTService {
    func run(
        message: String?,
        model: Model
    ) async throws {
        let request = Request(
            messages: [
                Message(role: "user", content: message ?? "")
            ],
            model: model
        )
        let newContent = try await OpenAIService().run(request)
        logger.notice("\n✅ ChatGPT: \(newContent)", metadata: .success)
    }
}
