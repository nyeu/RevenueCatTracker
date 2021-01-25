//
//  SettingsViewModelTests.swift
//  RevenueCatTrackerTests
//
//  Created by Joan Cardona on 25/1/21.
//

import XCTest
@testable import RevenueCatTracker

class SettingsViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRowsForSettingsSection() {
        let viewModel = SettingsViewModel()
        let data: [SettingsViewModel.TableViewData] = [
            SettingsViewModel.TableViewData(section: .Settings, rowData: SettingsViewModel.TableViewRowData(title: "Feedback", detail: "I appreciate your feedback, ideas and bug reports.")),
            SettingsViewModel.TableViewData(section: .ShowSupport, rowData: SettingsViewModel.TableViewRowData(title: "Tip Jar", detail: "I appreciate your support"))]
        
        let rowsForSettingsSection = viewModel.rowsPerSection(.Settings, for: data)
        
        XCTAssertEqual(rowsForSettingsSection.count, 1)
    }
    
    func testRowsForAboutMeSection() {
        let viewModel = SettingsViewModel()
        let data: [SettingsViewModel.TableViewData] = [
            SettingsViewModel.TableViewData(section: .Settings, rowData: SettingsViewModel.TableViewRowData(title: "Feedback", detail: "I appreciate your feedback, ideas and bug reports.")),
            SettingsViewModel.TableViewData(section: .ShowSupport, rowData: SettingsViewModel.TableViewRowData(title: "Tip Jar", detail: "I appreciate your support")),
            SettingsViewModel.TableViewData(section: .ShowSupport, rowData: SettingsViewModel.TableViewRowData(title: "Know me", detail: nil))]
        
        let rowsForSettingsSection = viewModel.rowsPerSection(.ShowSupport, for: data)
        
        XCTAssertEqual(rowsForSettingsSection.count, 2)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
