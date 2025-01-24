//
//  KeychainManager.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/23/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import Foundation

final class KeychainManager : Sendable{
    
    static public let shared = KeychainManager()
    let service = "com.bbangzip.io.tuist.BBANGZIP"
    
    private init() { }
    
    public func create(
        token: TokenType,
        value: String
    ) {
        let keychainQuery: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: token.account,
            kSecValueData: value.data(using: .utf8, allowLossyConversion: false)!
        ]
        
        SecItemDelete(keychainQuery)
        
        let status: OSStatus = SecItemAdd(keychainQuery, nil)
        assert(status == noErr, "@Log - Failed to save token")
    }
    
    public func read(
        token: TokenType
    ) -> String? {
        
        let keychainQuery: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: token.account,
            kSecReturnData: true,
            kSecMatchLimit: kSecMatchLimitOne
        ]
        
        var cfDataToAnyObject: AnyObject?
        let status = SecItemCopyMatching(
            keychainQuery,
            &cfDataToAnyObject
        )
        
        if status == errSecSuccess {
            let retrievedData = cfDataToAnyObject as! Data
            let value = String(
                data: retrievedData,
                encoding: .utf8
            )
            return value
        } else {
            print("@Log - Failed to read token - status code == \(status)")
            return nil
        }
    }
    
    public func delete(
        token: TokenType
    ) {
        let keychainQuery: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: token.account
        ]
        
        let status = SecItemDelete(keychainQuery)
        assert(status == noErr, "@Log - Failed to delete token")
    }
}
