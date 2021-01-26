//
//  TransactionDetailViewModel.swift
//  RevenueCatTracker
//
//  Created by Joan Cardona on 25/1/21.
//

import Foundation
import ReSwift

protocol TransactionDetailViewModelDelegate: class {
    func updateView(newState: TransactionDetailViewModel.TransactionDetailState, oldState: TransactionDetailViewModel.TransactionDetailState?)
}

class TransactionDetailViewModel: StoreSubscriber {
    var currentState: TransactionDetailState?
    weak var delegate: TransactionDetailViewModelDelegate?
    typealias StoreSubscriberStateType = TransactionDetailState
    let timeService: TimeService
    var data: [TableViewData] = []
    
    init(timeService: TimeService) {
        self.timeService = timeService
    }
    
    func subscribe() {
        mainStore.subscribe(self, transform: {
            $0.select(TransactionDetailState.init)
        })
    }
    
    func unsubscribe() {
        mainStore.dispatch(MainStateAction.updateSubscriber(nil))
        mainStore.dispatch(MainStateAction.selectTransaction(nil))
        mainStore.unsubscribe(self)
    }
    
    func getSubscriber() {
        mainStore.dispatch(fetchSubscriber)
    }
    
    func newState(state: TransactionDetailState) {
        let oldState = self.currentState
        self.currentState = state
        if let s = self.currentState?.subscriber {
            data = mapSubscriberIntoData(subscriber: s)
        }
        delegate?.updateView(newState: state, oldState: oldState)
    }
}

extension TransactionDetailViewModel {
    struct TransactionDetailState: Equatable {
        var selectedTransaction: Transaction?
        var subscriber: Subscriber?
        
        init(_ state: MainState) {
            selectedTransaction = state.selectedTransaction
            subscriber = state.subscriber
        }
    }
}

extension TransactionDetailViewModel {
    enum Section: String, CaseIterable, Equatable {
        case details = "Customer Details"
        case attributes = "Customer Attributes"
        case history = "Customer History"
    }

    struct TableViewData: Equatable {
        let section: Section
        let rowData: TableViewRowData
    }

    struct TableViewRowData: Equatable {
        let title: String
        let detail: String?
    }
    
    func mapSubscriberIntoData(subscriber: Subscriber) -> [TableViewData] {
        var subData = mapSubscriberIntoDetailsData(subscriber: subscriber)
        subData.append(contentsOf: mapSubscriberIntoAttributesData(subscriber: subscriber))
        subData.append(contentsOf: mapSubscriberIntoHistoryData(subscriber: subscriber))
        return subData
    }
    
    func mapSubscriberIntoDetailsData(subscriber: Subscriber) -> [TableViewData] {
        let subscriberId = subscriber.appUserId
        let app = subscriber.app.name
        let country = subscriber.lastSeenCountry
        let dollarsSpent = subscriber.dollarsSpent
        let userSince = timeService.readableDate(fromDate: subscriber.createdAt, toDate: timeService.now(), unitStyle: .full) ?? "-"

        return [TableViewData(section: .details, rowData: TableViewRowData(title: subscriberId, detail: "App User Id")),
                TableViewData(section: .details, rowData: TableViewRowData(title: app, detail: "App name")),
                TableViewData(section: .details, rowData: TableViewRowData(title: country, detail: "Country")),
                TableViewData(section: .details, rowData: TableViewRowData(title:  String(format: "$%.2f", dollarsSpent), detail: "Total Spent")),
                TableViewData(section: .details, rowData: TableViewRowData(title:  userSince, detail: "User Since"))]
    }
    
    func mapSubscriberIntoAttributesData(subscriber: Subscriber) -> [TableViewData] {
        var attributesArray: [TableViewData] = []
        attributesArray.append(TableViewData(section: .attributes, rowData: TableViewRowData(title: subscriber.lastSeenPlatform, detail: "Last Platform Seen")))
        
        if let attribution = subscriber.attributionFields {
            attributesArray.append(TableViewData(section: .attributes, rowData: TableViewRowData(title: attribution.adgroup, detail: "Ad Group")))
            attributesArray.append(TableViewData(section: .attributes, rowData: TableViewRowData(title: attribution.campaign, detail: "Campaign")))
            attributesArray.append(TableViewData(section: .attributes, rowData: TableViewRowData(title: attribution.network, detail: "Network")))
            attributesArray.append(TableViewData(section: .attributes, rowData: TableViewRowData(title: attribution.source, detail: "Source")))
            
            if let keyword = attribution.keyword {
                attributesArray.append(TableViewData(section: .attributes, rowData: TableViewRowData(title: keyword, detail: "Keyword")))
            }
            if let creative = attribution.creative {
                attributesArray.append(TableViewData(section: .attributes, rowData: TableViewRowData(title: creative, detail: "Creative")))
            }
        }
        
        if subscriber.aliases.count > 0 {
            var aliases = ""
            for alias in subscriber.aliases {
                aliases.append(", \(alias)")
            }
            attributesArray.append(TableViewData(section: .attributes, rowData: TableViewRowData(title: aliases, detail: "Aliases")))
        }
        
        
        if let subscriberAttributes = subscriber.subscriberAttributes {
            for att in subscriberAttributes {
                attributesArray.append(TableViewData(section: .attributes, rowData: TableViewRowData(title: att.value.value, detail: att.key)))
            }
        }
        
        return attributesArray
    }
    
    func mapSubscriberIntoHistoryData(subscriber: Subscriber) -> [TableViewData] {
        var historyArray: [TableViewData] = []
        
        let sortedHistory = subscriber.history.sorted(by: {$0.at > $1.at})
        for e in sortedHistory {
            if let atTime = timeService.readableDate(fromDate: e.at, toDate: timeService.now(), unitStyle: .full) {
                historyArray.append(TableViewData(section: .history, rowData: TableViewRowData(title: formatEvent(e), detail: atTime)))
            }
        }
        return historyArray
    }
    
    private func formatEvent(_ event: HistoryEvent) -> String {
        var string = event.event
        
        if let id = event.product {
            string.append(" of \(id)")
        }
        
        if let price = event.priceInPurchasedCurrency, let currency = event.currency, let priceDollars = event.priceInUSD {
            string.append(" for \(currency)\(price) ($\(priceDollars))")
        }
        
        if let platform = event.store {
            string.append(" in \(platform)")
        }
        
        if let alias = event.alias {
            string.append(" - \(alias)")
        }
        
        return string
    }
    
    func rowsPerSection(_ section: Section, for data: [TableViewData]) -> [TableViewData] {
        return data.filter({$0.section == section})
    }
}
