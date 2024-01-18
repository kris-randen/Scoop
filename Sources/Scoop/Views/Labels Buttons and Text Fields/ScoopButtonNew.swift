//
//  ScoopButtonNew.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/23/23.
//

import SwiftUI

@available(iOS 15.0, *)
public struct ScoopButtonNew: View {
    @ObservedObject var vm: FoodItemsListViewModel
    var food: String
    @Binding var navigate: Bool
    
    public var body: some View {
        Button {
            Task {
                vm.profile = nil
                await vm.fetchNutritionInfo(for: food)
                navigate = true
            }
        } label: {
            ScoopButtonLabelView()
        }
    }
}
