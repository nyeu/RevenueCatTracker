//
//  TimeService.swift
//  RevenueCatTracker
//
//  Created by Joan Cardona on 25/1/21.
//

import Foundation


struct TimeService {
    
    func now() -> String {
        let dateFormatter: ISO8601DateFormatter = ISO8601DateFormatter()
        return (dateFormatter.string(from: Date()))
    }
    
    func readableDate(fromDate: String, toDate: String, unitStyle: RelativeDateTimeFormatter.UnitsStyle = .short) -> String? {
        let dateFormatter: ISO8601DateFormatter = ISO8601DateFormatter()
        let date = dateFormatter.date(from: fromDate)
        
        let relativeDate = dateFormatter.date(from: toDate)
                
        let relativeFormatter = RelativeDateTimeFormatter()
        relativeFormatter.dateTimeStyle = .named
        relativeFormatter.unitsStyle = unitStyle
        relativeFormatter.formattingContext = .listItem
        
        guard let validFromDate = date, let relativeToDate = relativeDate else {
            return nil
        }
        return relativeFormatter.localizedString(for: validFromDate, relativeTo: relativeToDate)
    }
}
