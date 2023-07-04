import Foundation

/// Represents different types of keychain accounts.
enum KeychainAccount: String {
    case apiToken = "API-TOKEN"
}

/// A singleton class for managing keychain operations.
final class Keychain {
    /// The shared instance of the `Keychain` class.
    static let shared = Keychain()

    /// The service identifier for the keychain.
    private let service = Bundle.main.bundleIdentifier ?? ""

    /**
     Saves a value to the keychain.

     - Parameters:
        - type: The type of keychain account.
        - value: The value to be saved.
     */
    func save(type: KeychainAccount, value: String) {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: type.rawValue,
            kSecValueData: value.data(using: .utf8, allowLossyConversion: false) ?? .init()
        ]
        SecItemDelete(query)
        SecItemAdd(query, nil)
    }

    /**
     Loads a value from the keychain.

     - Parameter type: The type of keychain account.

     - Throws: `KeychainError.dataNotFound` if the data is not found in the keychain.

     - Returns: The value associated with the keychain account.
     */
    func load(type: KeychainAccount) throws -> String {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: type.rawValue,
            kSecReturnData: kCFBooleanTrue!,
            kSecMatchLimit: kSecMatchLimitOne
        ]
        var dataRef: AnyObject?
        let status = SecItemCopyMatching(query, &dataRef)
        if status == errSecSuccess {
            guard let data = dataRef as? Data else { throw KeychainError.dataNotFound }
            let value = String(data: data, encoding: .utf8)
            return value!
        } else {
            throw KeychainError.dataNotFound
        }
    }

    /**
     Deletes a value from the keychain.

     - Parameter type: The type of keychain account.
     */
    func delete(type: KeychainAccount) {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: type.rawValue
        ]
        SecItemDelete(query)
    }
}

