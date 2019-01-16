//
//  BillPaymentConstant.swift
//  VelaSDK
//
//  Created by Igbalajobi Elias on 12/11/18.
//  Copyright © 2018 Igbalajobi Elias. All rights reserved.
//

import Foundation

public class BillPaymentConstant{
    public static func getAirtimeInfo(service: Service) -> BillProductData{
        switch service {
        case .MTNVTU:
            return json(filename: "airtimebundle")[0]
        case .AirtelVTU:
            return json(filename: "airtimebundle")[1]
        case .GLOVTU:
            return json(filename: "airtimebundle")[2]
        default:
            return json(filename: "airtimebundle")[3]
        }
    }
    
    public static func getTollPackage(service: Service) -> [BillProductData]{
        switch service {
        default:
            return json(filename: "lccpackage")
        }
    }
    
    public static func getInternetPlan(service: Service) -> [BillProductData]{
        switch service {
        case .smileInternet:
            return json(filename: "smileinternetplan")
        case .swiftInternet:
            return json(filename: "swiftinternetplan")
        case .spectranetInternet:
            return json(filename: "spectranetinternetplan")
        case .mtnhynet:
            return json(filename: "mtnhynetplan")
        default:
            return json(filename: "ipnxinternetplan")
        }
    }
    
    public static func getDataInfo(service: Service) -> [DataBillEntry]{
        switch service {
        case .AirtelDATA:
            return json(filename: "airteldatabundle")
        case .MTNDATA:
            return json(filename: "mtndatabundle")
        case .GLODATA:
            return json(filename: "glodatabundle")
        default:
            return json(filename: "9mobiledatabundle")
        }
    }
    
    public static func getTvBouquets(service: Service) -> [BillProductData]{
        switch service {
        case .dstvCableTV:
            return json(filename: "dstvbundle")
        case .gotvCableTV:
            return json(filename: "gotvbundle")
        default:
            return json(filename: "startimesbundle")
        }
    }
    
    public static func getElectricityPackage(service: Service) -> BillProductData{
        switch service {
        case .ikedcPrepaid:
            return json(filename: "ikedcpackage")[1]
        case .ikedcPostpaid:
            return json(filename: "ikedcpackage")[0]
        case .ekoElectricityPrepaid:
            return json(filename: "ekedcpackage")[1]
        default:
            return json(filename: "ekedcpackage")[0]
        }
    }
}

public struct DataBillEntry: Codable {
    var amount: Int!
    var dataCap: String!
    
    var name: String!
    var fee: Int!
    var productId: String!
    var fixedAmount: Bool!
    var maximumAmount: Int!
    var minimumAmount: Int!
}

public enum Service: Int {
    case lccToll = 3
    
    case ikedcPostpaid = 4
    case ikedcPrepaid = 5
    case ekoElectricityPostpaid = 6
    case ekoElectricityPrepaid = 7
    case bet9ja = 8
    case nairabetBetting = 9
    case sureBet = 10
    case merrybetBetting = 11
    case dstvCableTV = 12
    case gotvCableTV = 13
    case starttimesCableTV = 14
    case irokoTV = 15
    case transfer = 17
    
    
    case smileInternet = 1
    case swiftInternet = 2
    case spectranetInternet = 19
    case ipnxInternet = 20
    case mtnhynet = 21
    
    case airtime = 18
    case AirtelVTU = 180
    case MTNVTU = 181
    case GLOVTU = 182
    case NineMobileVTU = 183
    
    case data = 16
    case AirtelDATA = 160
    case MTNDATA = 161
    case GLODATA = 162
    case NineMobileDATA = 163
}

fileprivate func json<T: Codable>(filename: String) -> [T]{
    return try! decodeJSONToObject(filename: filename)
}

fileprivate func decodeJSONToObject<T: Codable>(filename: String) throws -> T{
    let path = Bundle.main.path(forResource: filename, ofType: "json")
    let data = try Data(contentsOf: URL(fileURLWithPath: path!))
    
    return try JSONDecoder().decode(T.self, from: data)
}

public struct BillProductData: Codable {
    var name: String!
    var amount: Int!
    var fee: Int!
    var productId: String!
    var fixedAmount: Bool!
    var maximumAmount: Int
    var minimumAmount: Int
}
