import ThirdParty

/// A command to open a Safari website.
struct OpenCommand: ParsableCommand {

    /// The configuration for the `OpenCommand`.
    static var configuration = CommandConfiguration(
        commandName: "open",
        abstract: "Open Safari website"
    )
    
    /// Runs the `OpenCommand`.
    func run() throws {
        try OpenService().run()
    }
}

