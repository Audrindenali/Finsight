//
//  File.swift
//  
//
//  Created by Rivaldo Fernandes on 10/04/23.
//

import Foundation
 
struct MainTabEntity {
    var id: String = UUID().uuidString
    var image: String
    var title: String
}

var mainTabs = [
    MainTabEntity(image: "house.fill", title: "Home"),
    MainTabEntity(image: "arrow.left.arrow.right", title: "Transaction"),
    MainTabEntity(image: "chart.pie.fill", title: "Statistics"),
    MainTabEntity(image: "person.fill", title: "Profile"),
    
]
