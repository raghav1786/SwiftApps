//
//  HeightSyncRow.swift
//  LayoutSwiftUI
//
//  Created by RAGHAV SHARMA on 05/05/20.
//  Copyright © 2020 RAGHAV SHARMA. All rights reserved.
//

import SwiftUI

struct HeightSyncRow<Background: View,Content : View>: View {
    private let content : Content
    private let background: Background
    
    @State private var childHeight : CGFloat?
    init(background : Background,@ViewBuilder content:() -> Content) {
        self.background = background
        self.content = content()
    }
    
    var body: some View {
        HStack {
            content.syncingHeightIfLarger(than: $childHeight)
                .frame(height: childHeight)
                .background(background)
        }
    }
}
