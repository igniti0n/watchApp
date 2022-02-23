//
//  TableInterfaceController.swift
//  connectivity WatchKit Extension
//
//  Created by Ivan Stajcer on 23.02.2022..
//

import Foundation
import WatchKit
import WatchConnectivity

final class TableInterfaceController: WKInterfaceController {
    static let tableRowIdentifier = "TableRow"
    @IBOutlet weak var table: WKInterfaceTable!
    private let tableDataPersistanceService = TableDataPersistanceService()
    private let communicationService = CommunicationService.instance
    private var tableRows = [String]()
    
    override func awake(withContext context: Any?) {
        print("table interface controller awaken, with context: ", context)
        communicationService.addDelegate(self)
        updateTable()
    }
    
    func updateTable() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableRows = self.tableDataPersistanceService.getTableData()
            let numberOfRows = self.tableRows.count
            self.table.setNumberOfRows(numberOfRows, withRowType: TableInterfaceController.tableRowIdentifier)
            for index in 0..<numberOfRows {
                guard let tableRow = self.table.rowController(at: index) as? TableRow else { return }
                tableRow.textLabel.setText(self.tableRows[index])
            }
        }
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        print("Will activate table interface controller.")
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        print("Will DEactivate table interface controller.")
        communicationService.removeDelegate(withId: id)
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        let messageContext = tableRows[rowIndex]
        presentController(withName: "ModalInterface", context: messageContext)
    }
}

extension TableInterfaceController: CommunicationServiceDelegate {
    var id: String {
        get {
            "tableId"
        }
    }
    
    func onDataReceived() {
        updateTable()
    }
}
