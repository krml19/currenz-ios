//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        let label = UILabel()
        label.frame = CGRect(x: 150, y: 200, width: 200, height: 20)
        label.text = "Hello World!"
        label.textColor = .black
//        label.cardView()
        label.backgroundColor = .white
        
        let viewxxx = UIView()
        viewxxx.frame = CGRect(x: 150, y: 100, width: 200, height: 20)
        viewxxx.dropShadow()
        viewxxx.backgroundColor = UIColor.gray
        view.addSubview(viewxxx)
        
        view.addSubview(label)
        self.view = view
        
    }
}

extension UIView {
    func dropShadow(width: CGFloat = 1, color: UIColor = UIColor.black.withAlphaComponent(0.5), radius: CGFloat = 5, offset: CGSize = CGSize(width: 0, height: 3), opacity: Float = 0.5, shouldRasterize: Bool = true) {
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.cornerRadius = radius
        layer.shadowOffset = offset
        layer.shadowOpacity = opacity
        layer.shouldRasterize = shouldRasterize
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
PlaygroundPage.current.needsIndefiniteExecution = true
