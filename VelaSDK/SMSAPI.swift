//
//  AccountCreationSMSAPI.swift
//  VelaSDK
//
//  Created by Igbalajobi Elias on 12/11/18.
//  Copyright © 2018 Igbalajobi Elias. All rights reserved.
//

import Foundation

fileprivate let IOS_DEVICE_CODE = "1"

public class AccountCreationStage1SMSAPI: SMSMessagePipeline<AccountCreationStage1SMSAPI.Data>{
    private let SERVICE_CODE = "10"
    
    public init(data: Data) {
        super.init(data: data, serviceCode: SERVICE_CODE)
    }
    
    public class Data: Codable {
        public var password: String!
        public var bank: String!
        public var acctNo: String!
        public var birthDate: String! = "0"
        public var phone: String!
        public var pin: String!
        public var dialingCode: String! = "+234"
        public var deviceImei: String!
    }
    
    override public func createCompressedMessage(stamp: String) -> String {
        return "\(IOS_DEVICE_CODE):\(serviceCode!):\(stamp)!\(data.bank!):\(data.acctNo!):\(data.phone!):\(data.dialingCode!):\(data.pin!):\(data.password!):\(data.birthDate!):\(data.deviceImei!)"
    }
}

public class AccountCreationStage2SMSAPI: SMSMessagePipeline<AccountCreationStage2SMSAPI.Data>{
    private let SERVICE_CODE = "11"
    public var accountCreationStage1SMSAPI: AccountCreationStage1SMSAPI?
    
    public init(){
        super.init(serviceCode: SERVICE_CODE)
    }
    
    public init(data: Data) {
        super.init(data: data, serviceCode: SERVICE_CODE)
    }
    
    public class Data: Codable {
        public var sessionId: String!, otp: String!, appEncryptionKey: String!
    }
    
    override public func createCompressedMessage(stamp: String) -> String {
        return "\(IOS_DEVICE_CODE):\(serviceCode!):\(stamp)!\(data.sessionId!):\(data.otp!):\(data.appEncryptionKey!)"
    }
}

public class OTPConfirmationSMSAPI: SMSMessagePipeline<OTPConfirmationSMSAPI.Data>{
    override public init(data: Data, serviceCode: String) {
        super.init(data: data, serviceCode: serviceCode)
    }
    
    public class Data: Codable {
        public var sessionId: String!, otp: String!
    }
    
    override public func createCompressedMessage(stamp: String) -> String {
        return "\(IOS_DEVICE_CODE):\(serviceCode!):\(stamp)!\(data.sessionId!):\(data.otp!)"
    }
}

public class AccountLoginSMSAPI: SMSMessagePipeline<AccountLoginSMSAPI.Data>{
    private let SERVICE_CODE = "20";
    
    public init() {
        super.init(serviceCode: SERVICE_CODE)
    }
    
    init(data: Data) {
        super.init(data: data, serviceCode: SERVICE_CODE)
    }
    
    class Data: Codable {
        var userId: String!
        var password: String!
        var phoneNo: String!
        //        var dialingCode: String = "+234"
        var deviceImei: String!
    }
    
    override public func createCompressedMessage(stamp: String) -> String {
        return "\(IOS_DEVICE_CODE):\(serviceCode!):\(stamp)!\(data.userId!):\(data.phoneNo!):\(data.password!):\(data.deviceImei!)"
    }
}

public class UserProfileUpdateSMSAPI: SMSMessagePipeline<UserProfileUpdateSMSAPI.Data>{
    private let SERVICE_CODE = "30";
    
    public init(data: Data) {
        super.init(data: data, serviceCode: SERVICE_CODE)
    }
    
    public class Data: Codable {
        public var firstName: String?
        public var lastName: String?
        public var email: String?
        public var userId: String!
        public var deviceImei: String!
    }
    
//    public override func createCompressedMessage(stamp: String) -> String {
//        return "\(IOS_DEVICE_CODE):\(serviceCode!):\(stamp)!\(data.userId!):\(data.phoneNo!):\(data.password!):\(data.deviceImei!)"
//    }
}

public class CashTransferSMSAPI: SMSMessagePipeline<CashTransferSMSAPI.Data>{
    private let SERVICE_CODE = "40";
    
    public init() {
        super.init(serviceCode: SERVICE_CODE)
    }
    
    public init(data: Data) {
        super.init(data: data, serviceCode: SERVICE_CODE)
    }
    
    override public func getOTPServiceCode() -> String {return "41"}
    
    public class Data: Codable {
        public var userId: String!, pin: String!, amount: Int!, accountNo: String!
        public var bank: String!, sourceBankAccountId: String!, destinationBankAccountName: String?
        public var isSaveBeneficiary: Bool = false
        
        public enum CodingKeys: CodingKey {
            case userId, pin, amount, accountNo, bank, sourceBankAccountId
        }
    }
    
    override public func createCompressedMessage(stamp: String) -> String {
        return "\(IOS_DEVICE_CODE):\(serviceCode!):\(stamp)!\(data.userId!):\(data.pin!):\(data.amount!):\(data.sourceBankAccountId!):\(data.accountNo!):\(data.bank!):\(data.isSaveBeneficiary)"
    }
}

public class BillPaymentSMSAPI: SMSMessagePipeline<BillPaymentSMSAPI.Data>{
    private var SERVICE_CODE = "51";
    
    public init() {
        super.init(serviceCode: SERVICE_CODE)
    }
    
    public init(data: Data) {
        super.init(data: data, serviceCode: SERVICE_CODE)
    }
    
    public class Data: Codable {
        public var userId: String!, pin: String!, amount: Int!, customerId: String!;
        public var billProductId: String!, accountId: String!
    }
    
    override public func createCompressedMessage(stamp: String) -> String{
        return "\(IOS_DEVICE_CODE):\(serviceCode!):\(stamp)!\(data.userId!):\(data.pin!):\(data.accountId!):\(data.customerId!):\(data.billProductId!):\(data.amount!)"
    }
    
    override public func getOTPServiceCode() -> String {return "52"}
}

public class NewBankAccountSMSAPI: SMSMessagePipeline<NewBankAccountSMSAPI.Data>{
    private let SERVICE_CODE = "33";
    
    public init(data: Data) {
        super.init(data: data, serviceCode: SERVICE_CODE)
    }
    
    public class Data: Codable {
        public var userId: String!
        public var bank: String!
        public var acctNo: String!
        public var deviceImei: String!
        public var dateOfBirth: String?
        public var accountType: String?
        public var phone: String?
        public var accountName: String?
        
        public enum CodingKeys:  CodingKey {
            case userId, bank, acctNo, deviceImei
        }
    }
    
    override public func getOTPServiceCode() -> String? {return "34"}
}

public class PinUpdatePipeline: SMSMessagePipeline<PinUpdatePipeline.Data>{
    private let SERVICE_CODE = "32"
    
    public init(data: Data) {
        super.init(data: data, serviceCode: SERVICE_CODE)
    }
    
    public class Data: Codable {
        public var newPin: String!
        public var currentPin: String!
        public var userId: String!
        public var deviceImei: String!
    }
}

public class PasswordUpdatePipeline: SMSMessagePipeline<PasswordUpdatePipeline.Data>{
    private let SERVICE_CODE = "31"
    
    public init(data: Data) {
        super.init(data: data, serviceCode: SERVICE_CODE)
    }
    
    public class Data: Codable {
        public var currentPassword: String!
        public var newPassword: String!
        public var userId: String!
        public var deviceImei: String!
    }
}


public func IdFromPhoneNumber(phoneNumber: String) -> String{
    let phoneNumber = phoneNumber.substring(from: max(0, phoneNumber.count - 10))
    let prefix = phoneNumber.prefix(2)
    let suffix = phoneNumber.suffix(from: phoneNumber.index(from: 2))
    //    print("phoneNumber: \(phoneNumber) prefix: \(prefix) suffix: \(suffix)")
    
    let numberPrefix = Int(prefix)!
    let numberSufix = Int(suffix)!
    let value = (numberPrefix * numberSufix) / 100
    
    let id = String(value)
    //    print("value: \(id) size: \(id.count)")
    
    return id
}
