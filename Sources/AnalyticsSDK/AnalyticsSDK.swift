// The Swift Programming Language
// https://docs.swift.org/swift-book

import UIKit
import SwiftData

public class EventTracking {
    
    public init() {
       
    }
    
    public func startTracking() {
        UserDefaults.standard.setValue(true, forKey: "isTracking")
    }
    
    
    public func stopTracking() {
        UserDefaults.standard.setValue(false, forKey: "isTracking")
    }
    
    @MainActor @available(iOS 17, *)
    public func addEvent(eventName: String, eventParams: [String: String]) {
        
        if UserDefaults.standard.bool(forKey: "isTracking") == true {
            let container = try? ModelContainer(for: Event.self)
            let event1 = Event(eventName: eventName, eventParams: eventParams)
            container?.mainContext.insert(event1)
        }
    }
    
    @available(iOS 17, *)
    public func showEvents(navController: UINavigationController) {
        
        let eventsController = EventsDataViewController()
        navController.present(eventsController, animated: true)
    }
}
