//
//  API.swift
//  VelaSDK
//
//  Created by Igbalajobi Elias on 12/8/18.
//  Copyright © 2018 Igbalajobi Elias. All rights reserved.
//

import Foundation

public class VelaAPI{
    public init(){}
    
    open func smsAPIShortCode(isLive: Bool=false) -> String {
        return isLive ? "38350" : "34461"
    }
    
    open func smsAPITextPrefix() -> String { return "VELA"}
    
    open func smsEncryptionKey() -> String {return "#*v3l@?b:s0ln*#$"}
    
    open func messageDefault(type: VelaMessageDefault) -> String{
        switch type {
        case .MESSAGE_APP_NOT_AVAILABLE:
            return "Your device is not able to send text messages"
        case .SMS_AWARE_NOTIFICATION:
            return "Vela will like to send a message to proceed. Tap OK to continue. SMS charge is free"
        case .SMS_SEND_FAILED:
            return "Message couldn't be sent, Please Try again."
        }
    }
    
    open func merchantSharedCode() -> String? { return nil}
    
    internal func clientAppID() throws -> String {
        let smsShortCode = smsAPIShortCode() + (merchantSharedCode() ?? "")
        let deviceImei = String(deviceAppImei)
        
        let appIdGenerator = AppIDGenerator()
        
        return try appIdGenerator.generateUniqueId(deviceImei: deviceImei, smsShortCode: smsShortCode)
    }
}

public enum VelaMessageDefault {
    case MESSAGE_APP_NOT_AVAILABLE, SMS_AWARE_NOTIFICATION, SMS_SEND_FAILED
}

public func initVela(api: VelaAPI = VelaAPI(), isLive: Bool = false){
    SMS_API_SHORT_CODE = api.smsAPIShortCode(isLive: isLive)
    SMS_API_SHORT_CODE = api.smsAPITextPrefix()
    SMS_ENCRYPTION_KEY = api.smsEncryptionKey()
    CLIENT_APP_ID = try? api.clientAppID()
    MERCHANT_SHARED_CODE = api.merchantSharedCode()
    
    APPMessages.MESSAGING_APP_NOT_AVAILABLE = api.messageDefault(type: .MESSAGE_APP_NOT_AVAILABLE)
}


internal var SMS_API_SHORT_CODE: String!
internal var SMS_API_TEXT_PREFIX: String!
internal var SMS_ENCRYPTION_KEY: String!
internal var CLIENT_APP_ID: String!
internal var MERCHANT_SHARED_CODE: String?

internal struct APPMessages{
    static var MESSAGING_APP_NOT_AVAILABLE: String!
    static var SMS_AWARE_NOTIFICATION: String!
    static var SMS_SEND_FAILED: String!
}
