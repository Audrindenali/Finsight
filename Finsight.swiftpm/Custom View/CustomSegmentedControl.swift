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
    let color = Color.mainColor
    var body: some View {
        HStack(spacing: 0) {
            ForEach(options.indices, id:\.self) { index in
                ZStack {
                    Rectangle()
                        .fill(.clear)
                    
                        
                    Capsule()
                        .fill(color)
                        .opacity(preselectedIndex == index ? 1 : 0.01)
                        .onTapGesture {
                            withAnimation(.linear) {
                                    preselectedIndex = index
                                }
                            }
                }
                .overlay(
                    Text(options[index])
                        .foregroundColor(preselectedIndex == index ? .mainText : .black)
                        .font(.system(.body).bold())
                )
            }
        }
        .frame(height: 40)
        .overlay {
            Capsule()
                .stroke(Color.black)
    
        }
    }
}
