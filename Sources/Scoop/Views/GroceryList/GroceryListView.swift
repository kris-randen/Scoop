//
//  GroceryListView.swift
//  scoop-cart
//
//  Created by Krishnaswami Rajendren on 1/9/24.
//

import SwiftUI

@available(iOS 16.0, *)
public struct GroceryListView: View {
    @StateObject var gvm = GroceryListViewModel()
    @StateObject var nvm = NutritionalDataViewModel()
    
    @State private var consumedOver: Double = 0
    @State private var showingAddItemView = false
    @State private var navigate = false
    @State private var kind: Nutrient.Kind = .vitamin
    @State private var serving: Serving.Kind = .list
    
    
    public init() {
        UINavigationBar.appearance().titleTextAttributes = [.font: UIFont(name: "Avenir Next Bold", size: 20)!, .foregroundColor: UIColor(Colors.scoopRed)]
    }
    
    public var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(gvm.items) { item in
                        GroceryListCellView(item: item.name, quantity: item.quantityDescription, unit: item.unitDescription)
                            .listRowInsets(EdgeInsets(top: -5, leading: 0, bottom: 0, trailing: 0))
                            .listRowBackground(Color.clear)
                    }
                    .onDelete(perform: deleteItems)
                }
                .sheet(isPresented: $showingAddItemView) {
                    AddGroceryItemView(vm: gvm)
                }
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        HStack {
                            Spacer()
                            Button(action: add) {
                                Image(systemName: "mic.fill.badge.plus")
                                    .font(.title)
                            }
                            .foregroundColor(Colors.scoopRed)
                            Spacer()
                        }
                    }
                }
                Text("Expected Consumption Period (in **Days**)")
                    .textFieldify(withHeightScaling: Dimensions.HeightScaling.textField)
                    .font(Fonts.signInTextField)
                    .borderify(shape: Shapes.textField, color: Colors.scoopYellow)
                    .clippify(shape: Shapes.textField)
                    .shadowify()
                    .foregroundColor(Colors.scoopRed)
                ScoopNumField(value: $consumedOver)
                    .frame(width: Constants.Width / 8)
                    .multilineTextAlignment(.center)
                    .fontWeight(.black)
                Button {
                    Task {
                        await nvm.fetchNutritionalInfo(for: gvm.items, consumedOver: consumedOver)
                        navigate = true
                    }
                } label: {
                    ScoopButtonLabelView()
                }
                .padding(.horizontal)
                if let profile = nvm.aggregatedProfile {
                    NavigationLink("", destination: HorizontalChartView(kind: $kind, serving: $serving, profile: profile), isActive: $navigate)
                }
                
                if nvm.isLoading {
                    
                }
            }
            .navigationInlinify(title: Constants.NavigationTitle.groceryList)
        }
        .ignoresSafeArea(.all, edges: .all)
        .accentColor(Colors.scoopRed)
    }
    
    private func deleteItems(at offsets: IndexSet) {
        offsets.map {gvm.items[$0].id}.forEach(gvm.remove)
    }
    
    private func add() {
        /// Implementation for adding a new item
        showingAddItemView = true
    }
}

@available(iOS 16.0, *)
extension GroceryItem {
    var quantityDescription: String {
        "\(quantity)"
    }
    
    var unitDescription: String {
        "\(unit.name)"
    }
}
