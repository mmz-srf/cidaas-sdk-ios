//
//  EntityToModelConverter.swift
//  sdkiOS
//
//  Created by ganesh on 25/07/18.
//  Copyright © 2018 Cidaas. All rights reserved.
//

import Foundation

public class EntityToModelConverter {
    
    // shared instance
    public static var shared : EntityToModelConverter = EntityToModelConverter()
    public var userDefaults = UserDefaults.standard
    
    
    // access token entity to model
    public func accessTokenEntityToAccessTokenModel(accessTokenEntity : AccessTokenEntity, callback: @escaping (AccessTokenModel)-> Void) {
        let salt = randomString(length: 16)
        let key = randomString(length: 16)
        // Set attributes
        let attributes: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "salt,key",
            kSecValueData as String: salt + "," + key,
        ]
        SecItemAdd(attributes as CFDictionary, nil)
        AccessTokenModel.shared.expires_in = accessTokenEntity.expires_in
        AccessTokenModel.shared.id_token = accessTokenEntity.id_token
        AccessTokenModel.shared.refresh_token = try! accessTokenEntity.refresh_token.aesEncrypt(key: key, iv: salt)
        AccessTokenModel.shared.sub = accessTokenEntity.sub
        AccessTokenModel.shared.access_token = try! accessTokenEntity.access_token.aesEncrypt(key: key, iv: salt)
        
        callback(AccessTokenModel.shared)
    }
    
    // access token model to entity
    public func accessTokenModelToAccessTokenEntity(accessTokenModel : AccessTokenModel = AccessTokenModel.shared, callback: @escaping (AccessTokenEntity)-> Void) {
        let accessTokenEntity = AccessTokenEntity()
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "salt,key",
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true,
        ]
        var item: CFTypeRef?
        // Check if user exists in the keychain
        if SecItemCopyMatching(query as CFDictionary, &item) == noErr {
            // Extract result
            if let existingItem = item as? [String: Any] {
                let saltKey = existingItem[kSecValueData as String] as! String
                let salt = saltKey.components(separatedBy: ",")[0]
                let key = saltKey.components(separatedBy: ",")[1]
                
            }
        }
            
            let salt: String = userDefaults.object(forKey: "salt") as! String
            let key: String = userDefaults.object(forKey: "key") as! String
            accessTokenEntity.expires_in = accessTokenModel.expires_in
            accessTokenEntity.id_token = accessTokenModel.id_token
            accessTokenEntity.refresh_token = try! accessTokenModel.refresh_token.aesDecrypt(key: key, iv: salt)
            accessTokenEntity.sub = accessTokenModel.sub
            
            accessTokenEntity.access_token = try! accessTokenModel.access_token.aesDecrypt(key: key, iv: salt)
            
            callback(accessTokenEntity)
        }
        
        public func randomString(length: Int) -> String {
            
            let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            let len = UInt32(letters.length)
            
            var randomString = ""
            
            for _ in 0 ..< length {
                let rand = arc4random_uniform(len)
                var nextChar = letters.character(at: Int(rand))
                randomString += NSString(characters: &nextChar, length: 1) as String
            }
            
            return randomString
        }
    }

