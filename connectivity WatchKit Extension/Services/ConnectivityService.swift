//
//  ConnectivityService.swift
//  connectivity WatchKit Extension
//
//  Created by Ivan Stajcer on 23.02.2022..
//

import Foundation
import WatchConnectivity

protocol CommunicationServiceDelegate {
    var id: String { get }
    func onDataReceived()
}

final class CommunicationService: NSObject, WCSessionDelegate {
    static let instance = CommunicationService()
    private let tableDataPersistanceService = TableDataPersistanceService()
    private let wcSession = WCSession.default
    // TODO: Add removal from delegates, so no calles are made when not needed.
    private var delegates = [CommunicationServiceDelegate]()
    
    private override init() {}
    
    func setupService() {
        if(WCSession.isSupported()) {
            wcSession.delegate = self
            wcSession.activate()
        }
    }
    
    func addDelegate(_ delegate: CommunicationServiceDelegate) {
        delegates.append(delegate)
        print("Added delegate, now list: ", delegates)
    }
    
    func removeDelegate(withId id: String) {
        delegates.removeAll { delegate in
            delegate.id == id
        }
        delegates.forEach { delegate in
            print(delegate.id)
        }
        print("Removed delegates, now list: ", delegates)
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("@session did complete with: acctivation state: ", activationState.rawValue)
        print("Activated state...")
        print("Is reachable: ", wcSession.isReachable)
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        print("Received message: ", message)
        print("Received context:", wcSession.receivedApplicationContext)
        handleTableData(message: message, replyHandler: nil)
        for delegate in delegates {
            delegate.onDataReceived()
        }
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        handleTableData(message: message, replyHandler: replyHandler)
        for delegate in delegates {
            delegate.onDataReceived()
        }
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        print("Received application context: ", applicationContext)
        handleTableData(message: applicationContext, replyHandler: nil)
        for delegate in delegates {
            delegate.onDataReceived()
        }
    }
    
    func handleTableData(message: [String : Any], replyHandler: (([String : Any]) -> Void)?) {
        guard let tableData = message["tableData"] as? Array<String> else {
            replyHandler?(["reply" : "Table data is not an arrayof strings."])
            return
        }
        tableDataPersistanceService.saveTableData(tableData)
    }
}

