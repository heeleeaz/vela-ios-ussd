//
//  SMSMessagePipeline.swift
//  VelaSDK
//
//  Created by Igbalajobi Elias on 12/9/18.
//  Copyright © 2018 Igbalajobi Elias. All rights reserved.
//

import Foundation
import UIKit

public class SMSMessagePipeline<T: Codable>: SMSMessageProtocol{
    internal var data: T!
    internal var serviceCode: String!
    internal var stamp: String!
    
    public init(data: T, serviceCode: String) {
        self.serviceCode = serviceCode
        self.data = data
    }
    
    public init(serviceCode: String){self.serviceCode = serviceCode}
    
    public func createEncryptedMessage() throws -> String {
        let messageTransmission = MessageTransmission.getInstance(secretKey: SMS_ENCRYPTION_KEY)
        
        self.stamp = generatedStamp()
        let text = try createMessage(stamp: stamp);
        print(text)
        let iv = SMSMessagePipeline.generateIVString()
        let encryptedMessage =  try messageTransmission.aesEncrypt(text: text, iv: iv)
        return SMS_API_TEXT_PREFIX + " " + encryptedMessage
    }
    
    public func createNonEncryptedMessage(stamp: String) throws -> String{
        let encryptedMessage = try createMessage(stamp: stamp)
        return "\(SMS_API_TEXT_PREFIX!) \(encryptedMessage)"
    }
    
    public func createMessage(stamp: String) throws -> String {
        let encoder = JSONEncoder()
        let message = Message(data: self.data, stamp: stamp, serviceCode: serviceCode)
        
        return String(data: try encoder.encode(message), encoding: .utf8)!
    }
    
    public func createCompressedMessage(stamp: String) -> String {return ""}
    
    public func getOTPServiceCode() -> String?{return nil}
    
    public func getMessageStamp() -> String{return self.stamp}
    
    public func getSuccessCode() -> String{
        let stamp = getMessageStamp()
        return stamp.substring(from: stamp.count - 6)
    }
    
    public func getFailedCode() -> String{
        return getMessageStamp().substring(to: 6)
    }
    
    public class func callNumber(phoneNumber: String) {
        if let phoneCallURL:NSURL = NSURL(string:"tel://\(phoneNumber)") {
            let application:UIApplication = UIApplication.shared
            
            let phoneCallUrlURL = phoneCallURL as URL
            if (application.canOpenURL(phoneCallUrlURL)) {
                application.open(phoneCallUrlURL, options: [:]) { (finished) in}
            }
        }
    }
    
    internal static func generateIVString() -> String{
        let flag:Int64 = 0xFFFFFFFFFFFFF
        let currentTime = Int64(Date.timeInMilli) | flag
        let currentTimeString = "\(currentTime)"
        return currentTimeString
    }
}

public var deviceAppImei: Int {
    let identifier = UIDevice.current.identifierForVendor!.uuidString
    let splitted = identifier.split(separator: "-")
    
    var stringIndentifier = String((Int(splitted[splitted.count-1], radix: 16))!);
    stringIndentifier = "1111111111111111\(stringIndentifier)"
    stringIndentifier = stringIndentifier.substring(from: stringIndentifier.count-16)
    
    return Int(stringIndentifier)!
}

public struct Message<T:Codable>: Codable{
    var data: T!
    var stamp: String!
    var serviceCode: String!
}

public protocol SMSMessageProtocol {
    func createEncryptedMessage() throws -> String;
}

public func encodeObjectToJSON<T: Codable>(data: T) throws -> String{
    let encoder = JSONEncoder()
    return String(data: try encoder.encode(data), encoding: .utf8)!
}

public func generatedStamp() -> String {
    let date = Int64(Date.timeInMilli)       //system date
    let intIndentifier = Int64(deviceAppImei)     //identifier
    let value = "111111111111\(String(intIndentifier & date))"
    return value.substring(from: value.count-12)
}

public func decodeJSONToObject<T: Codable>(json: String) throws -> T{
    let decoder = JSONDecoder()
    return try decoder.decode(T.self, from: json.data(using: .utf8)!)
}

let SMS_D_TITLE = "Alert"
let SMS_DIALOG_MESSAGE = APPMessages.SMS_AWARE_NOTIFICATION
let SMS_D_PBTN = "OK"
let SMS_NS_MESSAGE = APPMessages.SMS_SEND_FAILED
