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
    @State private var categorySelection: Int = 0
    let categories = Categories.allCases.map { $0.rawValue }
    
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
                        .foregroundColor(.white)
                        .bold()
                    
                    TextField("Enter the amount", text: $amountSelection)
                        .font(.system(.largeTitle).weight(.bold))
                        .foregroundColor(.white)
                        .padding(.bottom, 16)
                        .keyboardType(.numberPad)
                    
                    
                    VStack {
                        Menu {
                            Picker(selection: $categorySelection) {
                                ForEach(1..<categories.count, id: \.self) {
                                    Text(categories[$0])
                                }
                            } label: {
                                Text("Category")
                                    .font(.title3)
                                    .foregroundColor(categorySelection == 0 ? .secondaryText : .black)
                            }
                            
                        } label: {
                            HStack {
                                Text(categorySelection == 0 ? "Select Category" : categories[categorySelection])
                                    .font(.title3)
                                
                                Spacer()
                                
                                Image(systemName: "chevron.forward")
                                    .font(.system(.title3))
                            }
                        }
                        .foregroundColor(categorySelection == 0 ? .secondaryText : .black)
                        .padding(.all, 16)
                        .overlay {
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(.black)
                        }
                        .padding(.top, 32)
                        
                        
                        TextField("Description", text: $descriptionSelection)
                            .font(.system(.title3))
                            .padding(.all, 16)
                            .foregroundColor(.black)
                        
                            .overlay {
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(.black)
                            }
                            .padding(.top, 32)
                        
                        
                        HStack(spacing: 16) {
                            Button {
                                
                            } label: {
                                Text(CashFlow.income.rawValue)
                                    .foregroundColor(.white)
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(isIncome ? .mainColor : .gray)
                            .clipShape(RoundedRectangle(cornerRadius: 18))
                            
                            
                            
                            Button {
                                
                            } label: {
                                Text(CashFlow.expense.rawValue)
                                    .foregroundColor(.white)
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(!isIncome ? .mainColor : .gray)
                            .clipShape(RoundedRectangle(cornerRadius: 18))
                        }
                        .padding(.top, 16)
                        
                        
                        DatePicker("Select your date", selection: $dateSelection, displayedComponents: .date)
                            .preferredColorScheme(.light)
                            .tint(.black)
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
                                transactionViewModel.saveTransaction(tr_category: categories[categorySelection], tr_amount: Double(amountSelection) ?? 0, tr_date: dateSelection, tr_description: descriptionSelection, tr_cashflow: isIncome ? CashFlow.income.rawValue : CashFlow.expense.rawValue
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
        }.onChange(of: categorySelection) { newIdx in
            let category = Categories(rawValue: categories[newIdx])
            switch(category){
            case .salary, .bonus :
                isIncome = true
            case .all, .entertainment, .food, .shopping, .subscription:
                isIncome = false
            case .none:
                break
            }
        }
    }
    
    
    private func validateField() -> Bool{
        if (
            !amountSelection.isEmpty &&
            categorySelection != 0 &&
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
