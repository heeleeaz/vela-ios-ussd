//
//  MessageTransmission.swift
//  VelaSDK
//
//  Created by Igbalajobi Elias on 12/11/18.
//  Copyright © 2018 Igbalajobi Elias. All rights reserved.
//

import Foundation
import CryptoSwift

internal class MessageTransmission{
    private var aesKey: AES!
    private var SECRET_KEY: String!
    
    private convenience init(secretKey: String){
        self.init()
        self.SECRET_KEY = secretKey
    }
    
    internal class func getInstance(secretKey: String) -> MessageTransmission{
        return MessageTransmission(secretKey: secretKey)
    }
    
    internal func aesEncrypt(text: String, iv: String) throws -> String{
        let data = text.data(using: .utf8)!
        let encrypted = try! AES(key: SECRET_KEY, iv: iv, padding: .pkcs5).encrypt([UInt8](data))
        let encryptedString = Data(encrypted).base64EncodedString()
        
        return injectIVInEncryptedString(encrypted: encryptedString, iv: iv)
    }
    
    internal func injectIVInEncryptedString(encrypted: String, iv: String) -> String{
        let aIndex = encrypted.index(encrypted.endIndex, offsetBy: -2)
        let a = encrypted.prefix(upTo: aIndex)
        let b = encrypted.suffix(from: aIndex)
        return a + iv + b
    }
    
    internal func splitDataAndIVFromEncryptedString(encryptedText: String) -> [String]{
        var array = [String]()
        
        //fetch message
        let aIndex = encryptedText.index(encryptedText.endIndex, offsetBy: -18)
        let a = encryptedText.prefix(upTo: aIndex)
        let bIndex = encryptedText.index(encryptedText.endIndex, offsetBy: -2)
        let b = encryptedText.suffix(from: bIndex)
        array.append(String(a+b))
        
        //iv fetch
        let ivStart = encryptedText.index(encryptedText.endIndex, offsetBy: -18)
        let ivEnd = encryptedText.index(encryptedText.endIndex, offsetBy: -2)
        let iv = encryptedText[ivStart..<ivEnd]
        array.append(String(iv))
        
        return array
    }
    
    internal func aesDecrypt(encryptedText: String) throws -> String{
        let a = splitDataAndIVFromEncryptedString(encryptedText: encryptedText)
        return try aesDecrypt(encryptedString: a[0], iv: a[1])
    }
    
    internal func aesDecrypt(encryptedString: String, iv: String) throws -> String {
        let data = Data(base64Encoded: encryptedString)!
        let decrypted = try! AES(key: SECRET_KEY, iv: iv).decrypt([UInt8](data))
        let decryptedData = Data(decrypted)
        return String(bytes: decryptedData.bytes, encoding: .utf8) ?? "Could not decrypt"
    }
}
