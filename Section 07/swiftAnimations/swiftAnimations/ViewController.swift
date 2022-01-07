import UIKit

class ViewController: UIViewController {
    
    fileprivate var animator = UIViewPropertyAnimator(duration: 1, curve: .linear, animations: nil)
    fileprivate var imageView: UIImageView = UIImageView(image: UIImage(named: "alex"))
    fileprivate var blurView: UIVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .prominent))
    fileprivate var box: UIView = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        box.backgroundColor = .red
        box.translatesAutoresizingMaskIntoConstraints = false
       
        
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
        
        view.addSubview(box)
        box.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        box.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        box.widthAnchor.constraint(equalToConstant: 150).isActive = true
        box.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        perform(#selector(self.animateBox), with: nil, afterDelay: 1)
    }
    
    @objc
    fileprivate func animateBox() {
        UIView.animate(withDuration: 0.3, delay: 1, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseIn) {
            var transform = CGAffineTransform.identity
            transform = transform.scaledBy(x: 1.1, y: 1.6)
            transform = transform.translatedBy(x: 30, y: 50)
            transform = transform.rotated(by: 45)
            
            self.box.transform = transform
        }
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

