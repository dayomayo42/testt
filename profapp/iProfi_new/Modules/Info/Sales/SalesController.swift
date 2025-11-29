//
//  SalesController.swift
//  iProfi_new
//
//  Created by violy on 15.08.2022.
//

import Foundation
import UIKit

class SalesController: UIViewController {
    var presenter: SalesPresenterProtocol!
    let configurator: SalesConfiguratorProtocol = SalesConfigurator()
    
    @IBOutlet weak var salesButton: UIButton!
    @IBOutlet weak var favoritesButton: UIButton!

    @IBOutlet weak var plugView: UIView!
    @IBOutlet weak var sliderPlate: UIView!
    @IBOutlet weak var imageSlider: ImageSlider!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var sliderHeight: NSLayoutConstraint!
    @IBOutlet weak var stackView: UIStackView!
    
    var isShouldUpdate = false
    
    var modelFavouritesSlides: SliderModelSales?
    var modelFavorite: [String] = []
    
    var model: [String] = []
    var slidesModel: SliderModel? = SliderModel(success: true, data: [])
    
    var modelSales: [String] = ["Категории", "Дистрибьюторы"]
    
    var slides: SliderModelSales?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
        view.bringSubviewToFront(plugView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if favoritesButton.backgroundColor == .white {
            presenter.getFavorites()
        }
    }
    
    @IBAction func backAction() {
        presenter.backAction()
    }
    
    @IBAction func onSalesAction() {
        if salesButton.backgroundColor != .white {
            
            favoritesButton.backgroundColor = .clear
            favoritesButton.setTitleColor(.darkGray, for: .normal)
            
            salesButton.backgroundColor = .white
            salesButton.setTitleColor(.black, for: .normal)
            
            if slides?.data.count ?? 0 > 0 {
                sliderPlate.isHidden = false
            }
            
            plugView.isHidden = true
            model = modelSales
            tableView.reloadData()
        }
    }
    
    @IBAction func onFavoritesActio() {
        
        if favoritesButton.backgroundColor != .white {
            
            salesButton.backgroundColor = .clear
            salesButton.setTitleColor(.darkGray, for: .normal)
            
            favoritesButton.backgroundColor = .white
            favoritesButton.setTitleColor(.black, for: .normal)
            
            if slides?.data.count ?? 0 > 0 {
                sliderPlate.isHidden = true
            }
            
            model = []
            tableView.reloadData()
            presenter.getFavorites()
        }
    }
    
}


extension SalesController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SalesCell
        cell.configure(name: model[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? SalesCell else { return }
        if cell.categoryNameLabel.text == "Категории" {
            presenter.getSalesCategories()
        } else if cell.categoryNameLabel.text == "Дистрибьюторы" {
            presenter.getDistributors()
        } else {
            if let model = modelFavouritesSlides?.data[indexPath.row] {
                presenter.openSale(model: model)
            }
        }
    }
}




extension SalesController: ImageSliderDelegate {
    
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
        if let modelId = slides?.data[pageIndex]?.id {
            if let modelType = slides?.data[pageIndex]?.type {
                presenter.getSale(id: modelId)
            } else {
                presenter.getSalesByDistributors(id: modelId) { model in
                    self.presenter.openDistibutor(model: model, categoryName: self.slides?.data[pageIndex]?.name ?? "")
                }
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
