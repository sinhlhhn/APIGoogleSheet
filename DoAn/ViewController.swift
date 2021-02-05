//
//  ViewController.swift
//  DoAn
//
//  Created by Lê Hoàng Sinh on 25/01/2021.
//

import UIKit
import GoogleSignIn
import GoogleAPIClientForREST


var data: [String] = []


class ViewController: UIViewController {
    @IBOutlet weak var btnGetData: UIButton!
    @IBOutlet weak var signInButton: GIDSignInButton!
    private let scopes = [kGTLRAuthScopeSheetsSpreadsheets]
    
    var service = GTLRSheetsService()
    
    var completion: (()->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnGetData.isEnabled = false
        completion = { [weak self] in
            self?.btnGetData.isEnabled = true
        }
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        
        service.apiKey = "AIzaSyCdATtaRZUVSPqjBUKdwG6nk4R4KVa2OVQ"
        
        getCellQuery(a1: "I3:I72")
    }
    
    func getCellQuery(a1: String) {
        print("Started getCellQuery")
        let spreadsheetId = "1IuUtr6BRdBh3pti0VSMXNBnQSDm8wNrP1lDSJKaSK6o"
        let getRange = a1
        let getQuery = GTLRSheetsQuery_SpreadsheetsValuesGet.query(withSpreadsheetId: spreadsheetId, range:getRange)
        service.executeQuery(getQuery, delegate: self, didFinish: #selector(displayResultWithTicket(ticket:finishedWithObject:error:)))
        print("Finished getCellQuery")
    }
    
    @objc func displayResultWithTicket(ticket: GTLRServiceTicket,
                                       finishedWithObject result : GTLRSheets_ValueRange,
                                       error : NSError?) {
        print("Started callback")
        if let error = error {
            print("\(error.localizedDescription)")
            return
        }
        
        let rows = result.values!
        for row in rows {
            for item in row {
                data.append(item as? String ?? "")
            }
        }
        guard let completion = completion else {
            return
        }
        completion()
        print("Finished callback")
    }
    
    
    @IBAction func btnGetDataTapped(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "TableViewController") as! TableViewController
        navigationController?.pushViewController(vc, animated: true)
    }
}

