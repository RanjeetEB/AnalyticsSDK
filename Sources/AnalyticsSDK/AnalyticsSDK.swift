// The Swift Programming Language
// https://docs.swift.org/swift-book

import UIKit
import SwiftData

@available(iOS 17, *)
public class EventTracking {
    
    var container: ModelContainer?
    
    public init() {
        container = try? ModelContainer(for: Event.self)
    }
    
    @MainActor
    public func startTracking() {
        UserDefaults.standard.setValue(true, forKey: "isTracking")
        self.addEvent(eventName: "Tracking Started", eventParams: ["event": "tracking_started"])
    }
    
    
    @MainActor
    public func stopTracking() {
        self.addEvent(eventName: "Tracking Stopped", eventParams: ["event": "tracking_stopped"])
        UserDefaults.standard.setValue(false, forKey: "isTracking")
    }
    
    @MainActor
    public func addEvent(eventName: String, eventParams: [String: String]) {
        
        if UserDefaults.standard.bool(forKey: "isTracking") == true {
            let event = Event(eventName: eventName, eventParams: eventParams)
            container?.mainContext.insert(event)
        }
    }
    
    public func showEvents(navController: UINavigationController) {
        
        let eventsController = EventsDataViewController()
        navController.present(eventsController, animated: true)
    }
    
    @MainActor public func resetEvents() {
        try? container?.mainContext.delete(model: Event.self)
    }
}
