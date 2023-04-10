//
//  HomeView.swift
//  Finsight
//
//  Created by Rivaldo Fernandes on 10/04/23.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedTime = "Today"
    
    
    var body: some View {
        GeometryReader { screen in
            VStack {
                HStack {
                    Text("Monday, 3 April 2023")
                    Image("welcome_background")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .clipShape(Circle())
                    Text("Rebecca")
                }
                Divider()
                
                Text("Account Balance")
                Text("Rp4.500.000")
                
                Picker("Select Time Transaction", selection: $selectedTime) {
                    
                    Text("Today").tag(0)
                    Text("Week").tag(1)
                    Text("Month").tag(2)
                    Text("Year").tag(3)
                }
                .pickerStyle(.segmented)
                .padding(.horizontal, 16)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

