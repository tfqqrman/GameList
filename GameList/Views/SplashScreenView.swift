//
//  SpalshScreenView.swift
//  GameList
//
//  Created by Taufiq Qurohman on 02/10/23.
//

import SwiftUI

struct SplashScreenView: View {
    @State var isActive: Bool = false
    var body: some View {
        if self.isActive{
            HomeScreenView()
        }else{
            VStack{
                VStack{
                    //this should be image but rn I will fill it with the text instead
                    Text("this is logo")
                        .padding(4.0)
                    Text("GameList")
                        .font(Font.custom("Marker Felt", size: 38))
                }
                .onAppear{
                    withAnimation(.easeIn(duration: 1.0)){}
                }
            }
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now()+3.0){
                    withAnimation(.easeIn(duration: 1.0)){
                        self.isActive = true
                    }
                }
            }
        }
        
    }
}

struct SpalshScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
