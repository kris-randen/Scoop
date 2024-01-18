//
//  ScoopButton.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/20/23.
//

import SwiftUI

@available(iOS 15.0, *)
public struct ScoopButton: View {
    var food: String
    @Binding var profile: NutrientProfile
    @Binding var loading: Bool
    @Binding var navigate: Bool
    
    public init(food: String, profile: Binding<NutrientProfile>, loading: Binding<Bool>, navigate: Binding<Bool>) {
            self.food = food
            self._profile = profile
            self._loading = loading
            self._navigate = navigate
        }
    
    public var body: some View {
        Button {
            Task {
                loading = true
                var service = FDCFoodService()
                profile = await service.fetchNutritionInfo(for: food)
                loading = false
                navigate = true
            }
        } label: {
            ScoopButtonLabelView()
        }
    }
}
