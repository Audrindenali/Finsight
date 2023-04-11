//
//  HomeView.swift
//  Finsight
//
//  Created by Rivaldo Fernandes on 10/04/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var transactionViewModel: TransactionViewModel
    @State private var selectedDuration = "Today"
    
    var body: some View {
        GeometryReader { screen in
            VStack {
                ZStack {
                    Color.mainColor
                        .cornerRadius(32, corners: [.bottomLeft, .bottomRight])
                    
                    VStack {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Monday,")
                                    .font(.system(.body))
                                    .foregroundColor(.mainText)
                                Text("3 April 2023")
                                    .font(.system(.body))
                                    .foregroundColor(.mainText)
                            }
                            
                            Spacer()
                            
                            Image("welcome_background")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .clipShape(Circle())
                            Text("Rebecca")
                                .font(.system(.body))
                                .fontWeight(.bold)
                                .foregroundColor(.mainText)
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
                                .foregroundColor(.mainText)
                            Text("Rp4.500.000")
                                .font(.system(size: 42))
                                .foregroundColor(.mainText)
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
                                        Text("Expense")
                                            .font(.system(size: 15))
                                            .foregroundColor(.mainText)
                                        Text("Rp6.000.000")
                                            .font(.system(size: 15))
                                            .foregroundColor(.mainText)
                                            .lineLimit(0)
                                        
                                    }
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
                                            .foregroundColor(.mainText)
                                        Text("Rp6.000.000")
                                            .font(.system(size: 15))
                                            .foregroundColor(.mainText)
                                            .lineLimit(0)
                                        
                                    }
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

                Picker("Select Time Transaction", selection: $selectedDuration) {
                    
                    Text("Today").tag(0)
                    Text("Week").tag(1)
                    Text("Month").tag(2)
                    Text("Year").tag(3)
                }
                .pickerStyle(.segmented)
                .padding(.horizontal, 16)
                .padding(.top, 32)
                
                HStack {
                    Text("Recent Transaction")
                    Spacer()
                    Text("View All")
                        
                }
                .padding(16)
                
                ScrollView {
                    ForEach(transactionViewModel.transactions, id: \._id){ transaction in
                        ItemTransaction(cashFlowType: "Income", category: transaction.tr_category, amount: "\(transaction.tr_amount)")
                    }
                }
            }
            .onAppear{
                transactionViewModel.fetchTransactions()
                print(transactionViewModel.transactions)
            }
        }
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

