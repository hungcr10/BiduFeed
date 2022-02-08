
import UIKit

class HomeViewController: UIViewController {
    var images = [String]()
    //MARK: - IBOulet
    @IBOutlet weak var mainTableView: UITableView!
}
    //MARK: - Life Cycle
    extension HomeViewController {
        override func viewDidLoad() {
            super.viewDidLoad()
            setUpTableView()
            setUpDisplay()
        }
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            navigationController?.setNavigationBarHidden(true, animated: animated)
        }
    }
    
//MARK: - Setup
extension HomeViewController {
    func setUpTableView() {
        mainTableView.register(UINib(nibName: Constants.tableNibName, bundle: nil), forCellReuseIdentifier: Constants.tableIdentifier)
        mainTableView.dataSource = self
        mainTableView.delegate = self
        mainTableView.separatorStyle = .none
    }
    func setUpDisplay() {
       let jsonFile = FileManager.default.urls(for: .documentDirectory,
                                                  in: .userDomainMask).first!.appendingPathComponent(Constants.URLName)
       print("file Json",jsonFile)
       if FileManager.default.fileExists(atPath: jsonFile.path) {
           guard let imageModel = getJSONLocal() else { return }
           images = imageModel.images
           mainTableView.reloadData()
       } else {
           Networking.shared.fetchItem { data in
               self.saveJSONLocal(model: data)
               self.images = data.images
               DispatchQueue.main.async {
                   self.mainTableView.reloadData()
               }
           }
       }
   }
   
   private func saveJSONLocal(model: PostModel) {
       let fileURL = FileManager.default.urls(for: .documentDirectory,
                                                 in: .userDomainMask).first!.appendingPathComponent(Constants.URLName)
       let dogData = try! JSONEncoder().encode(model)
       do {
           try dogData.write(to: fileURL)
       } catch  {
           print(error)
       }
   }
   
   private func getJSONLocal() -> PostModel? {
       let fileURL = FileManager.default.urls(for: .documentDirectory,
                                                 in: .userDomainMask).first!.appendingPathComponent(Constants.URLName)
       guard  let data = try? Data(contentsOf: fileURL) else { return nil }
       let result = try? JSONDecoder().decode(PostModel.self, from: data)
       return result
   }
    
}
//MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Infomation.infomation.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainTableView.dequeueReusableCell(withIdentifier: Constants.tableIdentifier) as! HomeTableViewCell
        cell.configure(with: Infomation.infomation[indexPath.row])
        cell.images = images
        return cell
    }
}
//MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.size.height * 0.8
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mainTableView.deselectRow(at: indexPath, animated: true)
    }
}
