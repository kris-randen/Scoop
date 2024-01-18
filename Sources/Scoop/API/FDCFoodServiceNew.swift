//
//  FDCFoodServiceNew.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/23/23.
//

import Foundation

@available(iOS 15.0, *)
public struct FDCFoodServiceNew {
    let urlPrefix: String
    let apiKey: String
    private let cacheActor = CacheActor()
    
    private func urlString(for foodItem: String) -> String {
        "\(urlPrefix)?query=\(foodItem)&api_key=\(apiKey)"
    }
    
    private func url(for foodItem: String) -> URL {
        URL(string: urlString(for: foodItem))!
    }
    
    init(apiKey: String = Constants.APIkeyFDC, urlPrefix: String = Constants.APIurlstringFDC) {
        self.apiKey = apiKey
        self.urlPrefix = urlPrefix
    }
    
    func fetchNutritionInfo(for foodItem: String) async -> NutrientProfile {
        if let cached = await cacheActor.retrieve(foodItem) {
            return cached
        }
        let profile = await fetchFromFDC(foodItem)
        await cacheActor.save(profile, for: foodItem)
        return profile
    }
    
    private func fetchFromFDC(_ foodItem: String) async -> NutrientProfile {
        guard let profile = await fetchProfile(for: foodItem) else {
            ///Handle the case where fetching is unsuccessful
            fatalError("Fetching from FDC failed or profile wasn't found")
        }
        return profile
    }
    
    
    private func fetchProfile(for foodItem: String) async -> NutrientProfile? {
        do {
            let data = try await fetchDataUnhandled(for: foodItem)
            return FoodNutrientParser.extract(from: data)
        } catch {
            print("Error: \(error.localizedDescription)")
            return nil
        }
    }
    
    private func fetchData(for foodItem: String) async -> Data? {
        do {
            return try await fetchDataUnhandled(for: foodItem)
        } catch {
            return nil
        }
    }
    
    private func fetchDataUnhandled(for foodItem: String) async throws -> Data {
        try await fetchDataAndResponse(for: foodItem).data
    }
    
    private func fetchDataAndResponse(for foodItem: String) async throws -> (data: Data, response: URLResponse) {
        try await URLSession.shared.data(from: url(for: foodItem))
    }
}






//    "\(urlPrefix)?query=\(foodItem)&dataType=Foundation&pageSize=5&pageNumber=1&sortBy=dataType.keyword&sortOrder=asc&api_key=\(apiKey)"
