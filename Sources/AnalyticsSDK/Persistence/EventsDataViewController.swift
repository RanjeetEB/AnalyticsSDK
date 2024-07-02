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
        
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        titleLabel.text = "Tracked Events"
        view.addSubview(titleLabel)
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Event")
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 20),
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20)
            
        ])
        
        
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
}
