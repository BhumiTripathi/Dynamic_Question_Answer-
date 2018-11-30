//
//  ParseJson.swift
//  CuraTech
//
//  Created by Bhumika tripathi on 8/11/18.
//  Copyright © 2018 Bhumika tripathi. All rights reserved.
//

import Foundation
class ParseJson: NSObject {

    func ParseJsonFile( fileName : String?, completionHandler:@escaping ([[String:Any]]) -> Void) {
        
        let filePath = Bundle.main.path(forResource: fileName!, ofType: "json")
        let json = try? String(contentsOfFile: filePath ?? "", encoding: .utf8)
        var _: Error? = nil
        var arrFetchData: [[String:Any]]? = nil
        if let anEncoding = json?.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue)) {
            arrFetchData = try! JSONSerialization.jsonObject(with: anEncoding, options: .mutableLeaves) as?  [[String:Any]]
        }
        completionHandler(arrFetchData!)
    }
}
