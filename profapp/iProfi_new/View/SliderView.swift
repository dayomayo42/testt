//
//  SliderView.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 01.10.2020.
//

import UIKit
import SnapKit
import AlamofireImage

protocol ImageSliderDelegate {
    func imageSliderCornerRadius() -> CGFloat
    func imageSliderOffset() -> CGFloat
    func imageSliderAspectWidth() -> CGFloat
    func imageSliderAspectHeigh() -> CGFloat
    func pagerIndicatorOffset() -> CGFloat
    func onClick(pageIndex: Int)
    func sliderBorderColor() -> CGColor
    func sliderBorderWidth() -> CGFloat
    func sliderFrameRadius() -> CGFloat
}

class ImageSlider: UIView {
    var delegate: ImageSliderDelegate?
    var slidesCount: Int = 0
    var timer: Timer?
    var slides: [Slide] = []
    var isContentEmpty = false
    var mainView = UIView()
    var pageIndicatorBottomView = UIView()

    var scrollView: UIScrollView = {
        var view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
       // view.bounces = false
        return view
    }()
    
    var pagerIndicator: UIPageControl = {
        var view = UIPageControl()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func createSlides(_ model: SliderModel) -> [Slide]? {
        guard let modelData = model.data else { return nil }
        slides = []
        for item in modelData {
            let slide = Slide(frame: .zero)
            slide.imageView.contentMode = .scaleAspectFill
            
            if let imageUrl = URL(string: item.image ?? "") {
                slide.imageView.af_setImage(withURL: imageUrl)
            } else {
                slide.imageView.image = UIImage(named: "sliderDefault")
            }
            if let slideName = item.name {
                slide.titleLabel.shadowColor = UIColor.black
                slide.titleLabel.shadowOffset = CGSize(width: 0, height: -1)
                slide.titleLabel.text = slideName
            } else {
                slide.titleLabel.text = ""
                slide.gradientView.isHidden = true
            }
            
            slides.append(slide)
        }
//
//        if slides.count == 0 {
//            let slide = Slide(frame: .zero)
//            let plug = UIImage(named: "sliderNoSlidesPlug")
            
//            let string = "Контент отсутствует, проверьте ваше интернет соединение или обратитесь в поддержку"
//            let attr = [ NSAttributedString.Key.foregroundColor: UIColor(named: "appBlue")]
//            let slideString = NSAttributedString(string: string, attributes: attr)
//
//            slide.titleLabel.attributedText = slideString
//            slide.imageView.contentMode = .scaleAspectFit
//            slide.titleLabel.text = ""
//            slide.imageView.image = plug
//            slides.append(slide)
//            isContentEmpty = true
//        } else {
//            isContentEmpty = false
//        }

        return slides
    }
    
    func startSlideshow(_ time: Double) {
        timer = Timer.scheduledTimer(timeInterval: time, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        timer!.fire()
    }
    
    @objc func fireTimer() {
        if pagerIndicator.currentPage == slidesCount -  1 {
             UIView.animate(withDuration: 1.3) {
                self.scrollView.contentOffset.x = 0
            }
        } else {
            UIView.animate(withDuration: 0.5) {
                self.scrollView.contentOffset.x = (self.scrollView.contentSize.width/CGFloat(self.slidesCount)) * CGFloat((self.pagerIndicator.currentPage + 1))
            }
        }
    }
    
    func setupSlideScrollView(slides: [Slide]) {
        
        if slides.count == 0 {
            isContentEmpty = true
        } else {
            isContentEmpty = false
        }
        
        pagerIndicator.snp.makeConstraints { (make) in
            make.bottom.equalTo(pageIndicatorBottomView).offset(delegate!.pagerIndicatorOffset())
            make.centerXWithinMargins.equalTo(pageIndicatorBottomView)
        }
        
        scrollView.contentOffset.x = 0
        
        pagerIndicator.currentPage = 0
        
        scrollView.subviews.forEach { sub in
            sub.removeFromSuperview()
        }
        
        let width = UIScreen.main.bounds.width-delegate!.imageSliderOffset()*2
        let height = (width*delegate!.imageSliderAspectHeigh())/delegate!.imageSliderAspectWidth()
        
        scrollView.layer.cornerRadius = delegate!.imageSliderCornerRadius()
        scrollView.frame = CGRect(x: 0, y: 0, width: width, height: height)
        scrollView.contentSize = CGSize(width: width * CGFloat(slides.count), height: height)
        scrollView.isPagingEnabled = true
        
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: width * CGFloat(i), y: 0, width: width, height: height)
            slides[i].layer.masksToBounds = true
            scrollView.addSubview(slides[i])
        }
        slidesCount = slides.count
        
        if slidesCount > 1 {
            pagerIndicator.numberOfPages = slidesCount
            pagerIndicator.isHidden = false
        } else {
            pagerIndicator.isHidden = true
        }
        scrollView.delegate = self
        
        scrollView.layer.borderColor = delegate!.sliderBorderColor()
        scrollView.layer.borderWidth = delegate!.sliderBorderWidth()
        mainView.layer.cornerRadius = delegate!.sliderFrameRadius()
    }
    
    func setupScrollView() {
        self.addSubview(pageIndicatorBottomView)
        self.addSubview(mainView)
        self.addSubview(scrollView)
        self.addSubview(pagerIndicator)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.onSlideClick(_:)))
        self.addGestureRecognizer(tap)
        
        mainView.snp.makeConstraints { make in
            make.top.equalTo(self)
            make.bottom.equalTo(self).offset(-25)
            make.left.equalTo(self)
            make.right.equalTo(self)
        }
        
        pageIndicatorBottomView.snp.makeConstraints { make in
            make.height.equalTo(25)
            make.bottom.equalTo(self)
            make.right.equalTo(self)
            make.left.equalTo(self)
        }
        
        pageIndicatorBottomView.backgroundColor = .clear
        
        pagerIndicator.pageIndicatorTintColor = UIColor(named: "borderColor")
        pagerIndicator.currentPageIndicatorTintColor = UIColor(named: "appBlue")
        
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(mainView)
            make.bottom.equalTo(mainView)
            make.left.equalTo(mainView)
            make.right.equalTo(mainView)
        }
    }
    
    @objc func onSlideClick(_ sender: UITapGestureRecognizer? = nil) {
        if !isContentEmpty {
            delegate?.onClick(pageIndex: pagerIndicator.currentPage)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupScrollView()
        pagerIndicator.isUserInteractionEnabled = false
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupScrollView()
        pagerIndicator.isUserInteractionEnabled = false
    }

}

extension ImageSlider: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pos = scrollView.contentOffset.x / (scrollView.contentSize.width/CGFloat(slidesCount))
//        print(pos)
//        if pos < 0 {
//            UIView.animate(withDuration: 0.3) {
//                scrollView.contentOffset.x = scrollView.contentSize.width
//            }
//        }
//        if pos > CGFloat(Double(slidesCount) - 0.9) {
//            UIView.animate(withDuration: 0.3) {
//                scrollView.contentOffset.x = 0
//            }
//        }
        pagerIndicator.currentPage = Int(pos)
    }
}
