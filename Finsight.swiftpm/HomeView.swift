//
//  HomeView.swift
//  Finsight
//
//  Created by Rivaldo Fernandes on 10/04/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var transactionViewModel: TransactionViewModel
    
    @State private var durationSelection = "Today"
    let durationType = PeriodFilter.allCases.map{ $0.rawValue }
    @State var preselectedIndex = 0
    @State var showAllTransaction = false
    
    var body: some View {
        GeometryReader { screen in
            VStack {
                ZStack {
                    Color.mainColor
                        .cornerRadius(32, corners: [.bottomLeft, .bottomRight])
                        .ignoresSafeArea(edges: .top)
                    
                    VStack {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(getTimeUser(date:Date()))
                                    .font(.system(.body).bold())
                                    .foregroundColor(.white)
                            }
                            
                            Spacer()
                            
                            Image("welcome_background")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .clipShape(Circle())
                            Text("Rebecca")
                                .font(.system(.body))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 24)
                        
                        Divider()
                            .overlay(.white)
                            .padding(.horizontal, 16)
                        
                        VStack {
                            
                            Spacer()
                            
                            Text("Account Balance")
                                .font(.system(.body))
                                .foregroundColor(.white)
                            Text("Rp\(transactionViewModel.totalBalance.formatted(FloatingPointFormatStyle()))")
                                .font(.system(size: 42))
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .padding(.top, 1)
                                .truncationMode(.tail)
                            
                            HStack(alignment: .center) {
                                HStack {
                                    Image(systemName: "person")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 18, height: 18)
                                        .padding(18)
                                        .foregroundColor(.mainColor)
                                        .background(.white)
                                        .clipShape(RoundedRectangle(cornerRadius: 16))
                                    
                                    VStack(alignment: .leading) {
                                        Text("Income")
                                            .font(.system(size: 15))
                                            .foregroundColor(.white)
                                        Text("Rp\(transactionViewModel.totalIncome.formatted(FloatingPointFormatStyle()))")
                                            .font(.system(size: 15))
                                            .foregroundColor(.white)
                                            .lineLimit(0)
                                        
                                    }
                                    
                                    Spacer()
                                }
                                .padding(.all, 16)
                                .background(.white.opacity(0.2))
                                .clipShape(RoundedRectangle(cornerRadius: 32))
                                .frame(width: (screen.size.width / 2) - 16)
                                
                                HStack {
                                    Image(systemName: "person")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 18, height: 18)
                                        .padding(18)
                                        .foregroundColor(.mainColor)
                                        .background(.white)
                                        .clipShape(RoundedRectangle(cornerRadius: 16))
                                    
                                    VStack(alignment: .leading) {
                                        Text("Expense")
                                            .font(.system(size: 15))
                                            .foregroundColor(.white)
                                        Text("Rp\(transactionViewModel.totalExpense.formatted(FloatingPointFormatStyle()))")
                                            .font(.system(size: 15))
                                            .bold()
                                            .foregroundColor(.white)
                                            .lineLimit(0)
                                        
                                    }
                                    
                                    Spacer()
                                }
                                .padding(.all, 16)
                                .background(.white.opacity(0.2))
                                .clipShape(RoundedRectangle(cornerRadius: 32))
                                .frame(width: (screen.size.width / 2) - 16)
                            }
                            Spacer()
                        }
                        Spacer()
                    }
                }
                .frame(height: screen.size.height / 2)

                CustomSegmentedControl(preselectedIndex: $preselectedIndex, options: durationType)
                .padding(.horizontal, 16)
                .padding(.top, 32)
                
                
                
                HStack {
                    Text("Recent Transaction")
                        .font(.system(.body))
                    Spacer()
                    Text("View All")
                        .font(.system(.body))
                        .onTapGesture {
                            showAllTransaction = true
                        }
                        .sheet(isPresented: $showAllTransaction, content: {
                            TransactionView()
                        })
                        
                }
                .padding(16)
                
                if transactionViewModel.transactions.isEmpty {
                    Spacer()
                    
                    Text("There isn't data found")
                        .foregroundColor(.mainText)
                        .font(.system(.title3).bold())
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                } else {
                    ScrollView {
                        ForEach(transactionViewModel.transactions, id: \._id){ transaction in
                            ItemTransactionHome(cashFlowType: transaction.tr_cashflow, category: transaction.tr_category, amount: "\(transaction.tr_amount)")
                                .padding(.horizontal, 16)
                                .padding(.top, 8)
                        }
                    }
                }
                
                
            }
            .onAppear{
                transactionViewModel.fetchTransactionByPeriod(periodFilter: PeriodFilter(rawValue: durationType[preselectedIndex]) ?? .all)
                
                transactionViewModel.fetchTotalStats(monthNum: 0)
                
                let currentDate = Date()
                let calendar = Calendar.current
                let month = calendar.component(.month, from: currentDate)
                print(month)
            }
            .onChange(of: preselectedIndex) { newIndex in
                transactionViewModel.fetchTransactionByPeriod(periodFilter: PeriodFilter(rawValue: durationType[newIndex]) ?? .all)
                transactionViewModel.fetchTotalStats(monthNum: 0)
            }
        }
    }
    
    private func getTimeUser(date: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, \nd MMMM y"
        
        return formatter.string(from: date)
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

