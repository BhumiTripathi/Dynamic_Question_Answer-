//
//  Dateformatter.swift
//  CuraTech
//
//  Created by Bhumika tripathi on 8/11/18.
//  Copyright © 2018 Bhumika tripathi. All rights reserved.
//

import UIKit

public func getDateTimeFromString(strDate : String)->Date {
    
    let dtf = DateFormatter()
    dtf.dateFormat = "MM-dd-yyyy HH:mm:ss"
    let strDate = dtf.date(from: strDate)
    return strDate ?? Date()
    
}
public func getDateFromString(strDate : String)->Date
{
    let dtf = DateFormatter()
    dtf.dateFormat = "MM-dd-yyyy"
    let strDate = dtf.date(from: strDate)
    return strDate!;
}
public func getStringDate(dateValue : Date) -> String
{
    let dtf = DateFormatter()
    dtf.timeZone = TimeZone.current
    dtf.dateFormat = "MM-dd-yyyy"
    let strDate = dtf.string(from: dateValue )
    return strDate
}

public func makeDate(year: Int, month: Int, day: Int) -> String {
    var calendar = Calendar(identifier: .gregorian)
    calendar.timeZone = TimeZone(secondsFromGMT: 0)!
    let components = DateComponents(year: year, month: month, day: day)
    let Date = calendar.date(from: components)!
    let dtf = DateFormatter()
    dtf.dateFormat = "MM-dd-yyyy"
    let strDate = dtf.string(from: Date )
    return strDate;
    
}


public func makeDateForBirthYear(aDay : Int , aMonth : Int, aYear : Int) -> Date{
    
    let calendar = Calendar.current
    var dateComponent = DateComponents()
    dateComponent.year = aYear
    dateComponent.month = aMonth
    dateComponent.day = aDay
    
    return calendar.date(from: dateComponent)!
}


