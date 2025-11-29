//
//  noInternetPlug.swift
//  iProfi_new
//
//  Created by violy on 02.09.2022.
//

import Foundation
import UIKit
import Moya
import RxSwift
import SVProgressHUD

class NoInternetPlugView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var reconnectButton: UIButton!
    
    let onTryToReconnect: () -> Void
    
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()
    
    public init(onTryToReconnect: @escaping () -> ()) {
        self.onTryToReconnect = onTryToReconnect
        super.init(frame: CGRect.zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit() {
        fromNib()
    }
    
    @IBAction func tryToReconnect() {
        SVProgressHUD.show()
        service.checkInternet().subscribe { (response) in
            SVProgressHUD.dismiss()
            if response.success ?? false {
                self.onTryToReconnect()
                self.removeFromSuperview()
            } else {
                SVProgressHUD.showDismissableError(withStatus: response.message ?? "response error")
            }
        } onError: { (error) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                SVProgressHUD.dismiss()
            }
        }.disposed(by: disposeBag)
    }
}
