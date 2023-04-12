//
//  FinancialReportView.swift
//  Finsight
//
//  Created by Rivaldo Fernandes on 10/04/23.
//

import SwiftUI

struct StatisticsView: View {
    @EnvironmentObject var transactionViewModel: TransactionViewModel
    @State private var durationSelection = "Month"
    let duration = ["Today", "Week", "Month", "Year"]
    
    let cashFlowType = CashFlow.allCases
    @State private var cashFlowSelection = CashFlow.expense.rawValue
    
    
    @State private var preselectedIndex: Int = 0
    
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
                    
                    CustomSegmentedControl(preselectedIndex: $preselectedIndex, options: (cashFlowType.map{ $0.rawValue }))
                    .padding(.horizontal, 16)
                    .padding(.top, 32)
                    
                    ScrollView(showsIndicators: false) {
                        ForEach(transactionViewModel.totalAllCategory, id: \.category){ total in
                            VStack {
                                HStack {
                                    Image(systemName: "circle.fill")
                                        .font(.system(.footnote))
                                        .foregroundColor(.mainColor)
                                    Text(total.category.rawValue)
                                        .font(.system(.body).bold())
                                    Spacer()
                                    Text("Rp\(total.total.formatted(FloatingPointFormatStyle()))")
                                        .font(.system(.body).bold())
                                        .foregroundColor(.mainColor)
                                }
                                
                                ProgressView(value: total.total, total: cashFlowSelection == CashFlow.expense.rawValue ? transactionViewModel.totalExpense : transactionViewModel.totalIncome)
                                    .scaleEffect(x: 1, y: 3, anchor: .center)
                                    .tint(.mainColor)
//                                    .cornerRadius(16)
                            }
                            .padding()
                        }
                    }
                    .padding(.all, 24)
                    .padding(.top, 16)
                    .background(Color.white)
                    .cornerRadius(56, corners: [.topLeft, .topRight])
                    .padding(.top, 16)
                    .padding(.horizontal).ignoresSafeArea(edges: .bottom)
                }
            }
            .onAppear {
                transactionViewModel.fetchTotalTransactionByCashFlow(cashFlow: cashFlowType[preselectedIndex])
                transactionViewModel.fetchTotalStats()
                
                if(cashFlowSelection == CashFlow.income.rawValue){
                    print("income")
                } else {
                    print("expense")
                }
            }
            .onChange(of: preselectedIndex) { newIdx in
                transactionViewModel.fetchTotalTransactionByCashFlow(cashFlow: cashFlowType[newIdx])
                
                transactionViewModel.fetchTotalStats()
            }
        }
    }
}

struct FinancialReportView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView()
    }
}
