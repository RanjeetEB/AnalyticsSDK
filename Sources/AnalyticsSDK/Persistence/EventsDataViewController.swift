//
//  EventsDataViewController.swift
//
//
//  Created by Ranjeet Sah on 02/07/2024.
//

import UIKit
import SwiftData

enum Section {
    case events
}

@available(iOS 17, *)
public class EventsDataViewController: UIViewController {
    
    var container: ModelContainer?
    
    var tableView: UITableView!
    var dataSource: UITableViewDiffableDataSource<Section, Event>?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        container = try? ModelContainer(for: Event.self)
        loadEvents()
    }
    
    public override func loadView() {
        super.loadView()

        createTableViewWithTitle()
        createDataSource()
    }
    
    func createTableViewWithTitle() {
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Event")
        
    }
    
    func createDataSource() {
        
        dataSource = UITableViewDiffableDataSource<Section, Event>(tableView: tableView) { tableView, indexPath, event in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Event", for: indexPath)
            var content = UIListContentConfiguration.cell()
            content.text = "\(event.eventName) with parameters:  \(event.eventParams)."
            cell.contentConfiguration = content
            
            return cell
        }
        
    }

    
    func loadEvents() {
        let descriptor = FetchDescriptor<Event>()
        let events = (try? container?.mainContext.fetch(descriptor)) ?? []

        var snapshot = NSDiffableDataSourceSnapshot<Section, Event>()
        snapshot.appendSections([.events])
        snapshot.appendItems(events)
        dataSource?.apply(snapshot, animatingDifferences: false)
    }
    
    func resetEvents() {
        try? container?.mainContext.delete(model: Event.self)
    }
}
