//
//  MethodImage.swift
//  kohi
//
//  Created by Thibaut on 22/08/2019.
//  Copyright © 2019 Thibaut. All rights reserved.
//

import SwiftUI

struct MethodImage: View {
    let image: String
    
    @Environment(\.colorScheme) var dark :ColorScheme
    
    var body: some View {
        Image(image)
            .resizable()
            .frame(width: 70, height: 70)
            .clipShape(Circle())
            .shadow(radius: 6)
            .padding(.trailing, 10)
            .contrast(dark == ColorScheme.dark ? -1 : 1)
            
    }
}

struct MethodImage_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ForEach(Method.allCases, id: \.self) { method in
                Group {
                    MethodImage(image: method.rawValue)
                    MethodImage(image: method.rawValue).environment(\.colorScheme, .dark)
                }
            }
        }.previewLayout(.sizeThatFits)
    }
}
