////
////  StoreKitManager.swift
////  Match Matrix
////
////  Created by Rival Fauzi on 20/06/23.
////
//
import Foundation
import StoreKit

public enum StoreError: Error {
    case failedVerification
}

class StoreKitManager: ObservableObject {
    @Published var storeProducts: [Product] = []
    
    var updateListenerTask: Task<Void, Error>? = nil
    
    private let productDict: [String : String]
    
    init() {
        //check the path for the plist
        if let plistPath = Bundle.main.path(forResource: "PropertyList", ofType: "plist"),
           //get the list of products
           let plist = FileManager.default.contents (atPath: plistPath) {
            productDict = (try? PropertyListSerialization.propertyList(from: plist, format: nil) as? [String : String]) ?? [:]
        } else {
            productDict = [:]
        }
        
        updateListenerTask = listenForTransactions()
        
        Task {
            await requestProducts()
        }
    }
    
    deinit {
        updateListenerTask?.cancel()
    }
    
    func listenForTransactions() -> Task<Void, Error> {
        return Task.detached {
            //iterate through any transactions that don't come from a direct call to 'purchase()'
            for await result in Transaction.updates {
                do {
                    let transaction = try self.checkVerified(result)
                    
                    //Always finish a transaction
                    await transaction.finish()
                } catch {
                    //storekit has a transaction that fails verification, don't delvier content to the user
                    print("Transaction failed verification")
                }
            }
        }
    }
    
    @MainActor
    func requestProducts () async {
        do {
            //using the Product static method products to retrieve the list of products
            storeProducts = try await Product.products (for: productDict.values)
            // iterate the "type" if there are multiple product types
        } catch {
            print ("Failed - error retrieving products \(error)")
        }
    }
    
    func purchase(_ item: Product) async {
        do {
            let result = try await item.purchase()
            switch result {
            case .success(let verificationResult):
                let transaction = try checkVerified(verificationResult)
                
                let productID = transaction.productID
                
                if (productID == productDict["addHint1"]) {
                    DataController().addHint(hintAdd: 3)
                } else if (productID == productDict["addHint2"]) {
                    DataController().addHint(hintAdd: 20)
                } else if (productID == productDict["addHint3"]) {
                    DataController().addHint(hintAdd: 50)
                }
                
            case .pending:
                print("Transaction is pending for some action from the users related to the account")
            case .userCancelled:
                print("Use cancelled the transaction")
            default:
                print("Unknown error")
            }
        } catch {
            print(error)
        }
    }
    
    func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
        case .unverified:
            throw StoreError.failedVerification
        case .verified(let signedType):
            return signedType
        }
    }
}
