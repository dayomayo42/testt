//
//  RecordsProductsCell.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 26.10.2020.
//

import UIKit

class RecordsProductsCell: UITableViewCell {

    var count = 0
    var currentIndex: IndexPath?
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    var delegate: RecordProductDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(with model: Product, delegateRec: RecordProductDelegate, currentIndexPath: IndexPath) {
        nameLabel.text = model.name
        self.delegate = delegateRec
        currentIndex = currentIndexPath
        count = model.pivot?.count ?? 0
        countLabel.text = "\(count)"
    }

    @IBAction func plusAction(_ sender: Any) {
        if count < 100 {
            count += 1
            countLabel.text = "\(count)"
            delegate?.product[currentIndex?.section ?? 0].expandables?[currentIndex?.row ?? 0].pivot = ProductShort(id: 0, count: count)
            let cat = delegate?.productBuf.firstIndex(where: {$0.id == delegate?.product[currentIndex?.section ?? 0].id})
            let ind = delegate?.productBuf[cat ?? 0].expandables?.firstIndex(where: {$0.id == delegate?.product[currentIndex?.section ?? 0].expandables?[currentIndex?.row ?? 0].id})
            delegate?.productBuf[cat ?? 0].expandables?[ind ?? 0].pivot = ProductShort(id: 0, count: count)
        }
    }
    
    @IBAction func minusAction(_ sender: Any) {
        if count > 0 {
            count -= 1
            countLabel.text = "\(count)"
            delegate?.product[currentIndex?.section ?? 0].expandables?[currentIndex?.row ?? 0].pivot = ProductShort(id: 0, count: count)
            let cat = delegate?.productBuf.firstIndex(where: {$0.id == delegate?.product[currentIndex?.section ?? 0].id})
            let ind = delegate?.productBuf[cat ?? 0].expandables?.firstIndex(where: {$0.id == delegate?.product[currentIndex?.section ?? 0].expandables?[currentIndex?.row ?? 0].id})
            delegate?.productBuf[cat ?? 0].expandables?[ind ?? 0].pivot = ProductShort(id: 0, count: count)
        }
    }
    
}
