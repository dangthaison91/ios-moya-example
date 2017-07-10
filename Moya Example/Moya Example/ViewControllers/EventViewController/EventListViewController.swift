//
//  EventsFeedViewController.swift
//  actisso
//
//  Created by Viet Nguyen Tran on 5/28/17.
//  Copyright (c) 2017 Innovatube. All rights reserved.
//

import RxSwift
import RxCocoa
import RxDataSources
import ObjectMapper

class EventListViewController: UIViewController {
    
    // MARK: - UI
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Private
    
    fileprivate let loadMoreSubject: PublishSubject<Void> = PublishSubject<Void>()
    
    fileprivate let dataSource = RxTableViewSectionedAnimatedDataSource<EventFeedSectionModel>()
    fileprivate let disposeBag: DisposeBag = DisposeBag()
    fileprivate let eventsProvider: PaginationAPI<Events> = PaginationAPI<Events>(limit: 16, request: EventListViewController.getEvents)

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        defer { loadMoreSubject.onNext() }
        configureTableView()

        let events = eventsProvider
            .elements
            .scan([Event]()) { $0 + $1 }
            .map { events in return events.map { EventFeedCellModel(event: $0) } }
            .map { [EventFeedSectionModel(header: "", events: $0)] }
            .asDriver(onErrorJustReturn: [])

        events
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        let errors = eventsProvider.errors
    }

    private class func getEvents(offset: Int, limit: Int) -> Observable<Events> {
        let eventsTarget = EventsTargets.GetEventsTarget(offset: offset, limit: limit, categoryId: nil)

        return API
            .authenticateRequest(target: eventsTarget)
            .mapObject(Events.self)
    }

}

// MARK: - Configure View Controller
fileprivate extension EventListViewController {
    
    func configureTableView() {
        tableView.rowHeight = 240
        tableView.registerCell(type: EventFeedCell.self)
        dataSource.configureCell = { dataSource, tableView, indexPath, model in
            let cell = tableView.dequeueReusableCell(type: EventFeedCell.self, for: indexPath)
            cell.setCellModel(model)
            return cell
        }

        // LoadMore
        tableView
            .rx.shouldBatchFetching
            .throttle(0.5, scheduler: MainScheduler.instance)
            .bind(to: eventsProvider.loadNextTrigger)
            .disposed(by: disposeBag)
    }
}
