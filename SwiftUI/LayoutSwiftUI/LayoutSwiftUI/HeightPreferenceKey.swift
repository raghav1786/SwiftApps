//
//  HeightPreferenceKey.swift
//  LayoutSwiftUI
//
//  Created by RAGHAV SHARMA on 05/05/20.
//  Copyright © 2020 RAGHAV SHARMA. All rights reserved.
//

import SwiftUI

struct HeightPreferenceKey : PreferenceKey {
    static let defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
    
    
}
