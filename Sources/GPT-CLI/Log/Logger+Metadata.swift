import ThirdParty

extension Logger.Metadata {
    public static let iga: String = "is"
    /// Key for indicating success.
    public static let successKey: String = "success"

    /// Metadata indicating success.
    public static var success: Logger.Metadata {
        [iga: .string(successKey)]
    }
}
