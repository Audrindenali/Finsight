//
//  File.swift
//  
//
//  Created by Rivaldo Fernandes on 11/04/23.
//

import SwiftUI

struct CustomMenu: View {
    var menus: [String]
    @Binding var selectedMenu: Int
    var placeholderMenu: String
    
    
    var body: some View {
        Menu {
            ForEach(0..<menus.count, id: \.self){ menuIdx in
                
                Button(action: {
                    if menuIdx == selectedMenu {
                        selectedMenu = 0
                    } else {
                        selectedMenu = menuIdx
                    }
                }, label: {
                    HStack {
                        Text(menus[menuIdx])
                        Spacer()
                        
                        if menuIdx == selectedMenu {
                            Image(systemName: "checkmark")
                                .foregroundColor(.green)
                        }
                    }
                })
            }
        } label: {
            HStack {
                Image(systemName: "chevron.down")
                    .font(.system(.title3))
                    .foregroundColor(.white)
                
                Text(selectedMenu == 0 ? placeholderMenu : menus[selectedMenu])
                    .font(.system(.body))
                    .foregroundColor(.white)
            }
            .padding(.all, 10)
            .overlay {
                Capsule()
                    .stroke(Color.white)
            }
        }
    }
}

//struct CustomMenu_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomMenu()
//    }
//}
