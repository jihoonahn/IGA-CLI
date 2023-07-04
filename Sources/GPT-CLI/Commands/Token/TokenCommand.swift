import ThirdParty

struct TokenCommand: ParsableCommand {
    static var configuration = CommandConfiguration(
        commandName: "token",
        abstract: "Manage API tokens"
    )
    
    @Option(name: .shortAndLong, help: "Save API Token")
    var save: String?
    
    @Flag(name: .shortAndLong, help: "Load API Token")
    var load: Bool = false
    
    @Flag(name: .shortAndLong, help: "Remove API Token")
    var delete: Bool = false
    
    func run() throws {
        try TokenService().run(
            token: save,
            load: load,
            delete: delete
        )
    }
}
