//
//  AppIDGenerator.swift
//  VelaSDK
//
//  Created by Igbalajobi Elias on 1/16/19.
//  Copyright © 2019 Igbalajobi Elias. All rights reserved.
//

import Foundation
internal class AppIDGenerator{
    private let base10Key = [
    "00", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16",
    "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "31", "33",
    "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50",
    "51", "52", "53", "54", "55", "56", "57", "58", "59", "60", "61", "62", "63", "64", "65", "66", "67",
    "68", "69", "70", "71", "72", "73", "74", "75", "76", "77", "78", "79", "80", "81", "82", "83", "84",
    "85", "86", "87", "88", "89", "90", "91", "92", "93", "94", "95", "96", "97", "98", "99"]
 
    
    private let extendedASCIIValue = [
    "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J",
    "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "a", "b", "c", "d",
    "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x",
    "y", "z", "a0", "a1", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "b1", "b2", "b3", "b4", "b5",
    "b6", "b7", "b8", "b9", "c1", "c2", "c3", "c4", "c5", "c6", "c7", "c8", "c9", "d1", "d2", "d3", "d4",
    "d5", "d6", "d7", "d8", "d9", "e0"];
    
    
    internal func generateUniqueId(deviceImei:String, smsShortCode:String) throws -> String{
        if deviceImei.count != 16{
            throw AppIDGeneratorError.invalidImei(message: "deviceImei length must be == 16")
        }
        
        if smsShortCode.count > 8{
            throw AppIDGeneratorError.invalidSmsShortCode(message: "smsShortCode must be <= 8")
        }

        let pn = deviceImei.substring(to: max(deviceImei.count - 16, 0));
        let concat = "\(pn)\(smsShortCode)"
        
        let concatLength = concat.count
        var seek = concatLength
        let endArg = concatLength % 2
        
        var builder = ""
        while(seek > endArg){
            let captureBegin = concatLength - seek
            let captureEnd = captureBegin + 2
            
            let key = concat.substring(with: captureBegin..<captureEnd)
            builder.append(extendedASCIIValue[keyIndex(key)!])
            
            seek -= 2
        }
        
        if endArg == 1 {builder.append(concat.substring(from: concatLength - 1))}
    }
    
    private func keyIndex(_ key: String) -> Int?{
        return base10Key.firstIndex(of: key)
    }
}

enum AppIDGeneratorError: Error {
    case invalidImei(message: String)
    case invalidSmsShortCode(message: String)
}



