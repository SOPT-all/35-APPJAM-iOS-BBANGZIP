//
//  KeychainManager.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/19/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import Foundation
import Security

protocol KeyChainManager: Sendable {
    func saveValue(
        token: String,
        type: TokenType
    ) -> OSStatus
    func changeValue(token: String) -> OSStatus
    func searchValue() -> String?
    @discardableResult
    func removeValue() -> OSStatus
}

final class DefaultKeyChainManager: KeyChainManager {
    private let serviceName: String = "com.bbangzip.io.tuist.BBANGZIP"
    
    func saveValue(
        token: String,
        type: TokenType
    ) -> OSStatus {
        let saveData: CFDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: serviceName,
            kSecReturnData: true,
            kSecValueData: token.data(using: .utf8)!
        ] as CFDictionary
        let status = SecItemAdd(saveData, nil)
        handleStatus(status: status)
        return status
    }
    
    func changeValue(token: String) -> OSStatus {
        let savedData: CFDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: serviceName
        ] as CFDictionary
        
        let updateData: CFDictionary = [
            kSecValueData: token.data(using: .utf8)!
        ] as CFDictionary
        return SecItemUpdate(
            savedData,
            updateData
        )
    }
    
    func searchValue() -> String? {
        let savedData: CFDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: serviceName,
            kSecReturnData: true
        ] as CFDictionary
        var searchWord:CFTypeRef? = nil
        let searchResult = SecItemCopyMatching(
            savedData,
            &searchWord
        )
        if searchResult != errSecSuccess {
            return nil
        }
        let searchData: Data = searchWord as! Data
        return String(
            data: searchData,
            encoding: .utf8
        )
    }
    
    @discardableResult
    func removeValue() -> OSStatus {
        let savedData: CFDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: serviceName,
            kSecReturnData: true
        ] as CFDictionary
        return SecItemDelete(savedData)
    }
    
    private func handleStatus(status: OSStatus) {
        switch status {
        case errSecSuccess:
            break
        case errSecDuplicateItem:
            print("duplicated")
        default:
            print("default")
        }
    }
}
