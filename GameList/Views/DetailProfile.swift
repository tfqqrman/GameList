//
//  DetailProfile.swift
//  GameList
//
//  Created by Taufiq Qurohman on 02/01/24.
//

import SwiftUI

struct DetailProfile: View {
    var body: some View {
        VStack{
            Text("Your profile")
                .padding(.top, 20)
                .font(.title2.bold())
            CircleImage(image: Image("profile-image"),width: 300, height: 300)
                .padding(.top, 10)
                .frame(maxHeight: .infinity, alignment: .top)
            VStack{
                Text("Taufiq Qurohman")
                    .frame(maxHeight: .infinity, alignment: .top)
                    .font(.title.bold())
                Text("Bekasi, Jawa Barat")
                    .frame(maxHeight: .infinity, alignment: .top)
            }
            .frame(height: 49)
            .frame(maxHeight: .infinity, alignment: .top)
            
            
        }
    }
}

struct DetailProfile_Previews: PreviewProvider {
    static var previews: some View {
        DetailProfile()
    }
}
