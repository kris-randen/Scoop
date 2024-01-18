//
//  FoodItemsListViewNew.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 1/5/24.
//

import SwiftUI

@available(iOS 15.0, *)
public struct FoodItemsListView: View {
    @StateObject var vm = FoodItemsListViewModel()
    @State var food: String = "Beef Liver Raw"
    @State var kind: Nutrient.Kind = .vitamin
    @State var quantity: String = ""
    @State var serving: Serving.Kind = .kcal2000
    
    @State var loading: Bool = false
    @State var navigate = false
    
    public init() {
        UINavigationBar.appearance().titleTextAttributes = [.font: UIFont(name: "Avenir Next Bold", size: 18)!, .foregroundColor: UIColor(Colors.scoopRed)]
    }
    
    public var body: some View {
        NavigationView {
            VStack {
                Spacer()
                ScoopTextFieldAndToggle(
                    text: $food,
                    kind: $kind,
                    quantity: $quantity,
                    serving: $serving
                )
                ScoopButtonNew(vm: vm, food: food, navigate: $navigate)
                    .padding(.horizontal)
                if vm.isLoading {
                    GettingTheInsideScoopView(food: food)
                }
                if let profile = vm.profile {
                    NavigationLink("", destination: HorizontalChartView(kind: $kind, serving: $serving, profile: profile), isActive: $navigate)
                }
            }
            .vStackify()
            .navigationInlinify(title: Constants.NavigationTitle.foodItem)
        }
        .ignoresSafeArea(.all, edges: .all)
        .accentColor(Colors.scoopRed)
    }
}
