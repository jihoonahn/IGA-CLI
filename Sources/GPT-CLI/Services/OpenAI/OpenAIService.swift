import Foundation
import ThirdParty
import NIOHTTP1

final class OpenAIService {
    
    /// Keychain
    private let keychain = Keychain.shared
    /// API URL
    private let apiURL = URL(string: "https://api.openai.com/v1/chat/completions")
    /// Rate Limiter
    private let rateLimiter = RateLimiter()
    /// HTTP Client
    private let httpClient = HTTPClient(eventLoopGroupProvider: .createNew)
    /// HTTP Headers
    private var httpHeaders = HTTPHeaders()
    /// The `JSONEncoder` used to encode parameters for the OpenAI API.
    private let jsonEncoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()
    /// The `JSONDecoder` used to decode response from the OpenAI API.
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    func canAddRequest(_ req: Request) async -> Bool {
        let newTokenCount = await rateLimiter.tokenCount + req.parameters.messages.total
        let newRequestCount = await rateLimiter.requestCount + 1
        return newTokenCount <= rateLimiter.tokenLimit && newRequestCount <= rateLimiter.requestLimit
    }
    
    func run(_ request: Request) async throws -> String {
        while await !canAddRequest(request) {
            try await Task.sleep(nanoseconds: NSEC_PER_SEC * 1)
        }
        await rateLimiter.addRequest(request)
        
        guard let url = apiURL else {
            throw URLError.validationError("Invalid API endpoint URL.")
        }
        let apiKey = try keychain.load(type: .apiToken)
        let requestBody = try jsonEncoder.encode(request.parameters)

        /// defer httpclient shut down.
        defer {
            try? httpClient.syncShutdown()
        }
        
        httpHeaders.add(name: "Authorization", value: "Bearer \(apiKey)")
        httpHeaders.add(name: "Content-Type", value: "application/json")
        
        let urlRequest = try HTTPClient.Request(
            url: url,
            method: .POST,
            headers: httpHeaders,
            body: .data(requestBody)
        )
        
        let response = try await httpClient.execute(request: urlRequest).get()
        await rateLimiter.deleteRequest(request)

        let body = response.body ?? ByteBuffer()
        let responseData = body.getData(at: body.readerIndex, length: body.readableBytes) ?? Data()
        let completionResponse = try jsonDecoder.decode(CompletionResponse.self, from: responseData)
        guard let firstChoice = completionResponse.choices.first else {
            throw ResponseError.missingResponses
        }
        let newContent = firstChoice.message.content
        return newContent
    }
}
