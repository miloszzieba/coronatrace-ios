//
//  DashboardViewController.swift
//  coronatrace-ios
//
//  Created by Patryk Mieszała on 17/03/2020.
//  Copyright (c) 2020 Coronatrace. All rights reserved.
//

import UIKit

protocol DashboardViewControllerLogic: AnyObject {
    func reloadList(snapshot: NSDiffableDataSourceSnapshot<String, DBLocationModel>)
}

final class DashboardViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    private lazy var dataSource: UITableViewDiffableDataSource<String, DBLocationModel> = UITableViewDiffableDataSource(
        tableView: tableView,
        cellProvider: { (tableView, indexPath, location) -> UITableViewCell in
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = "lat: \(location.latitude), long: \(location.longitude)"
            cell.detailTextLabel?.text = "date: \(Date(timeIntervalSince1970: location.timestamp))"
            
            return cell
    })
    
    var interactor: DashboardInteractorLogic?
    var router: DashboardRouterType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        interactor?.refresh()
    }
}

extension DashboardViewController: DashboardViewControllerLogic {
    func reloadList(snapshot: NSDiffableDataSourceSnapshot<String, DBLocationModel>) {
        dataSource.apply(snapshot)
        tableView.refreshControl?.endRefreshing()
    }
}

private extension DashboardViewController {
    func setup() {
        let refresh = UIRefreshControl()
        refresh.addTarget(interactor, action: #selector(interactor?.refresh), for: .valueChanged)
        
        tableView.refreshControl = refresh
        dataSource.defaultRowAnimation = .fade
    }
}
