//
//  SendMoneyDataService.swift
//  SendMoneyApplication
//
//  Created by Taimoor Suleman on 21/01/2025.
//

import Foundation

/// Protocol for fetching available money transfer services.
protocol SendMoneyDataServiceProtocol {
    func fetchServices() throws -> ServicesResponse
}

/// Represents possible data service errors.
enum DataServiceError: Error {
    case fileNotFound
    case decodingError(String)
}

/// Loads services from a local JSON file.
final class SendMoneyDataService: SendMoneyDataServiceProtocol {
    
    private let bundle: Bundle

    init(bundle: Bundle = .main) {
        self.bundle = bundle
    }
    
    func fetchServices() throws -> ServicesResponse {
        guard let url = bundle.url(forResource: "services_data", withExtension: "json") else {
            LoggerService.shared.logError("services_data.json not found.", category: "DataService")
            throw DataServiceError.fileNotFound
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let decodedResponse = try decoder.decode(ServicesResponse.self, from: data)
            LoggerService.shared.logInfo("Successfully loaded services.", category: "DataService")
            return decodedResponse
        } catch {
            LoggerService.shared.logError("Decoding error: \(error.localizedDescription)", category: "DataService")
            throw DataServiceError.decodingError(error.localizedDescription)
        }
    }
}
