//
//  CircleImage.swift
//  GameList
//
//  Created by Taufiq Qurohman on 02/01/24.
//

import SwiftUI

struct CircleImage: View {
    var image:Image
    var width:CGFloat = 50
    var height:CGFloat = 50
    var body: some View {
        image
            .resizable()
            .frame(width: width, height: height)
            .clipShape(Circle())
            .overlay{
                Circle().stroke(.blue, lineWidth: 2)
            }
            .shadow(color: .blue, radius: 5)
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage(image: Image("profile-image"))
    }
}
