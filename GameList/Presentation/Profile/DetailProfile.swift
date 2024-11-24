//
//  DetailProfile.swift
//  GameList
//
//  Created by Taufiq Qurohman on 02/01/24.
//

import SwiftUI

struct DetailProfile: View {
    let presenter = ProfilePresenter(profileUseCase: Injection.init().provideUseCase()).getProfileData()
    
    var body: some View {
        VStack{
            Text(presenter.tittle )
                .padding(.top, 20)
                .font(.title2.bold())
            CircleImage(image: presenter.userImage,width: 300, height: 300)
                .padding(.top, 10)
                .frame(maxHeight: .infinity, alignment: .top)
            VStack{
                Text(presenter.profileName)
                    .frame(maxHeight: .infinity, alignment: .top)
                    .font(.title.bold())
                Text(presenter.userAddress)
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
