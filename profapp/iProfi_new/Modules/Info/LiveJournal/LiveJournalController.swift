//
//  LiveJournalController.swift
//  iProfi_new
//
//  Created by violy on 16.08.2022.
//

import Foundation
import UIKit

class LiveJournalController: UIViewController {
    var presenter: LiveJournalPresenterProtocol!
    @IBOutlet weak var slider: ImageSlider!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var sliderPlate: UIView!
    
    @IBOutlet weak var sliderHeight: NSLayoutConstraint!
    var slidesModel: SliderModel? = SliderModel(success: true, data: [])
    
    let configurator: LiveJournalConfiguratorProtocol = LiveJournalConfigurator()
    
    var slides: SliderModelLJ? 
    
    let model = ["Новости", "Статьи", "Выставки"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
    }
 
    @IBAction func backAction() {
        presenter.backAction()
    }
}

extension LiveJournalController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LiveJournalCell
        cell.configure(name: model[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? LiveJournalCell else { return }
        if cell.categoryNameLabel.text == "Новости" {
            presenter.getList(listType: .news)
        }
        if cell.categoryNameLabel.text == "Статьи" {
            presenter.getList(listType: .article)
        }
        if cell.categoryNameLabel.text == "Выставки" {
            presenter.getList(listType: .exhibition)
        }
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20.0
    }
}




extension LiveJournalController: ImageSliderDelegate {
    
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
            presenter.openLiveJJournalDetail(model: model)
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

