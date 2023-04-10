//
//  FinancialReportView.swift
//  Finsight
//
//  Created by Rivaldo Fernandes on 10/04/23.
//

import SwiftUI

struct FinancialReportView: View {
    @State private var durationSelection = "Month"
    let duration = ["Today", "Week", "Month", "Year"]
    
    @State private var cashFlowSelection = "Income"
    let cashFlowType = ["Income", "Expense"]
    
    var body: some View {
        GeometryReader { screen in
            VStack {
                Picker("Select Category", selection: $durationSelection) {
                    ForEach(duration, id: \.self) {
                        Text($0)
                    }
                }.pickerStyle(.menu)
                
                Picker("Select Time Transaction", selection: $cashFlowSelection) {
                    
                    ForEach(cashFlowType, id: \.self) {
                        Text($0)
                    }
                }.pickerStyle(.segmented)
            }
            
        }
    }
}

struct FinancialReportView_Previews: PreviewProvider {
    static var previews: some View {
        FinancialReportView()
    }
}
