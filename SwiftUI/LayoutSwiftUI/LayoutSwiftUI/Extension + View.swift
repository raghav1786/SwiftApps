//
//  Extension + View.swift
//  LayoutSwiftUI
//
//  Created by RAGHAV SHARMA on 05/05/20.
//  Copyright © 2020 RAGHAV SHARMA. All rights reserved.
//

import SwiftUI

extension View {
    func addVerifiedBadge(_ isVerified : Bool) -> some View {
        ZStack(alignment: .topTrailing) {
            self
            if isVerified {
                Image(systemName: "checkmark.circle.fill")
                    .offset(x:3,y:-3)
            }
        }
    }
    
    func syncingHeightIfLarger(than height : Binding<CGFloat?>) -> some View {
        background(GeometryReader { proxy in
            
            Color.clear.preference(key: HeightPreferenceKey.self, value: proxy.size.height)
        })
            .onPreferenceChange(HeightPreferenceKey.self) {
                height.wrappedValue = max(height.wrappedValue ?? 0,$0)
        }
    }
}
