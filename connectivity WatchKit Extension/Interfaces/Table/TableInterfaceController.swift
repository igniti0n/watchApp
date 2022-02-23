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
    private var labels = [String]()

    override func awake(withContext context: Any?) {
        print("table interface controller awaken, with context: ", context)
        if let data = context as? Array<String> {
            labels = data
        }
        let numberOfRows = labels.count
        table.setNumberOfRows(numberOfRows, withRowType: TableInterfaceController.tableRowIdentifier)
        for index in 0..<numberOfRows {
            guard let tableRow = table.rowController(at: index) as? TableRow else { return }
            tableRow.textLabel.setText(labels[index])
        }
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        print("Will activate table interface controller.")
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        print("Will DEactivate table interface controller.")
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        let messageContext = labels[rowIndex]
        presentController(withName: "ModalInterface", context: messageContext)
    }
}
