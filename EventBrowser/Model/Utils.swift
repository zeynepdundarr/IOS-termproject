//
//  Utils.swift
//  EventBrowser
//
//  Created by Zeynep on 2.01.2022.
//

import Foundation


class Utils{
    
    static let shared = Utils()
    
    func getEventByCategory(category: String, events: [Event]) -> [Event]{
        
        let filtered = events.filter { event in return event.category == category
        }
        return filtered
    }
    
    func getEventByName(name: String, events: [Event]) -> [Event]{
        
        let filtered = events.filter { event in return event.name == name
        }
        return filtered
    }
    
    
}
