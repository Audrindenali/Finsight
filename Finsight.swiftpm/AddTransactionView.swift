//
//  AddTransactionView.swift
//  Finsight
//
//  Created by Rivaldo Fernandes on 10/04/23.
//

import SwiftUI


struct AddTransactionView: View {
    @EnvironmentObject var transactionViewModel: TransactionViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    
    @State private var amountSelection: String = ""
    @State private var categorySelection: String = ""
    let categories = ["Investment", "School", "Shopping", "Food"]
    
    @State private var descriptionSelection: String = ""
    @State private var dateSelection = Date.now
    @State private var isIncome = true

    
    var body: some View {
        GeometryReader { screen in
            ZStack {
                Color.mainColor.ignoresSafeArea()
                
                VStack(alignment: .leading) {
                    Text("How Much?")
                        .font(.system(.title2))
                        .foregroundColor(.mainText)
                        .bold()
                    
                    TextField("Enter the nominal", text: $amountSelection)
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
                                .foregroundColor(categorySelection.isEmpty ? .secondaryText : .black)
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
                        .foregroundColor(categorySelection.isEmpty ? .secondaryText : .black)
                        .padding(.all, 16)
                        .overlay {
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(.black)
                        }
                        .padding(.top, 32)
                        
                        
                        TextField("Description", text: $descriptionSelection)
                            .font(.system(.title3))
                            .padding(.all, 16)
                            
                            .overlay {
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(.black)
                            }
                            .padding(.top, 32)
                            
                        
                        HStack(spacing: 16) {
                            Button {
                                withAnimation {
                                    isIncome = true
                                }
                            } label: {
                                Text("Income")
                                    .foregroundColor(.white)
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(isIncome ? .mainColor : .gray)
                            .clipShape(RoundedRectangle(cornerRadius: 18))
                            
                            
                            Button {
                                isIncome = false
                            } label: {
                                Text("Expense")
                                    .foregroundColor(.white)
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(!isIncome ? .mainColor : .gray)
                            .clipShape(RoundedRectangle(cornerRadius: 18))
                        }
                        .padding(.top, 16)
                        
                        
                        DatePicker("Select your date", selection: $dateSelection, displayedComponents: .date)
                            .font(.system(.title3))
                            .padding(.all, 16)
                            
                            .overlay {
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(.black)
                            }
                            .padding(.top, 16)
                            .lineLimit(0)
                        
                        Spacer()
                        
                        Button {
                            if validateField() {
                                transactionViewModel.saveTransaction(tr_category: categorySelection, tr_amount: Double(amountSelection) ?? 0, tr_date: dateSelection, tr_description: descriptionSelection, tr_cashflow: isIncome ? "income" : "expense"
                                )
                                
                                presentationMode.wrappedValue.dismiss()
                            } else {
                                print("Isi dahulu semua field")
                            }
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
    
    
    private func validateField() -> Bool{
        if (
            !amountSelection.isEmpty &&
            !categorySelection.isEmpty &&
            !descriptionSelection.isEmpty
        ) {
            return true
        } else {
            return false
        }
        
    }
}

struct AddTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        AddTransactionView()
    }
}
