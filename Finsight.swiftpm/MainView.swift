//
//  MainScreen.swift
//  Finsight
//
//  Created by Rivaldo Fernandes on 10/04/23.
//

import SwiftUI
//
//MainTabEntity(image: "house.fill", title: "Home"),
//MainTabEntity(image: "arrow.left.arrow.right", title: "Transaction"),
//MainTabEntity(image: "chart.pie.fill", title: "Statistics"),
//MainTabEntity(image: "person.fill", title: "Profile"),

struct MainView: View {
    @State var selectedTab: String = "home"
    @State var showAddTransaction = false
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    
    var body: some View {
        VStack {
            TabView(selection: $selectedTab) {
                HomeView()
                    .tag("home")
                
                TransactionView()
                    .tag("transaction")
                
                StatisticsView()
                    .tag("statistics")
                
                ProfileView()
                    .tag("profile")
            }
            
            CustomTabBar(selectedTab: $selectedTab, showAddTransaction: $showAddTransaction)
            
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

