//
//  File.swift
//  
//
//  Created by Rivaldo Fernandes on 11/04/23.
//

import SwiftUI

struct CustomMenu: View {
    var menus: [String]
    @Binding var selectedMenu: String
    var placeholderMenu: String
    
    
    var body: some View {
        Menu {
            ForEach(menus, id: \.self){ menu in
               
                Button(action: {
                    if menu == selectedMenu {
                        selectedMenu.removeAll()
                    } else {
                        selectedMenu = menu
                    }
                }, label: {
                    HStack {
                        Text(menu)
                        Spacer()
                        
                        if menu == selectedMenu {
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
                    .foregroundColor(.mainText)
                
                Text((selectedMenu.isEmpty || selectedMenu == menus.first!) ? placeholderMenu : selectedMenu)
                    .font(.system(.body))
                    .foregroundColor(.mainText)
            }
            .padding(.all, 10)
            .overlay {
                Capsule()
                    .stroke(Color.mainText)
            }
        }
    }
}

//struct CustomMenu_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomMenu()
//    }
//}
