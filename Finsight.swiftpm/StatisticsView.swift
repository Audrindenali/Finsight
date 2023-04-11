//
//  FinancialReportView.swift
//  Finsight
//
//  Created by Rivaldo Fernandes on 10/04/23.
//

import SwiftUI

struct StatisticsView: View {
    @State private var durationSelection = "Month"
    let duration = ["Today", "Week", "Month", "Year"]
    
    @State private var cashFlowSelection = "Income"
    let cashFlowType = ["Income", "Expense"]
    
    var body: some View {
        GeometryReader { screen in
            ZStack {
                Color.mainColor
                    .ignoresSafeArea()
                VStack {
                    Picker("Select Category", selection: $durationSelection) {
                        ForEach(duration, id: \.self) {
                            Text($0)
                        }
                    }.pickerStyle(.menu)
                    
                    VStack {
                        Color.blue
                    }
                    .frame(height: screen.size.height / 3)
                    
                    Picker("Select Time Transaction", selection: $cashFlowSelection) {
                        
                        ForEach(cashFlowType, id: \.self) {
                            Text($0)
                        }
                    }.pickerStyle(.segmented)
                    
                    ScrollView {
                        ForEach(1...5, id: \.self){ _ in
                            ItemTransactionHome(cashFlowType: "Income", category: "100000", amount: "Rp100000")
                        }
                    }
                    .padding(.all, 24)
                    .padding(.top, 16)
                    .background(Color.white)
                    .cornerRadius(56, corners: [.topLeft, .topRight])
                    .padding(.all, 16)
                    
                }
                
            }
            
        }
    }
}

struct FinancialReportView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView()
    }
}
