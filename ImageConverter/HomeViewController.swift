import UIKit

class HomeViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    var imagePicker = UIImagePickerController()
    override func viewDidLoad() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        super.viewDidLoad()
        imagePicker.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    @IBAction func add_image_press(_ sender: UIButton)
    {
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func convert_image_press(_ sender: UIButton)
    {
        let creation_page = self.storyboard?.instantiateViewController(withIdentifier: "MyCreation") as! MyCreation
        self.navigationController?.pushViewController(creation_page, animated: true)
    }
    @IBAction func share_press(_ sender: UIButton)
    {
        let textToShare = NSLocalizedString("Image Converter app is very instresting app. which is a available on following url!", comment: "")
        
        if let myWebsite = URL(string: "itms-apps://itunes.apple.com/app/1470771922") {
            let objectsToShare = [textToShare, myWebsite] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityVC.popoverPresentationController?.sourceView = self.view
            self.present(activityVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func rate_press(_ sender: UIButton) {
        guard let url = URL(string: "itms-apps://itunes.apple.com/app/" + "1470771922") else {
            return
        }
        if #available(iOS 10, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[.editedImage] as? UIImage
        {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                let nextpage = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                nextpage.selected_image = image
                self.navigationController?.pushViewController(nextpage, animated: false)
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
    
}
