import SwiftUI

@main
struct MyApp: App {
    @StateObject var transactionViewModel = TransactionViewModel()
    
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                MainView()
            }.environmentObject(transactionViewModel)
        }
    }
}
