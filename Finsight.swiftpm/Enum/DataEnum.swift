//
//  File.swift
//  
//
//  Created by Rivaldo Fernandes on 14/04/23.
//

import Foundation

enum CashFlow: String, CaseIterable {
    case expense = "Expense"
    case income = "Income"
}

enum PeriodFilter: String, CaseIterable {
    case all = "All"
    case today = "Today"
    case week = "Week"
    case month = "Month"
    case year = "Year"
}

enum Categories: String, CaseIterable {
    case all = "All"
    case shopping = "Shopping"
    case food = "Food"
    case entertainment = "Entertainment"
    case subscription = "Subscription"
    case salary = "Salary"
    case bonus = "Bonus"
}

enum Months: String, CaseIterable {
    case all = "All"
    case january = "January"
    case february = "February"
    case march = "March"
    case april = "April"
    case may = "May"
    case june = "June"
    case july = "July"
    case august = "August"
    case september = "September"
    case october = "October"
    case november = "November"
    case december = "December"
}
