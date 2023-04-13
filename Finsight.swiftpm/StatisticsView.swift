//
//  FinancialReportView.swift
//  Finsight
//
//  Created by Rivaldo Fernandes on 10/04/23.
//

import SwiftUI
import Charts

struct StatisticsView: View {
    @EnvironmentObject var transactionViewModel: TransactionViewModel
    @State private var durationSelection = "Month"
    let duration = ["Today", "Week", "Month", "Year"]
    
    let cashFlowType = CashFlow.allCases
    @State private var cashFlowSelection = CashFlow.expense.rawValue
    
//    @State private var chartDataEntries: [PieChartDataEntry] = []
    @State private var chartDataset: PieChartDataSet? = nil
    
    
    @State private var preselectedIndex: Int = 0
    @State private var selectedCashFlowSlice: String?
    @State private var selectedSlicePercent: Double?
    
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
                    
                    ZStack {
                        VStack {
                            CustomPieChartView(dataset: $chartDataset, selectedSliceValue: $selectedCashFlowSlice, selectedSlicePercent: $selectedSlicePercent)
                        }
                        
                        VStack {
                            
                            if selectedSlicePercent != nil {
                                Text("\(String(format: "%.2f", selectedSlicePercent!)) %")
                            }
                            
                            if selectedCashFlowSlice == nil {
                                Text("Total")
                                    .font(.system(.body))
                                    .foregroundColor(.black)
                                    .padding(.bottom, 2)
                                Text("Rp\((transactionViewModel.totalIncome + transactionViewModel.totalExpense).formatted(FloatingPointFormatStyle()))")
                                    .font(.system(.title3).bold())
                                    .foregroundColor(.mainColor)
                            } else {
                                Text(selectedCashFlowSlice == CashFlow.income.rawValue ? CashFlow.income.rawValue : CashFlow.expense.rawValue)
                                    .font(.system(.body))
                                    .foregroundColor(.black)
                                    .padding(.bottom, 2)
                                Text("Rp\(selectedCashFlowSlice == CashFlow.income.rawValue ? transactionViewModel.totalIncome.formatted(FloatingPointFormatStyle()) : transactionViewModel.totalExpense.formatted(FloatingPointFormatStyle()))")
                                    .font(.system(.title3).bold())
                                    .foregroundColor(.mainColor)
                            }
                            
                            
                                
                        }
                        .frame(maxWidth: (screen.size.height / 2.5) - 20)
                        
                        
                    }
                    .background(Color.white)
                    .cornerRadius(56, corners: [.bottomLeft, .bottomRight])
                    .frame(height: screen.size.height / 2.5)
                    .padding(.horizontal, 16)
                    
                    CustomSegmentedControl(preselectedIndex: $preselectedIndex, options: (cashFlowType.map{ $0.rawValue }))
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                    
                    ScrollView(showsIndicators: false) {
                        ForEach(transactionViewModel.totalAllCategory, id: \.category){ total in
                            VStack {
                                HStack {
                                    Image(systemName: "circle.fill")
                                        .font(.system(.footnote))
                                        .foregroundColor(.mainColor)
                                    Text(total.category.rawValue)
                                        .font(.system(.body).bold())
                                        .foregroundColor(.black)
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
                
                if transactionViewModel.totalIncome + transactionViewModel.totalExpense == 0 {
                    let entries = [
                        PieChartDataEntry(value: 0, label: "Income"),
                        PieChartDataEntry(value: 0, label: "Expense")
                    ]
                    
                    let dataset = PieChartDataSet(entries: entries)
                    chartDataset = dataset
                    
                } else {
                    let total = transactionViewModel.totalExpense + transactionViewModel.totalIncome
                    let entries = [
                        PieChartDataEntry(value: ((transactionViewModel.totalIncome/total) * 100), label: "Income"),
                        PieChartDataEntry(value: ((transactionViewModel.totalExpense/total) * 100), label: "Expense")
                    ]
                    
                    let dataset = PieChartDataSet(entries: entries)
                    chartDataset = dataset
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
