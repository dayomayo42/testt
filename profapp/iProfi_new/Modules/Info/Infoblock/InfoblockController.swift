//
//  InfoblockController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 01.10.2020.
//

import UIKit

class InfoblockController: UIViewController {
    
    var presenter: InfoblockPresenterProtocol!
    let configurator: InfoblockConfiguratorProtocol = InfoblockConfigurator()
    var categories: [Spec] = []
    var allCategories: [Spec] = []
    
    @IBOutlet weak var blankPlugView: UIView!
    @IBOutlet weak var noSpecPlugView: UIView!

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var sliderHeight: NSLayoutConstraint!
    
    var model = ["Обучение", "Акции", "Живой журнал"]
    var userModel: UserModel?
    var slidesModel: SliderModel? = SliderModel(success: true, data: [])
    var selectedRow: Int?
    
    static var currentSpecId: Int = 0
  
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var slides: SliderModelSales? = nil {
        didSet {
            slidesModel?.data?.removeAll()
            if let slides = slides {
                slides.data.forEach{ slide in
                    slidesModel?.data?.append(SlideModel(image: slide?.image, name: slide?.name))
                }
                if let slidesModel = slidesModel {
                    presenter.initSlider(with: slidesModel)
                }
            }
        }
    }
    
    @IBOutlet var imageSlider: ImageSlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        selectedRow = nil
        presenter.configureView()
    }
    
    @IBAction func openSpeczList() {
        presenter.getSpeczList()
    }
    
    @IBAction func goToProfileDetail() {
        if let userModel = userModel {
            presenter.openProfileDetail(userModel: userModel)
        }
    }
    
    func updateSpecs() {
        presenter.getSpec()
    }
    
}

extension InfoblockController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if categories.count == 0 {
            return 1
        } else {
            return categories.count + 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row < (categories.count) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! InfoblockCell
            cell.configure(with: categories[indexPath.row].name ?? "")
            if collectionView.indexPathsForSelectedItems?.last == indexPath {
                cell.isActive = true
            } else {
                cell.isActive = false
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "add", for: indexPath) as! InfoblockAddCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row < (categories.count) {
            if indexPath.row != selectedRow {
                let cell = collectionView.cellForItem(at: indexPath) as! InfoblockCell
                cell.isActive = true
                selectedRow = indexPath.row
                if let categoryId = categories[indexPath.row].id {
                    InfoblockController.currentSpecId = categoryId
                }
                if let id = categories[indexPath.row].id {
                    presenter.getSlides(id: id)
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if indexPath.row < (categories.count) {
            if collectionView.indexPathsForVisibleItems.contains(indexPath) {
                let cell = collectionView.cellForItem(at: indexPath) as! InfoblockCell
                cell.isActive = false
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row < (categories.count) {
            if let nameCount = categories[indexPath.row].name?.count {
                let width = 24 + 4 * nameCount
                return CGSize(width: width, height: 38)
            } else {
                return CGSize(width: 38, height: 38)
            }
        } else {
            return CGSize(width: 38, height: 38)
        }
    }
}

extension InfoblockController: UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! InfoblockMainCell
        cell.configure(title: model[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? InfoblockMainCell else { return }
        if cell.titleLabel.text == "Обучение" {
            presenter.getStudySlides()
        } else if cell.titleLabel.text == "Акции" {
            presenter.getSalesSlides()
        } else if cell.titleLabel.text == "Живой журнал" {
            presenter.getLiveJournalSlides()
        }
    }
}

extension InfoblockController: ImageSliderDelegate {
    
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
        
        if let model = slides?.data[pageIndex] {
        
            if model.type?.contains("shares") == true {
                if let id = model.id {
                    presenter.getSale(id: id)
                }
            }
            if model.type?.contains("courses") == true {
                if let id = model.id {
                    presenter.getStudy(id: id)
                }
            }
            
            if model.type?.contains("ads") == true {
                if let url = model.url {
                    presenter.openWebParthner(urlString: url)
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


