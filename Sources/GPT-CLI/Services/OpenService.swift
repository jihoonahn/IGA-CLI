import ThirdParty

final class OpenService {
    private let url = "https://platform.openai.com/account/api-keys"

    func run() throws {
        PLCommand.Bash.run("open -a Safari \(url)")
    }
}
