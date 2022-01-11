
import UIKit

class HomeViewController: UIViewController {
    //MARK: - IBOulet
    @IBOutlet weak var mainTableView: UITableView!
}
    //MARK: - Life Cycle
    extension HomeViewController {
        override func viewDidLoad() {
            super.viewDidLoad()
            setUpTableView()
        }
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            navigationController?.setNavigationBarHidden(true, animated: animated)
        }
    }
    
//MARK: - Setup
extension HomeViewController {
    func setUpTableView() {
        mainTableView.register(UINib(nibName: Contants.tableNibName, bundle: nil), forCellReuseIdentifier: Contants.tableIdentifier)
        mainTableView.dataSource = self
        mainTableView.delegate = self
        mainTableView.separatorStyle = .none
    }
}
//MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Infomation.infomation.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainTableView.dequeueReusableCell(withIdentifier: Contants.tableIdentifier) as! HomeTableViewCell
        cell.configure(with: Infomation.infomation[indexPath.row])
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
