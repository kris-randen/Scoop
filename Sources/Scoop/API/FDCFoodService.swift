//
//  FDCService.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/12/23.
//

import Foundation

@available(iOS 15.0, *)
public struct FDCFoodService {
    let urlPrefix: String
    let apiKey: String
    private static var cache = [String: NutrientProfile]()
    
    private func urlString(for foodItem: String) -> String {
        "\(urlPrefix)?query=\(foodItem)&api_key=\(apiKey)"
    }
    
    private func url(for foodItem: String) -> URL {
        URL(string: urlString(for: foodItem))!
    }
    
    public init(apiKey: String = Constants.APIkeyFDC, urlPrefix: String = Constants.APIurlstringFDC) {
        self.apiKey = apiKey
        self.urlPrefix = urlPrefix
    }
    
    mutating public func fetchNutritionInfo(for foodItem: String) async -> NutrientProfile {
        if let cached = retrieve(foodItem) { return cached }
        let profile = await fetchFromFDC(foodItem)
        save(profile, for: foodItem)
        return profile
    }
    
    private func fetchFromFDC(_ foodItem: String) async ->  NutrientProfile {
        await fetchProfile(for: foodItem)!
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
    
    private func retrieve(_ foodItem: String) -> NutrientProfile? { FDCFoodService.cache[foodItem] }
    
    private mutating func save(_ profile: NutrientProfile, for foodItem: String) {
        FDCFoodService.cache[foodItem] = profile
    }
    
    func fetchData(for foodItem: String) async -> Data? {
        do {
            return try await fetchDataUnhandled(for: foodItem)
        } catch {
            return nil
        }
    }
    
    func fetchDataUnhandled(for foodItem: String) async throws -> Data {
        try await fetchDataAndResponse(for: foodItem).data
    }
    
    private func fetchDataAndResponse(for foodItem: String) async throws -> (data: Data, response: URLResponse) {
        try await URLSession.shared.data(from: url(for: foodItem))
    }
}
