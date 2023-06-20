//
//  Cloudkit.swift
//  Match Matrix
//
//  Created by Rival Fauzi on 19/06/23.
//

import SwiftUI
import CloudKit

class CloudKit: ObservableObject {
    
    @Published var isSignedInToiCloud: Bool = false
    @Published var error: String = ""
    
    init() {
        getCloudStatus()
    }
    
    private func getCloudStatus() {
        CKContainer.default().accountStatus { [weak self] returnedStatus, returnedError in
            DispatchQueue.main.async {
                switch returnedStatus {
                case .available:
                    self?.isSignedInToiCloud = true
                case .noAccount:
                    self?.error = CloudKitError.iCloudAccountNotFound.localizedDescription
                case .couldNotDetermine:
                    self?.error = CloudKitError.iCloudAccountNotDetermine.localizedDescription
                case .restricted:
                    self?.error = CloudKitError.iCloudAccountRestricted.localizedDescription
                default:
                    self?.error = CloudKitError.iCloudAccountUnknown.localizedDescription
                }
            }
        }
    }
    
    enum CloudKitError: LocalizedError {
        case iCloudAccountNotFound
        case iCloudAccountNotDetermine
        case iCloudAccountRestricted
        case iCloudAccountUnknown
    }
}

struct Cloudkit: View {
    @StateObject private var vm = CloudKit()
    
    var body: some View {
        VStack{
            Text("IS SIGNED IN: \(vm.isSignedInToiCloud.description.uppercased())")
            Text(vm.error)
        }
    }
}

struct Cloudkit_Previews: PreviewProvider {
    static var previews: some View {
        Cloudkit()
    }
}
