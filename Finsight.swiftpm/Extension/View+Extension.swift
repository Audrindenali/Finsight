//
//  File.swift
//  
//
//  Created by Rivaldo Fernandes on 10/04/23.
//

import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
