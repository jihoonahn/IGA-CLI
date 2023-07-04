import ThirdParty

final class TokenService {
    private let keychain = Keychain.shared

    func run(
        token: String?,
        load: Bool,
        delete: Bool
    ) throws {
        if let token = token {
            saveToken(token: token)
        }
        if load {
            loadToken()
        }
        if delete {
            deleteToken()
        }
    }

    private func saveToken(token: String?) {
        guard let token = token else { return }
        keychain.save(type: .apiToken, value: token)
        logger.notice("OpenAI API Token Save Success", metadata: .success)
    }

    private func loadToken() {
        do {
            let token = try keychain.load(type: .apiToken)
            logger.notice("OpenAI API Token: \(token)", metadata: .success)
        } catch {
            logger.error("Error: \(error.localizedDescription)")
        }
    }

    private func deleteToken() {
        keychain.delete(type: .apiToken)
        logger.notice("OpenAI API Token Remove", metadata: .success)
    }
}
