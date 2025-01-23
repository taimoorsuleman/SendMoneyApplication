//
//  AppState.swift
//  SendMoneyApplication
//
//  Created by Taimoor Suleman on 22/01/2025.
//

import Combine
import Foundation

final class AppState: ObservableObject {
    @Published private(set) var requests: [TransactionModel] = []

    static let shared = AppState()

    private init() {}

    /// Adds a new transaction request and saves the updated list to UserDefaults.
    /// - Parameter request: The transaction request to be added.
    func addRequest(_ request: TransactionModel) {
        requests.append(request)
        saveToUserDefaults()
    }

    /// Loads transaction requests from UserDefaults into memory.
    func loadRequests() {
        if let savedData = UserDefaults.standard.data(forKey: "requests"),
           let decodedData = try? JSONDecoder().decode([TransactionModel].self, from: savedData) {
            requests = decodedData
        }
    }
    
    /// Saves the current requests list to UserDefaults.
    private func saveToUserDefaults() {
        if let encodedData = try? JSONEncoder().encode(requests) {
            UserDefaults.standard.set(encodedData, forKey: "requests")
        }
    }
}
