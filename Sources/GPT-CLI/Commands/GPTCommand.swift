import ThirdParty

@main
struct CLITool: AsyncParsableCommand {
    static var configuration = CommandConfiguration(
        commandName: "gpt",
        abstract: "CLI Example for iGA Conference",
        discussion: "This is an example of how the CLI works",
        subcommands: [OpenCommand.self, TokenCommand.self]
    )
    
    @Option(name: .shortAndLong, help: "Send a message")
    var message: String = ""
    
    /// The id of the OpenAI model to run.
    @Option(name: .long, help: "The id of the OpenAI model to run")
    var model: Model = Model(argument: "gpt-3.5-turbo-0301")!
    
    func run() async throws {
        try await GPTService().run(
            message: message,
            model: model
        )
    }
}
