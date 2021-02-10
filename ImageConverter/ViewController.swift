import UIKit
import Toaster

class ViewController: UIViewController {

    @IBOutlet weak var imgview_select: UIImageView!
    var selected_image = UIImage()
    var image_count = Int()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        imgview_select.image = selected_image
        image_count = UserDefaults.standard.integer(forKey: "Image_count")
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = ""
    }

    @IBAction func btn_jpeg_press(_ sender: UIButton) {
        if let data = selected_image.jpegData(compressionQuality: 1.0)
        {
            let filename = getDocumentsDirectory().appendingPathComponent("Image\(image_count).jpeg")
            print(filename)
            try? data.write(to: filename)
            let imagecount = UserDefaults.standard.integer(forKey: "Image_count") + 1
            UserDefaults.standard.set(imagecount, forKey: "Image_count")
            Toast(text: "Image converted successfully").show()
        }
    }
    
    @IBAction func btn_png_press(_ sender: UIButton)
    {
        
        if let data = selected_image.pngData() {
            let filename = getDocumentsDirectory().appendingPathComponent("Image\(image_count).png")
            print(filename)
            try? data.write(to: filename)
            let imagecount = UserDefaults.standard.integer(forKey: "Image_count") + 1
            UserDefaults.standard.set(imagecount, forKey: "Image_count")
            Toast(text: "Image converted successfully").show()
        }
    }
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

