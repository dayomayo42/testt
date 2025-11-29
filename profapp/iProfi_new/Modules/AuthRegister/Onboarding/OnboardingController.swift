//
//  OnboardingController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 28.04.2021.
//

import UIKit

struct OnBoardModel {
    let image: UIImage?
    let title: String?
    let desc: String?
}
class OnboardingController: UIViewController {

    @IBOutlet weak var collectionHeight: NSLayoutConstraint!
    let onboardList: [OnBoardModel] = [OnBoardModel(image: #imageLiteral(resourceName: "onboard1"), title: "Склад", desc: "Ведите учет своих расходных материалов, а также поставщиков, приходов и расходов."),
                                       OnBoardModel(image: #imageLiteral(resourceName: "onboard2"), title: "Список услуг", desc: "Создавайте и редактируйте списки предоставляемых Вами услуг."),
                                       OnBoardModel(image: #imageLiteral(resourceName: "onboard3"), title: "База клиентов", desc: "Вы можете добавить клиента вручную или воспользоваться Вашей адресной книгой. Каждый клиент имеет индивидуальную историю посещений и статусы."),
                                       OnBoardModel(image: #imageLiteral(resourceName: "onboard4"), title: "Журнал записей", desc: "Создавайте, просматривайте и редактируйте записи своих клиентов."),
                                       OnBoardModel(image: #imageLiteral(resourceName: "onboard5"), title: "Онлайн-запись", desc: "Вы можете создать личную сайт-визитку прямо в приложении, чтобы клиенты могли записываться к Вам на прием с любого устройства не скачивая приложение!")]
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageIndicator: UIPageControl!
    var pos = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        pageIndicator.numberOfPages = onboardList.count
        collectionHeight.constant = UIScreen.main.bounds.height - 160
    }

    @IBAction func nextButtonAction(_ sender: Any) {
        if pos < (onboardList.count - 1) {
            pos = pos + 1
            pageIndicator.currentPage = pos
            collectionView.scrollToItem(at: IndexPath(row: pos, section: 0), at: .centeredHorizontally, animated: true)
        } else {
            Settings.onboard = true
            if Authorization.isAuthorized {
                let vc = getControllerAppNavigation(controller: .tabbar)
                self.present(NavigationController(rootViewController: vc), animated: true, completion: nil)
            } else {
                let vc = getController(controller: .launch)
                self.present(NavigationController(rootViewController: vc), animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        if pos == 0 {
            self.navigationController?.popViewController(animated: true)
        } else {
            pos = pos - 1
            pageIndicator.currentPage = pos
            collectionView.scrollToItem(at: IndexPath(row: pos, section: 0), at: .centeredHorizontally, animated: true)
        }
        
    }
    
    @IBAction func skipAction(_ sender: Any) {
        Settings.onboard = true
        if Authorization.isAuthorized {
            let vc = getControllerAppNavigation(controller: .tabbar)
            self.present(NavigationController(rootViewController: vc), animated: true, completion: nil)
        } else {
            let vc = getController(controller: .launch)
            self.present(NavigationController(rootViewController: vc), animated: true, completion: nil)
        }
    }
}

extension OnboardingController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return onboardList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! OnboardingCell
        cell.configure(model: onboardList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height - 160
        return CGSize(width: width, height: height)
    }
}
