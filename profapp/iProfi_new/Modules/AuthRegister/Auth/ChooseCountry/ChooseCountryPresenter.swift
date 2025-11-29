//
//  ChooseCountryPresenter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 31.08.2020.
//

import Foundation
import UIKit

protocol ChooseCountryPresenterProtocol: class {
    var router: ChooseCountryRouterProtocol! {get set}
    func dismissAction()
    func configureView(with viewController: ChooseCountryController)
}

class ChooseCountryPresenter: ChooseCountryPresenterProtocol {
    var router: ChooseCountryRouterProtocol!
    var interactor: ChooseCountryInteractorProtocol!
   
    func configureView(with viewController: ChooseCountryController) {
        let json = readJSONFromFile(fileName: "countries")
        let decoder = JSONDecoder()
        viewController.countryList = try! decoder.decode([CountriesModel].self, from: json!)
        
        if viewController.navigationController?.navigationBar.isHidden ?? false {
            viewController.navView.isHidden = false
        } else {
            viewController.navView.isHidden = true
        }
    }
    
    func dismissAction() {
        router.dismiss()
    }
    
    func readJSONFromFile(fileName: String) -> Data? {
        var json: Data?
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                // Getting data from JSON file using the file URL
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                json = data//try? JSONSerialization.jsonObject(with: data) as! Data
            } catch {
                // Handle error here
            }
        }
        return json
    }
}
