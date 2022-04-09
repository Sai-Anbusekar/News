//
//  NewsHelper.swift
//  News
//
//  Created by Anbusekar Murugesan on 09/04/2022.
//

import Foundation

class NewsHelper: NSObject {
    
    class func convertStringFrom(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        return dateFormatter.string(from: date)
        
    }
    
}
