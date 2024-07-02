//
//  File.swift
//  
//
//  Created by Ranjeet Sah on 02/07/2024.
//

import SwiftData

@available(iOS 17, *)
@Model
class Event {
    var eventName: String
    var eventParams: [String:String]

    init(eventName: String, eventParams: [String: String]) {
        self.eventName = eventName
        self.eventParams = eventParams
    }
}
