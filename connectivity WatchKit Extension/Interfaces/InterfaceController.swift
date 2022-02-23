//
//  InterfaceController.swift
//  watch WatchKit Extension
//
//  Created by Ivan Stajcer on 17.02.2022..
//

import WatchKit
import Foundation
import WatchConnectivity


class HomeInterfaceController: WKInterfaceController {
    @IBOutlet weak var label: WKInterfaceLabel!
    private let communicationService = CommunicationService.instance
    
    override func awake(withContext context: Any?) {
        communicationService.setupService()
        communicationService.addDelegate(self)
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
    }
}

// MARK: - CommunicationServiceDelegate
extension HomeInterfaceController: CommunicationServiceDelegate {
    var id: String {
        "id"
    }
    
    func onDataReceived() {
    }
}
