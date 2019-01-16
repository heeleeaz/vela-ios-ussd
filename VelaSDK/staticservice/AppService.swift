//
//  VelaStaticService.swift
//  VelaSDK
//
//  Created by Igbalajobi Elias on 12/9/18.
//  Copyright © 2018 Igbalajobi Elias. All rights reserved.
//

import Foundation

public enum AppService: Int {
    case InternetSmile, Internet_Swift, lccToll, ikejaElectricityPostpaid, ikejaElectricityPrepaid
    case ekoElectricityPostpaid, ekoElectricityPrepaid, bet9jaBetting, nairabetBetting
    case surebetBetting, merrybetBetting, dstvCableTV, gotvCableTV, starttimesCableTV, irokoTV, data
    case transfer, airtime
}

public class Services {
    class func getServiceInfo(serviceId: Int) -> ServiceInfo?{
        return getServiceInfo(service: AppService(rawValue: serviceId))
    }
    
    public class func getServiceInfo(service: AppService) -> ServiceInfo {
        switch service{
        case .Internet_Swift:
            return ServiceInfo(name:"Swift NG Subscription", logo:"logo-swift")
        case .InternetSmile:
            return ServiceInfo(name:"Smile NG Subscription", logo:"logo-smile")
        case .lccToll:
            return ServiceInfo(name:"LCC Prepaid toll fees", logo:"logo-lcc")
        case .ikejaElectricityPostpaid:
            return ServiceInfo(name:"Ikeja Electric Postpaid", logo:"logo-iedc")
        case .ikejaElectricityPrepaid:
            return ServiceInfo(name:"Ikeja Electric Prepaid", logo:"logo-iedc")
        case .ekoElectricityPostpaid:
            return ServiceInfo(name:"EKO Electric Postpaid", logo:"logo-ekedc")
        case .ekoElectricityPrepaid:
            return ServiceInfo(name:"Eko Electric Prepaid", logo:"logo-ekedc")
        case .nairabetBetting:
            return ServiceInfo(name:"NairaBet", logo:"logo-nairabet")
        case .surebetBetting:
            return ServiceInfo(name:"SureBet", logo:"logo-surebet")
        case .merrybetBetting:
            return ServiceInfo(name:"MerryBet", logo:"logo-merrybet")
        case .bet9jaBetting:
            return ServiceInfo(name:"Bet9ja", logo:"logo-bet9ja")
        case .dstvCableTV:
            return ServiceInfo(name:"DSTV Subscription", logo:"logo-dstv")
        case .gotvCableTV:
            return ServiceInfo(name:"GoTV Subscription", logo:"logo-gotv")
        case .starttimesCableTV:
            return ServiceInfo(name:"Startimes Subscription", logo:"logo-startimes")
        case .irokoTV:
            return ServiceInfo(name:"iROKOtv", logo:"logo-irokotv")
        case .data:
            return ServiceInfo(name:"Data Subscription", logo: "ic-data-recharge")
        case .transfer:
            return ServiceInfo(name:"Transfer", logo: "ic-transfer")
        case .airtime:
            return ServiceInfo(name:"Airtime", logo: "ic-airtime-recharge")
        default:
            return nil
        }
    }
    
    public class func getTVPackages(service: AppService) -> [CableTVPurchaseBundle]?{
        switch service {
        case .dstvCableTV:
            return [CableTVPurchaseBundle("DSTV Compact Plus", service)]
        case .gotvCableTV:
            return [CableTVPurchaseBundle("GoTV Plus", service)]
        case .starttimesCableTV:
            return [CableTVPurchaseBundle("Smart", service)]
        default:
            return nil
        }
    }
    
    public class func getInternetPlan(operatorID: String) -> [InternetPlan]{
        return [InternetPlan(operatorID: operatorID, categoryID: "1", categoryName: "Daily Plan"),
                InternetPlan(operatorID: operatorID, categoryID: "2", categoryName: "Weekly Plan"),
                InternetPlan(operatorID: operatorID, categoryID: "3", categoryName: "Monthly Plan")]
    }
    
    
    public class func getTVAvailableValidity(_ service: AppService) -> [String]{
        return ["1 Month", "2 Months", "3 Months", "4 Months"]
    }
}


public struct ServiceInfo {
    public var name: String!, logo: String?
}

public struct CableTVPurchaseBundle {
    public var package: String?, validity: String?, tvType: AppService
}

public struct NetworkOperator{
    var operatorID: String, operatorName: String
}

public struct InternetPlan {
    var operatorID: String, categoryID: String, categoryName: String
}
