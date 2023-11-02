//
//  Bundle+Ext.swift
//  b8ndDiary
//
//  Created by dgsw8th36 on 11/2/23.
//

import Foundation

extension Bundle {
    
    var apiKey: String? {
        guard let file = self.path(forResource: "Secrets", ofType: "plist"),
              let resource = NSDictionary(contentsOfFile: file),
              let key = resource["ServerApi"] as? String else {
            print("⛔️ API KEY를 가져오는데 실패하였습니다.")
            return nil
        }
        return key
    }
    
}
