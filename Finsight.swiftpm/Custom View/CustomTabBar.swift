//
//  CustomTabBar.swift
//  Finsight
//
//  Created by Rivaldo Fernandes on 10/04/23.
//

import Foundation
import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: String
    @Binding var showAddTransaction: Bool
    @Namespace var animation
    
    var body: some View {
        HStack(spacing: 0){
            //tab
            TabBarButton(animation: animation, title: "Home", image: "house.fill", tag: "home", selectedTab: $selectedTab)
            
            TabBarButton(animation: animation, title: "Transaction", image: "arrow.left.arrow.right", tag: "transaction", selectedTab: $selectedTab)
        
            NavigationLink(destination: AddTransactionView(),isActive: $showAddTransaction) {
                Image(systemName: "plus")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.mainColor)
                    .clipShape(Circle())
                    .shadow(color: Color.black.opacity(0.05), radius: 5, x: 5, y:5)
                    .shadow(color: Color.black.opacity(0.05), radius: 5, x: -5, y:-5)
            }
            .offset(y: -30)
            
            
            TabBarButton(animation: animation, title: "Statistics", image: "chart.pie.fill", tag: "statistics", selectedTab: $selectedTab)
            
            TabBarButton(animation: animation, title: "Profile", image: "person.fill", tag: "profile", selectedTab: $selectedTab)
            
        }
        .padding(.top)
        //decreasing padding added
        .padding(.vertical, -10)
        .padding(.bottom, getSafeArea().bottom == 0 ? 15 : getSafeArea().bottom)
        .background(Color.white)
    }
}

struct TabBarButton: View {
    var animation: Namespace.ID
    var title: String
    var image: String
    var tag: String
    @Binding var selectedTab: String
    
    var body: some View {
        Button(action: {
            withAnimation(.linear){
                selectedTab = tag
            }
            
        }, label: {
            VStack(spacing: 2){
                Image(systemName: image)
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 28, height: 28)
                    .foregroundColor(selectedTab == tag ? Color.mainColor : Color.gray.opacity(0.5))
                
                Text(title)
                    .font(.footnote)
                    .foregroundColor(selectedTab == tag ? Color.mainColor : Color.gray.opacity(0.5))
                    .padding(.bottom, 5)
                
                if selectedTab == tag {
                    Circle()
                        .fill(Color.mainColor)
                        //Sliding Effect
                        .matchedGeometryEffect(id: "TAB", in: animation)
                        .frame(width: 8, height: 8)
                }
                
            }
            .frame(maxWidth: .infinity)
        })
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

//extension to get safe area
extension View {
    func getSafeArea() -> UIEdgeInsets{
        return UIApplication.shared.windows.first?.safeAreaInsets ?? UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
