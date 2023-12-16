import Foundation

enum KeychainError: Error {
    case duplicateEntry
    case unknown(OSStatus)
}

class KeychainManager {
    
    static func savePassword(service: String, account: String, password: Data) throws {
        print("Starting save")
            // Service, Account, Password, Class
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
            kSecValueData as String: password as AnyObject,
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        // Check for duplicate entry
        guard status != errSecDuplicateItem else {
            throw KeychainError.duplicateEntry
        }
        
        // If not success then throw error with status
        guard status != errSecSuccess else {
            throw KeychainError.unknown(status)
        }
        
        print("Saved Succesfully")
    }
    
    static func get(service: String, account: String) -> Data? {
        
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
            kSecReturnData as String: kCFBooleanTrue,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        print("Read status: \(status)")
        return result as? Data
    }
}
