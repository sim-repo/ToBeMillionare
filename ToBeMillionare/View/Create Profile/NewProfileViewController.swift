import UIKit

class NewProfileViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var agePickerView: UIPickerView!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    var presenter: ViewableCreateProfilePresenter {
        return PresenterFactory.shared.getPresenter(viewDidLoad: self) as! ViewableCreateProfilePresenter
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        agePickerView.isHidden = true
    }
    

    
    @IBAction func pressOk(_ sender: Any) {
        presenter.didSubmitProfile()
    }
    
    
    @IBAction func pressCancel(_ sender: Any) {
        presenter.didCancel()
    }
}


//MARK:- UIPicker Delegate
extension NewProfileViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 100
    }
    

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        ageTextField.text = "\(row)"
        presenter.didInputAge(age: row)
        agePickerView.isHidden = true
    }
    
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: "\(row)", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
    }
}


//MARK:- Text Field Delegate
extension NewProfileViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == self.ageTextField {
            agePickerView.isHidden = false
            textField.endEditing(true)
        }
        
       
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
         if textField == self.nameTextField {
            presenter.didInputName(name: textField.text ?? "")
         }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
}

//MARK:- Collection Data Source

extension NewProfileViewController: UICollectionViewDataSource {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfRowsInSection()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewProfileCell", for: indexPath) as! NewProfileCell
        
        let avaRUL = presenter.getData(indexPath)
        cell.setup(ava: avaRUL)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        highlightCell(indexPath, cell)
    }
}


//MARK:- Collection Data Delegate

extension NewProfileViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectAva(indexPath)
        let cell = collectionView.cellForItem(at: indexPath)!
        highlightCell(indexPath, cell)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        presenter.didDeselectAva(indexPath)
        highlightCell(indexPath, cell)
    }
    
    private func highlightCell(_ indexPath: IndexPath, _ cell: UICollectionViewCell) {
        if presenter.isSelected(indexPath) {
            cell.layer.borderWidth = 2.0
            cell.layer.borderColor = UIColor.gray.cgColor
        } else {
            cell.layer.borderWidth = 0
            cell.layer.borderColor = .none
        }
    }
}



//MARK:- Presentable

extension NewProfileViewController: PresentableCreateProfileView {
    

    func performProfileSegue() {
        navigationController?.popViewController(animated: true)
    }
    
    
    func performMenuSegue() {
        performSegue(withIdentifier: "SegueMenu2", sender: nil)
    }
    
    
    func alertNameIsEmpty() {
        
    }
    
    
    func alertAgeIsEmpty() {
        
    }
    
    
    func alertAvaIsEmpty() {
        
    }
    
}
