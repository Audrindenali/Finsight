//
//  ProfileView.swift
//  Finsight
//
//  Created by Rivaldo Fernandes on 10/04/23.
//

import SwiftUI

struct ProfileView: View {
    
    var settingList = [
        SettingEntity(image: "person", name: "Account"),
        SettingEntity(image: "person", name: "Settings"),
        SettingEntity(image: "person", name: "Export Data"),
        SettingEntity(image: "person", name: "Logout"),
    ]
    
    var body: some View {
        ZStack {
            Color.mainColor
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Image("welcome_background")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading) {
                        Text("Username")
                            .foregroundColor(.white)
                            
                        Text("Rebecca")
                            .foregroundColor(.white)
                            .font(.system(.title))
                    }
                    
                    Spacer()
                    
                    
                    Image(systemName: "person")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .padding(12)
                        .foregroundColor(.white)
                        .font(.system(.title).bold())
//                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .overlay {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.white)
                        }
                }
                .padding(.horizontal)
                
                VStack {
                    ForEach(0..<settingList.count, id: \.self) { stIndex in
                        HStack {
                            
                            Image(systemName: settingList[stIndex].image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                                .padding(18)
                                .foregroundColor(.mainColor)
                                .font(.system(.title).bold())
                                .background(Color.mainColor.opacity(0.2))
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                            
                            Text(settingList[stIndex].name)
                                .foregroundColor(.black)
                                .font(.system(.body).bold())
                            
                            Spacer()
                            
                        }
                        .padding(.vertical)
                    }
                }
                .padding(.all)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 24))
                .padding(.all)
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
