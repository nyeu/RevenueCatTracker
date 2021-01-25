//
//  SettingsViewModel.swift
//  RevenueCatTracker
//
//  Created by Joan Cardona on 25/1/21.
//

import Foundation
import ReSwift

protocol SettingsViewModelDelegate: class {
    func updateView(newState: SettingsViewModel.SettingsState, oldState: SettingsViewModel.SettingsState?)
}

class SettingsViewModel: StoreSubscriber {
    var currentState: SettingsState?
    weak var delegate: SettingsViewModelDelegate?
    typealias StoreSubscriberStateType = SettingsState
    let data: [TableViewData] = [
                                TableViewData(section: .Settings, rowData: TableViewRowData(title: "Help & Support", detail: "I appreciate your feedback, ideas and bug reports.")),
                                 TableViewData(section: .ShowSupport, rowData: TableViewRowData(title: "Tip Jar", detail: "I appreciate your support")),
                                TableViewData(section: .ShowSupport, rowData: TableViewRowData(title: "Rate RC Tracker in the App Store", detail: nil)),
                                TableViewData(section: .ShowSupport, rowData: TableViewRowData(title: "Recommend RC Tracker to a friend", detail: nil))]
    
    func subscribe() {
        mainStore.subscribe(self, transform: {
            $0.select(SettingsState.init)
        })
    }
    
    func unsubscribe() {
        mainStore.unsubscribe(self)
    }
    
    func newState(state: SettingsState) {
        let oldState = self.currentState
        self.currentState = state
        delegate?.updateView(newState: state, oldState: oldState)
    }
    
    func rowsPerSection(_ section: Section, for data: [TableViewData]) -> [TableViewData] {
        return data.filter({$0.section == section})
    }
}

extension SettingsViewModel {
    struct SettingsState: Equatable {
        var sandboxMode: Bool

        init(_ state: MainState) {
            sandboxMode = state.sandboxMode
        }
    }
}

extension SettingsViewModel {
    enum Section: String, CaseIterable {
        case Settings = "Settings"
        case ShowSupport = "Show your support"
    }

    struct TableViewData {
        let section: Section
        let rowData: TableViewRowData
    }

    struct TableViewRowData {
        let title: String
        let detail: String?
    }
}
