import UIKit
import Toaster

class MyCreation: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var mywork_collection: UICollectionView!
    var image_arr = [URL]()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        image_arr = FileManager.default.urls(for: .documentDirectory) ?? [URL]()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.title = "My creation"
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return image_arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Imagecell", for: indexPath as IndexPath)
        let imageURL = image_arr[indexPath.item]
        let my_image = cell.viewWithTag(100) as! UIImageView
        let btn_delete = cell.viewWithTag(101) as! UIButton
        btn_delete.addTarget(self, action: #selector(btn_delete_press(sender:)), for: .touchUpInside)
        my_image.image = UIImage(contentsOfFile: imageURL.path)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        if (UIDevice.current.userInterfaceIdiom == .pad)
        {
            let width_val  = (collectionView.frame.width-50)/6
            return CGSize(width: width_val, height: 140.0)
        }
        else
        {
            let width  = (collectionView.frame.width-20)/3
            return CGSize(width: width, height: 140.0)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailpage = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailpage.image_url = image_arr[indexPath.item]
        self.navigationController?.pushViewController(detailpage, animated: true)
    }
    @objc func btn_delete_press(sender:UIButton)
    {
        let alert = UIAlertController(title: "", message: NSLocalizedString("Are you sure oyu want to remove file?", comment: ""), preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            let buttonPosition = sender.convert(CGPoint.zero, to: self.mywork_collection)
            let indexPath = self.mywork_collection.indexPathForItem(at: buttonPosition)
            let fileManager = FileManager.default
            do {
                
                try fileManager.removeItem(at: self.image_arr[indexPath!.item])
                Toast(text: NSLocalizedString("Image remove successfully", comment: "")).show()
                self.image_arr.removeAll()
                self.image_arr = FileManager.default.urls(for: .documentDirectory) ?? [URL]()
                print(self.image_arr)
                self.mywork_collection.reloadData()
            } catch let error as NSError {
                print(error.debugDescription)
            }
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("No", comment: ""), style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
        
        
        
        
    }

}
extension FileManager
{
    func urls(for directory: FileManager.SearchPathDirectory, skipsHiddenFiles: Bool = true ) -> [URL]? {
        let documentsURL = urls(for: directory, in: .userDomainMask)[0]
        let fileURLs = try? contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil, options: skipsHiddenFiles ? .skipsHiddenFiles : [] )
        return fileURLs
    }
}
