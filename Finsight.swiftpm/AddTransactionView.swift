//
//  AddTransactionView.swift
//  Finsight
//
//  Created by Rivaldo Fernandes on 10/04/23.
//

import SwiftUI


struct AddTransactionView: View {
    @EnvironmentObject var transactionViewModel: TransactionViewModel
    
    
    @State private var nominal: String = ""
    @State private var categorySelection: String = ""
    let categories = ["Investment", "School", "Shopping", "Food"]
    
    @State private var description: String = ""
    @State private var isIncome = true
    @State private var dateSelection: String = ""

    
    var body: some View {
        GeometryReader { screen in
            ZStack {
                Color.mainColor.ignoresSafeArea()
                
                VStack(alignment: .leading) {
                    Text("How Much?")
                        .font(.system(.title2))
                        .foregroundColor(.mainText)
                        .bold()
                    
                    TextField("Enter the nominal", text: $nominal)
                        .font(.system(.largeTitle).weight(.bold))
                        .foregroundColor(.mainText)
                        .padding(.bottom, 16)
                    
                    
                    VStack {
                        Menu {
                            Picker(selection: $categorySelection) {
                                ForEach(categories, id: \.self) {
                                    Text($0)
                                }
                            } label: {
                                Text("Category")
                                .font(.title3)
                                .foregroundColor(categorySelection.isEmpty ? .placeHolderText : .black)
                            }
                                
                        } label: {
                            HStack {
                                Text(categorySelection.isEmpty ? "Select Category" : categorySelection)
                                    .font(.title3)
                                
                                Spacer()
                                
                                Image(systemName: "chevron.forward")
                                    .font(.system(.title3))
                            }
                        }
                        .foregroundColor(categorySelection.isEmpty ? .placeHolderText : .black)
                        .padding(.all, 16)
                        .overlay {
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(.black)
                        }
                        .padding(.top, 32)
                        
                        
                        TextField("Description", text: $description)
                            .font(.system(.title3))
                            .padding(.all, 16)
                            
                            .overlay {
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(.black)
                            }
                            .padding(.top, 32)
                            
                        
                        HStack {
                            Button {
                                withAnimation {
                                    isIncome = true
                                }
                            } label: {
                                Text("Income")
                                    .foregroundColor(.white)
                            }
                            .buttonStyle(.borderedProminent)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 5)
                            .tint(isIncome ? .mainColor : .gray)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                            Button {
                                isIncome = false
                            } label: {
                                Text("Expense")
                                    .foregroundColor(.white)
                            }
                            .buttonStyle(.borderedProminent)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 5)
                            .tint(!isIncome ? .mainColor : .gray)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        .padding(.top, 16)
                        
                        Button(action: {}, label: {
                            HStack {
                                Text("Pick your date")
                                    .font(.system(.title3))
                                    .padding(.all, 16)
                                    .foregroundColor(dateSelection.isEmpty ? .placeHolderText : .black)
                                    
                                Spacer()
                                
                                Image(systemName: "chevron.forward")
                                    .font(.system(.title3))
                                    .padding(.trailing, 16)
                                    
                            }
                        })
                        .overlay {
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(.black)
                        }
                        .foregroundColor(dateSelection.isEmpty ? .placeHolderText : .black)
                        .padding(.top, 16)
                        
                        Spacer()
                        
                        Button {
                            transactionViewModel.saveTransaction(tr_category: self.categorySelection, tr_amount: Double(nominal) ?? 0, tr_date: Date(), tr_description: description)
                        } label: {
                            Text("Continue")
                                .font(.system(.title3))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, maxHeight: 60)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.mainColor)
                        .clipShape(RoundedRectangle(cornerRadius: 18))
                        .padding(.top, 16)
                        
                        Spacer()
                    }
                    .padding(.all, 16)
                    .background(Color.white)
                    .cornerRadius(56, corners: [.topLeft, .topRight])
                }
                .ignoresSafeArea(edges: .bottom)
                .padding(.all, 16)
            } .ignoresSafeArea(edges: .bottom)
           
            
            
            
        }
    }
}

struct AddTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        AddTransactionView()
    }
}
