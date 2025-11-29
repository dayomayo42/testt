//
//  StudyViewController.swift
//  iProfi_new
//
//  Created by violy on 11.08.2022.
//

import Foundation
import UIKit
import CoreMedia

protocol StudySlidesRefreshDelegate {
    func updateSlideSubscribeFor(id: Int)
}

class StudyViewController: UIViewController, StudySlidesRefreshDelegate {
    var presenter: StudyPresenterProtocol!
    
    let configurator: StudyConfiguratorProtocol = StudyConfigurator()
    var slidesModel: SliderModel? = SliderModel(success: true, data: [])
    
    var slides: SliderModelStudy?
        
    var isSwitched: Bool = false {
        didSet {
            tableView.reloadData()
        }
    }
    
    @IBOutlet weak var sliderHeight: NSLayoutConstraint!
    @IBOutlet weak var sliderPlate: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var placeholderView: UIView!
    
    let modelForStudy: [String] = ["Консультации", "Вебинары", "Повыш. квалификации"]
    var modelForStudyPlan: [Distributors]?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageSlider: ImageSlider!
    
    @IBOutlet weak var switchToStudyButton: UIButton!
    @IBOutlet weak var switchToStudyPlansButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
        view.bringSubviewToFront(placeholderView)
    }
    
    @IBAction func backAction() {
        presenter.backAction()
    }
    
    @IBAction func onStudyAction() {
        if switchToStudyButton.backgroundColor != .white {
            
            switchToStudyPlansButton.backgroundColor = .clear
            switchToStudyPlansButton.setTitleColor(.darkGray, for: .normal)
            
            switchToStudyButton.backgroundColor = .white
            switchToStudyButton.setTitleColor(.black, for: .normal)
            isSwitched = false
            checkPlaceholder()
        }
    }
    
    @IBAction func onStudyPlanAction() {
        if switchToStudyPlansButton.backgroundColor != .white {
            
            switchToStudyButton.backgroundColor = .clear
            switchToStudyButton.setTitleColor(.darkGray, for: .normal)
            
            switchToStudyPlansButton.backgroundColor = .white
            switchToStudyPlansButton.setTitleColor(.black, for: .normal)
            isSwitched = true
            checkPlaceholder()
        }
    }
    
    @IBAction func onMyStudyClick() {
        presenter.getMyStudyList()
    }
    
    func checkPlaceholder() {
        if isSwitched {
            if modelForStudyPlan?.count == 0 {
                self.view.bringSubviewToFront(placeholderView)
                placeholderView.isHidden = false
            }
        } else {
            placeholderView.isHidden = true
        }
    }
    
    func updateSlideSubscribeFor(id: Int) {
        if slides?.data?.count ?? 0 > 0 {
            if let slidesAr = slides?.data {
                for (index, slide) in slidesAr.enumerated() {
                    if slide.id == id {
                        slides?.data?[index].subscribed = true
                    }
                }
            }
        }
    }
}

extension StudyViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !isSwitched {
            return modelForStudy.count
        } else {
            return modelForStudyPlan?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! StudyCategoryCell
        if !isSwitched {
            
            let specName = modelForStudy[indexPath.row]
            cell.configure(categoryName: specName, logoImageUrl: nil)
            
        } else {
            
            guard let specName = modelForStudyPlan?[indexPath.row].name else { return UITableViewCell() }
            
            cell.configure(categoryName: specName, logoImageUrl: modelForStudyPlan?[indexPath.row].image ?? nil)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? StudyCategoryCell else { return }
        if !isSwitched {
            
            if cell.categoryNameLabel.text == "Консультации" {
                presenter.getStudyList(way: "consultations")
            }
            
            if cell.categoryNameLabel.text == "Вебинары" {
                presenter.getStudyList(way: "webinars")
            }
            
            if cell.categoryNameLabel.text == "Повыш. квалификации"{
                presenter.getStudyList(way: "qualification")
            }
            
        } else {
            if let cellId = modelForStudyPlan?[indexPath.row].id {
                presenter.getDistributorsStuff(id: cellId)
            }
        }
    }
}


extension StudyViewController: ImageSliderDelegate {
    
    func sliderFrameRadius() -> CGFloat {
        return 0
    }
    
    func sliderBorderColor() -> CGColor {
        return UIColor(named: "buttondismiss")!.cgColor
    }
    
    func sliderBorderWidth() -> CGFloat {
        return 1
    }
    
    func onClick(pageIndex: Int) {
        if let model = slides?.data?[pageIndex] {
            if model.type != "ads" {
                presenter.openStudySlider(model: model)
            }
        }
    }
    
    func imageSliderCornerRadius() -> CGFloat {
        return 0
    }
    
    func imageSliderOffset() -> CGFloat {
        return 0
    }
    
    func imageSliderAspectWidth() -> CGFloat {
        return 3
    }
    
    func imageSliderAspectHeigh() -> CGFloat {
        return 2
    }
    
    func pagerIndicatorOffset() -> CGFloat {
        return 0
    }
}
