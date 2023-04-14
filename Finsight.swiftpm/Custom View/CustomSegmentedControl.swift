//
//  File.swift
//  
//
//  Created by Rivaldo Fernandes on 11/04/23.
//

import Foundation
import SwiftUI

struct CustomSegmentedControl: View {
    @Binding var preselectedIndex: Int
    var options: [String]
    
    var selectedBackgroundColor = Color.mainColor
    var selectedTextColor = Color.white
    var textColor = Color.mainText
    var backgroundColor = Color.clear
    var borderColor = Color.mainGray.opacity(0.5)
    var paddingSize: CGFloat = 0
    var heightSize: CGFloat = 45
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(options.indices, id:\.self) { index in
                ZStack {
                    Rectangle()
                        .fill(.clear)
                    
                        
                    Capsule()
                        .fill(selectedBackgroundColor)
                        .opacity(preselectedIndex == index ? 1 : 0.01)
                        .onTapGesture {
                            withAnimation(.linear) {
                                    preselectedIndex = index
                                }
                            }
                }
                .overlay(
                    Text(options[index])
                        .foregroundColor(preselectedIndex == index ? selectedTextColor : textColor)
                        .font(.system(.body).bold())
                    
                )
            }
        }
        .padding(paddingSize)
        .background(Color.white)
        .frame(height: heightSize)
        .clipShape(Capsule())
        
        .overlay {
            Capsule()
                .stroke(borderColor, lineWidth: 2)
        }
    }
}
