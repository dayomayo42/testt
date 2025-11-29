//
//  TestPhotoController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 28.06.2021.
//

import Combine
import Moya
import RxSwift
import SVProgressHUD
import UIKit

class TestPhotoController: UIViewController {
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()

    @IBOutlet var resultImage: UIImageView!
    @IBOutlet var twoImage: UIImageView!
    @IBOutlet var oneImage: UIImageView!
    var resImg: UIImage?
    var fileame = ""
    override func viewDidLoad() {
        super.viewDidLoad()
//
//        oneImage.image = UIImage(named: "eduard+schneider.jpg")?.cropsToSquare()
//        twoImage.image = UIImage(named: "photo-1438761681033-6461ffad8d80.jpeg")?.cropsToSquare()

        let new = UIImage.collage(images: [UIImage(named: "eduard+schneider.jpg")?.cropsToSquare() ?? UIImage(), UIImage(named: "photo-1438761681033-6461ffad8d80.jpeg")?.cropsToSquare() ?? UIImage()], size: CGSize(width: 2048, height: 1024))

        let bottomImage = new
        let topImage = UIImage(named: "logoMask.png")

        let size = CGSize(width: 2048, height: 1144)
        UIGraphicsBeginImageContext(size)

        let areaSize = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        bottomImage.draw(in: CGRect(x: 0, y: 0, width: 2048, height: 1024))

        topImage!.draw(in: areaSize, blendMode: .normal, alpha: 1)

        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

    }

    
    
    

    @IBAction func shareAction(_ sender: Any) {
        resImg?.saveToCameraRoll { url in
            if let url = url {
               // self.postImg(url: url)
            }
        }
    }

 
}

extension UIImage {
    func cropsToSquare() -> UIImage {
        let refWidth = CGFloat(cgImage!.width)
        let refHeight = CGFloat(cgImage!.height)
        let cropSize = refWidth > refHeight ? refHeight : refWidth

        let x = (refWidth - cropSize) / 2.0
        let y = (refHeight - cropSize) / 2.0

        let cropRect = CGRect(x: x, y: y, width: cropSize, height: cropSize)
        let imageRef = cgImage?.cropping(to: cropRect)
        let cropped = UIImage(cgImage: imageRef!, scale: 0.0, orientation: imageOrientation)

        return cropped
    }
}

extension UIImage {
    static func collage(images: [UIImage], size: CGSize) -> UIImage {
        let rows = images.count < 3 ? 1 : 2
        let columns = Int(round(Double(images.count) / Double(rows)))
        let tileSize = CGSize(width: round(size.width / CGFloat(columns)),
                              height: round(size.height / CGFloat(rows)))

        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        UIColor.white.setFill()
        UIRectFill(CGRect(origin: .zero, size: size))

        for (index, image) in images.enumerated() {
            image.scaled(tileSize).draw(at: CGPoint(
                x: CGFloat(index % columns) * tileSize.width,
                y: CGFloat(index / columns) * tileSize.height
            ))
        }

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image ?? UIImage()
    }

    func scaled(_ newSize: CGSize) -> UIImage {
        guard size != newSize else {
            return self
        }

        let ratio = max(newSize.width / size.width, newSize.height / size.height)
        let width = size.width * ratio
        let height = size.height * ratio

        let scaledRect = CGRect(
            x: (newSize.width - width) / 2.0,
            y: (newSize.height - height) / 2.0,
            width: width, height: height)

        UIGraphicsBeginImageContextWithOptions(scaledRect.size, false, 0.0)
        defer { UIGraphicsEndImageContext() }

        draw(in: scaledRect)

        return UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
    }
}
