//
//  Preview.swift
//  Hypnosis
//
//  Created by Adam Hlubina on 20.05.2023.
//

import SwiftUI


// MARK: - Different devices with dark/light mode

public extension View {
    
    /// Display current view in dark mode
    func asDarkModePreview() -> some View {
        self
            .environment(\.colorScheme, .dark)
            .preferredColorScheme(.dark)
            .previewDisplayName("Dark mode")
    }
    
    /// Preview as small phone - SE 1st gen
    func asSmallPhone(_ displayName: String? = "SE") -> some View {
        self
            .previewDevice("iPhone SE (1st generation)")
            .previewDisplayName(displayName)
    }
    
    /// Preview as large phone - 14 pro max
    func asLargePhone(_ displayName: String? = "14 Pro Max") -> some View {
        self
            .previewDevice("iPhone 14 Pro Max")
            .previewDisplayName(displayName)
    }
    
    func asIPadPreview(_ displayName: String? = "Air (5th)") -> some View {
        self
            .previewDevice("iPad Air (5th generation)")
            .previewDisplayName(displayName)
    }
    
    /// Display all phone variants
    func asPhonePreviews() -> some View {
        Group {
            self
                .asSmallPhone("SE, Light")
            
            self
                .asSmallPhone("SE, Dark")
                .asDarkModePreview()
            
            self
                .asLargePhone("14 Pro Max, Light")
            
            self
                .asLargePhone("14 Pro Max, Dark")
                .asDarkModePreview()
        }
    }
    
    /// Display all variants
    func asAllPreviews() -> some View {
        Group {
            self
                .asSmallPhone("SE, Light")
            
            self
                .asSmallPhone("SE, Dark")
                .asDarkModePreview()
            
            self
                .asLargePhone("14 Pro Max, Light")
            
            self
                .asLargePhone("14 Pro Max, Dark")
                .asDarkModePreview()
            
            self
                .asLargePhone("Extra Large DT")
                .dynamicTypeSize(.xxxLarge)
            
            self
                .asLargePhone("Extra Small DT")
                .dynamicTypeSize(.xSmall)
            
            self
                .asIPadPreview("Air (5th), Light")

            self
                .asIPadPreview("Air (5th), Dark")
                .asDarkModePreview()
        }
    }
}
