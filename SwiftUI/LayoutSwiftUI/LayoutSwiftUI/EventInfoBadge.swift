//
//  EventInfoBadge.swift
//  LayoutSwiftUI
//
//  Created by RAGHAV SHARMA on 05/05/20.
//  Copyright © 2020 RAGHAV SHARMA. All rights reserved.
//

import SwiftUI

struct EventInfoBadge : View {
    var iconName : String
    var text : String
    var body : some View {
        VStack {
            Image(systemName: iconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25)
            Text(text)
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 5)
        .background(Color.secondary)
        .cornerRadius(10)
    }
}

struct EventInfoBadge_Previews: PreviewProvider {
    static var previews: some View {
        EventInfoBadge (iconName: "video.circle.fill",
                        text: "Video call available")
    }
}
