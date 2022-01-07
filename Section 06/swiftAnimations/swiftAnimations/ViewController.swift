import UIKit

class ViewController: UIViewController {
    
    fileprivate var animator = UIViewPropertyAnimator(duration: 1, curve: .linear, animations: nil)
    fileprivate var imageView: UIImageView = UIImageView(image: UIImage(named: "alex"))
    fileprivate var blurView: UIVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .prominent))
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        view.addSubview(imageView)
        view.addSubview(blurView)
        
        imageView.frame = view.frame
        imageView.contentMode = .scaleAspectFill
        
        blurView.frame = view.frame
        
        self.blurView.alpha = 0.5
        
        animator.addAnimations {
            self.blurView.alpha = 1
            self.imageView.transform = CGAffineTransform(scaleX: 2, y: 2)
        }
        
        setupSlider()
    }
    
    func setupView() {
        view.backgroundColor = .white
    }
    
    fileprivate func setupSlider() {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(slider)
        
        slider.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        slider.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        slider.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 150).isActive = true
        
        slider.addTarget(self, action: #selector(handleSliderChanged(slide:)), for: .allEvents)
    }
    
    @objc fileprivate func handleSliderChanged(slide: UISlider) {
        animator.fractionComplete = CGFloat(slide.value)
    }

}

