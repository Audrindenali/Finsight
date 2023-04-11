import SwiftUI

@main
struct MyApp: App {
    @StateObject var transactionViewModel = TransactionViewModel()
    
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                FinancialReportView()
            }.environmentObject(transactionViewModel)
        }
    }
}
