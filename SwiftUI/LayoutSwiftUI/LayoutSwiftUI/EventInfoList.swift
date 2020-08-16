//
//  EventInfoList.swift
//  LayoutSwiftUI
//
//  Created by RAGHAV SHARMA on 05/05/20.
//  Copyright © 2020 RAGHAV SHARMA. All rights reserved.
//

import SwiftUI

struct EventInfoList : View {
    var body : some View {
        HeightSyncRow(background: Color.secondary.cornerRadius(10)) {
            EventInfoBadge(
                iconName: "video.circle.fill",
                text: "Video call available"
            )
            EventInfoBadge(
                iconName: "doc.text.fill",
                text: "Files are attached"
            )
            EventInfoBadge(
                iconName: "person.crop.circle.badge.plus",
                text: "Invites allowed"
            )
        }
    }
}
