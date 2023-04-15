//
//  WelcomeView.swift
//  Finsight
//
//  Created by Rivaldo Fernandes on 10/04/23.
//

import SwiftUI
struct WelcomeView: View {
    @State private var isShowMainView = false
    
    var body: some View {
        GeometryReader { screen in
            VStack(alignment: .leading) {
                Image("welcome_background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxHeight: screen.size.height / 2)
                
                Spacer()
                
                Text("Simple solution for your budget.")
                    .font(.system(.largeTitle).weight(.bold))
                    .foregroundColor(.mainColor)
                    .padding(.horizontal, 28)
                    .padding(.bottom, 16)
                
                Text("Counter and distribute the income correctly!")
                    .font(.title3)
                    .padding(.horizontal, 28)
                    .padding(.bottom, 32)
                
                HStack {
                    Spacer()
                    Button {
                        isShowMainView = true
                    } label: {
                        Text("Continue")
                            .foregroundColor(.white)
                            .padding(.horizontal, (50))
                            .padding(.vertical, 5)
                    }
                    
                    .buttonStyle(.borderedProminent)
                    .tint(.mainColor)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                    Spacer()
                }
                .fullScreenCover(isPresented: $isShowMainView) {
                    NavigationView {
                        MainView()
                    }
                }
            }
        }.ignoresSafeArea(edges: .top)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
