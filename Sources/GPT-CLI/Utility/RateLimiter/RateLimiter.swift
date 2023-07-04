import Foundation

actor RateLimiter {
    private(set) var tokenCount = 0
    private(set) var requestCount = 0
    
    let tokenLimit = 90_000
    let requestLimit = 3_500

    func addRequest(_ request: Request) {
        tokenCount += request.parameters.messages.total
        logger.debug("\(tokenCount <= tokenLimit)")
        requestCount += 1
        logger.debug("\(requestCount <= requestLimit)")
    }
    
    func deleteRequest(_ request: Request) {
        tokenCount -= request.parameters.messages.total
        requestCount -= 1
    }
}
