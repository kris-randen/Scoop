//
//  FoodItemsListViewModel.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/17/23.
//

import SwiftUI
import Foundation
import Combine

@available(iOS 15.0, *)
@MainActor
class FoodItemsListViewModel: ObservableObject {
    //MARK: - Published properties that FoodItemsListView can bind to
    @Published var profile: NutrientProfile?
    @Published var isLoading: Bool = false
    
    //MARK: - Private properties for data handling
    private var fdcService = FDCFoodServiceNew()
    
    //MARK: - Methods for fetching and updating data
    func fetchNutritionInfo(for foodItem: String) async {
        isLoading = true
        defer { isLoading = false } ///Ensure loading is set to false when done
        profile = await fdcService.fetchNutritionInfo(for: foodItem)
    }
}
