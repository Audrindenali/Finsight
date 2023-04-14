import SwiftUI

@main
struct MyApp: App {
    @StateObject var transactionViewModel = TransactionViewModel()
    
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                WelcomeView()
            }.environmentObject(transactionViewModel)
                .tint(.white)
        }
    }
}
