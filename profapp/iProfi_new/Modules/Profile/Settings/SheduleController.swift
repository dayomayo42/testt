//
//  SettingsController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 28.10.2020.
//

import UIKit

enum ScheduleBottomType {
    case begin
    case end
}

protocol SheduleDelegate: class {
    var sheduleModel: SheduleModel {get set}
    var type: ScheduleBottomType {get set}
    var pos: Int {get set}
}

class SheduleController: UIViewController, SheduleDelegate {
    var type: ScheduleBottomType = .begin
    var pos: Int = 0
    var presenter: ShedulePresenterProtocol!
    let configurator: SheduleConfiguratorProtocol = SheduleConfigurator()
    var sheduleModel: SheduleModel = SheduleModel(datatimes: [], weekends: []) {
        didSet {
            presenter.configureView(with: sheduleModel)
        }
    }
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var fromCreate = false
    
//    var userModel: UserModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
        presenter.getShadule()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    @IBAction func saveAction(_ sender: Any) {
        presenter.sendData(with: sheduleModel)
    }
    
    @IBAction func backAction(_ sender: Any) {
        presenter.backAction()
    }
    
    @IBAction func onlineAction(_ sender: Any) {
        presenter.openOnline()
    }
    
    @IBAction func weeksAction(_ sender: Any) {
        presenter.openWeeks()
    }
    
    @objc func beginAction(_ recognizer: SheduleRecognizer) {
        let vc = getControllerProfile(controller: .singleAlert) as! SheduleSingleBottom
        pos = recognizer.headline ?? 0
        type = .begin
        vc.delegate = self
        self.present(vc, animated: true)
    }
    
    @objc func endAction(_ recognizer: SheduleRecognizer) {
        let vc = getControllerProfile(controller: .singleAlert) as! SheduleSingleBottom
        pos = recognizer.headline ?? 0
        type = .end
        vc.delegate = self
        self.present(vc, animated: true)
    }
    
    @objc func breakAction(_ recognizer: SheduleRecognizer) {
        let vc = getControllerProfile(controller: .doubleAlert) as! SheduleDoubleBottom
        pos = recognizer.headline ?? 0
        vc.delegate = self
        self.present(vc, animated: true)
         
    }
    
    @objc func accessTimeAction(_ recognizer: SheduleRecognizer) {
        let vc = self.getControllerProfile(controller: .recordtime) as! RecordTimeController
        pos = recognizer.headline ?? 0
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
