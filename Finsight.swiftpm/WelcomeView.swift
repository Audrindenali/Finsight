//
//  WelcomeView.swift
//  Finsight
//
//  Created by Rivaldo Fernandes on 10/04/23.
//

import SwiftUI
struct WelcomeView: View {
    var body: some View {
        GeometryReader { screen in
            VStack(alignment: .leading) {
                Image("welcome_background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxHeight: screen.size.height/2)
                    
                Text("Simple solution for your budget")
                    .font(.system(.title).weight(.bold))
                    .padding(.all, 24)
                
                Text("Counter and distribute the income correctly!")
                    .font(.body)
                    .padding(.all, 24)
                
                Button {
                    print("Clicked")
                } label: {
                    Text("Continue")
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(.red)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }.ignoresSafeArea(edges: .top)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
