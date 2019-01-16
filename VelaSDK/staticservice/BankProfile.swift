//
//  BankRecord.swift
//  VelaSDK
//
//  Created by Igbalajobi Elias on 12/9/18.
//  Copyright © 2018 Igbalajobi Elias. All rights reserved.
//

import Foundation

public class BankProfile{
    public static var BankList: [Bank] = {
        return [
            Bank(name: "Access Bank",  code: "044"),
            Bank(name: "Access Mobile",  code: "323"),
            Bank(name: "Afribank Nigeria",code: "014"),
            Bank(name: "Aso Savings and Loans", code: "401"),
            Bank(name: "Coronation Merchant Bank",  code: "559"),
            Bank(name: "Diamond Bank", code: "063"),
            Bank(name: "Ecobank Mobile", code: "307"),
            Bank(name: "Ecobank Nigeria", code: "050"),
            Bank(name: "Enterprise Bank", code: "084"),
            Bank(name: "FBN Mobile", code: "309"),
            Bank(name: "Fidelity Bank", code: "070"),
            Bank(name: "First Bank", code: "011"),
            Bank(name: "FCMB", code: "214"),
            Bank(name: "FSDH Merchant Bank Limited", code: "601"),
            Bank(name: "GTBank Mobile Money", code: "315"),
            Bank(name: "GTBank", code: "058"),
            Bank(name: "Heritage Bank", code: "030"),
            Bank(name: "Keystone Bank", code: "082"),
            Bank(name: "Parkway", code: "311"),
            Bank(name: "Parralax Bank", code: "526"),
            Bank(name: "PAYCOM", code: "305"),
            Bank(name: "Skye Bank", code: "076"),
            Bank(name: "STANBIC IBTC Bank", code: "221"),
            Bank(name: "Stanbic Mobile",code: "304"),
            Bank(name: "Standard Chatered Bank", code: "068"),
            Bank(name: "Sterling Bank", code: "232"),
            Bank(name: "Union Bank", code: "032"),
            Bank(name: "UBA Bank", code: "033"),
            Bank(name: "Unity Bank", code: "215"),
            Bank(name: "Wema Bank", code: "035"),
            Bank(name: "Zenith Bank",code: "057"),
            Bank(name: "Zenith Mobile", code: "322")]
    }()
    
//    public class func readableAccountInfo(accountModel: UserAccountModel) -> String{
//        let name = AccountHelper.getBankWith(bankCode: accountModel.bankCode)!.name
//        return composeAccountInfo(bankName: name, accountNumber: accountModel.accountNumber)
//    }
//
//
    public class func readableAccountInfo(bankCode: String, accountNumber: String) -> String{
        let bankName = getBankWith(bankCode: bankCode)!.name
        return readableAccountInfo(bankName: bankName, accountNumber: accountNumber)
    }
    
    public class func readableAccountInfo(bankName:String, accountNumber:String) -> String{
        return "\(bankName) [\(accountNumber)]"
    }
    
    public class func getBankWith(bankCode: String) -> Bank?{
        let bankList = BankProfile.BankList
        for b in bankList{if b.code.elementsEqual(bankCode){return b}}
        return nil
    }
    
    public static func getBankWith(bankName: String) -> Bank?{
        let availableBanks = BankProfile.BankList
        for i in 0..<availableBanks.count{
            let bank = availableBanks[i]
            if bank.name.elementsEqual(bankName){return bank}
        }
        return nil
    }
    
//    public static func getAccount(accountInfo: String?) -> UserAccountModel?{
//        guard let accountInfo = accountInfo else {return nil}
//
//        do{
//            let accountNumber = "\\[(.*?)\\]".firstMatchIn(text: accountInfo, atRangeIndex: 1)
//            let accountRecord = try UserAccountRecord()
//            let account = try accountRecord.getAccountWith(accountNumber: accountNumber)
//            return account.count>0 ? account[0] : nil
//
//        }catch{
//            return nil
//        }
//    }
    
//    static func addAccount(bank:String, acctNo:String, acctName:String?) throws -> Bool {
//        let accountId = AccountHelper.accountIdFromAccount(bankCode: bank, accountNumber: acctNo)
//
//        let accountRecord = try UserAccountRecord()
//        return try accountRecord.addAccount(bank, acctNo, accountId, acctName)
//    }
//
//    static func getAccountInfo(accountId: String) -> String?{
//        guard let model = getAccountModelWith(accountId: accountId) else {return nil}
//        return AccountHelper.composeAccountInfo(accountModel: model)
//    }
    
//    static func getAccountModelWith(accountId: String) -> UserAccountModel?{
//        do{
//            let account = try UserAccountRecord().getAccountWith(accountId: accountId)
//            return account.count>0 ? account[0] : nil
//        }catch{
//            return nil;
//        }
//    }
    
    public static func accountIdFromAccount(bankCode:String, accountNumber:String) -> String{
        return bankCode + accountNumber
    }
    
    public static var BankAccountTypes: [BankAccountType] = {
        return [BankAccountType(accountTypeName: "Savings", accountTypeCode: "1"),
                BankAccountType(accountTypeName: "Current", accountTypeCode: "2")]
    }()
}

struct BankAccountType {
    var accountTypeName: String!, accountTypeCode: String!
}

struct Bank{
    public var name: String, code: String
}
