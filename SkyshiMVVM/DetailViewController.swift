//
//  DetailViewController.swift
//  SkyshiMVVM
//
//  Created by Skyshi on 7/20/18.
//  Copyright © 2018 Skyshi. All rights reserved.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {

    @IBOutlet var movieVM: MovieVM!
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblLegal: UILabel!
    @IBOutlet var imgMovie: UIImageView!
    
    var index: Int = 0
    var movie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.navigationController?.navigationBar.isHidden = false
        movieVM.setNavBar(view: self, title: movie.name ?? "")
        
        lblName.text = movie.name ?? ""
        //lblLegal.text = movie.legal ?? ""
        imgMovie.sd_setImage(with: URL(string: movie.image ?? ""), placeholderImage: nil)
        let string = "<h3>Test Title</h3><p>Lorem ipsum, dolor sit amet consectetur adipisicing elit. Rerum et iste consequuntur eius, nemo laborum ad corrupti debitis soluta veritatis. Aspernatur exercitationem numquam earum velit facilis debitis mollitia quidem. Nemo!</p>".htmlToAttributedString
        let mutableString = NSMutableAttributedString(attributedString: string!)
        mutableString.setFontFace(font: UIFont(name: "Helvetica", size: 16.0)!)
        lblLegal.attributedText = mutableString
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

extension String {
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            var dict: NSDictionary?
            dict = NSMutableDictionary()
            
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: &dict)
        } catch {
            return NSAttributedString()
        }
    }
    
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}

extension NSMutableAttributedString {
    
    func setFontFace(font: UIFont, color: UIColor? = nil) {
        beginEditing()
        self.enumerateAttribute(.font, in: NSRange(location: 0, length: self.length)) { (value, range, stop) in
            if let f = value as? UIFont, let newFontDescriptor = f.fontDescriptor.withFamily(font.familyName).withSymbolicTraits(f.fontDescriptor.symbolicTraits) {
                let newFont = UIFont(descriptor: newFontDescriptor, size: font.pointSize)
                removeAttribute(.font, range: range)
                addAttribute(.font, value: newFont, range: range)
                if let color = color {
                    removeAttribute(.foregroundColor, range: range)
                    addAttribute(.foregroundColor, value: color, range: range)
                }
            }
        }
        endEditing()
    }
}
