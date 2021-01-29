//
//  ViewController.swift
//  Apple Pie Code
//
//  Created by Владимир Кефели on 25.01.2021.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - UI Properties
    let buttonStackview = UIStackView()
    let correctWordLabel = UILabel()
    var letterButtons = [UIButton]()
    let scoreLabel = UILabel()
    let topStackView = UIStackView()
    let treeImageView = UIImageView()
    let stackView = UIStackView()
    
    // MARK: - Properties
    var currentGame: Game!
    let incorrectMovesAllowed = 7
    var listOfWords = [
       "Аист","Акула","Альбатрос",
       "Анаконда","Антилопа",
       "Анчоус","Бабочка",
       "Бабуин","Баклан","Бананоед",
       "Барабуля","Баран","Барсук",
       "Бегемот","Белка",
       "Бизон","Бобр","Броненосец",
       "Буревестник","Бурундук",
       "Варан","Волк","Воробей","Ворона",
       "Выдра","Гадюка","Газель",
       "Гамадрил","Гепард","Гиббон",
       "Глухарь","Голубь","Горилла",
       "Горлица","Двинозавр","Двухвостка","Дельфин",
       "Дрозд","Дятел","Ёж","Енот","Енотовидная собака",
       "Ёрш","Ехидна","Жаба","Жаворонок","Жако","Жираф",
       "Журавль","Заяц","Зебра","Змея",
       "Зубр","Иволга","Игуана","Кабан","Какаду","Кальмар",
       "Камбала","Камышовый кот",
       "Карась","Катран","Кенгуру",
       "Клещ","Кобра","Козёл",
       "Корнеед","Коршун","Корюшка",
       "Косатка","Косуля","Кошка","Краб",
       "Крокодил","Кролик","Крот","Крыса","Кукушка",
       "Куница","Курица","Куропатка",
       "Лама","Лань","Ласка","Ласточка","Лебедь",
       "Лев","Лемминг","Лемонема","Лемур",
       "Ленивец","Ленточник","Леопард",
       "Лесной кот","Летучая мышь","Лиса","Лось",
       "Лошадь","Лягушка","Малиновка","Мамонт","Мангуст",
       "Мартышка","Медведь белый","Медведь бурый","Моль","Морская свинка",
       "Морской котик","Морской лев","Муравей",
       "Муфлон","Муха","Мухоед","Мышь","Навага",
       "Норка","Носорог","Обезьяна","Овод","Овца","Окунь",
       "Олень","Омар","Омуль","Опоссум",
       "Орангутан","Оса","Осёл","Осётр",
       "Палтус","Панда","Паук","Пеликан","Перепел","Пересмешник",
       "Пингвин","Попугай","Пчела","Рак",
       "Рысь","Сайгак","Саламандра","Саранча",
       "Сардина","Сардинелла","Сверчок",
       "Синица","Скат","Скворец","Сколопендра",
       "Скорпион","Скумбрия","Слизень","Слон","Снегирь","Собака",
       "Сова","Сойка","Сокол","Соловей",
       "Сорока","Страус","Стрекоза",
       "Стриж","Судак","Сурок","Суслик","Сыч",
       "Таракан","Тетерев","Тигр","Тля","Тритон",
       "Трясогузка","Тунец","Тюлень","Тюлька",
       "Удав","Уж","Улитка","Устрица","Утконос",
       "Филин","Химера","Хомяк","Хорёк","Цапля",
       "Чайка","Черепаха","Шмель","Щука",
       "Ягуар","Ястреб","Ящер",
       "Ящерица","Дельфин","Кролик","Кулик"
    ].shuffled()
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    
    // MARK: - Methods
    func enableButtons(_ enable: Bool = true) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }



    func newRound() {
        guard !listOfWords.isEmpty else {
            enableButtons(false)
            updateUI()
            return
        }
        let newWord = listOfWords.removeFirst()
        currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed)
        updateUI()
        enableButtons()
    }
    
    func updateCorrectWordLabel() {
        var displayWord = [String]()
        for letter in currentGame.guessedWord {
            displayWord.append(String(letter))
        }
        correctWordLabel.text = displayWord.joined(separator:" ")
    }
    
    func updateState() {
        if currentGame.incorrectMovesRemaining < 1 {
            totalLosses += 1
        } else if currentGame.guessedWord == currentGame.word {
            totalWins += 1
        } else {
            updateUI()
        }
        updateUI()
    }
    
    func updateUI() {
        let movesRemaining = currentGame.incorrectMovesRemaining
        let imageNumber = (movesRemaining + 64) % 8
        let image = "Tree\(imageNumber)"
        treeImageView.image = UIImage(named: image)
        updateCorrectWordLabel()
        scoreLabel.text = "Выигрыши: \(totalWins), проигрыши: \(totalLosses)"
    }
    
    // MARK: - UI Methods
    @objc func letterButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letter = sender.title(for: .normal)!
        currentGame.playerGuessed(letter: Character(letter))
        updateState()
    }
    func initLetterButtons(fontSize: CGFloat = 17) {
        // Init letter buttons
        let buttonTitles = "ЙЦУКЕНГШЩЗХЪЁ_ФЫВАПРОЛДЖЭ___ЯЧСМИТЬБЮ__"
        for buttonTitle in buttonTitles {
            let title: String = buttonTitle == "_" ? "" : String(buttonTitle)
            let button = UIButton()
            if buttonTitle != "_" {
                button.addTarget(self, action: #selector(letterButtonPressed(_:)), for: .touchUpInside)
            }
            button.setTitle(title, for: [])
            button.setTitleColor(.systemGray, for: .disabled)
            button.setTitleColor(.systemBlue, for: .normal)
            button.setTitleColor(.systemTeal, for: .highlighted)
            button.titleLabel?.textAlignment = .center
            button.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
            letterButtons.append(button)
        }
        
        let buttonRows = [UIStackView(), UIStackView(), UIStackView()]
        let rowCount = letterButtons.count / 3
        
        for row in 0 ..< buttonRows.count {
            for index in 0 ..< rowCount {
                buttonRows[row].addArrangedSubview(letterButtons[row * rowCount + index])
            }
            buttonRows[row].distribution = .fillEqually
            buttonStackview.addArrangedSubview(buttonRows[row])
        }
    }
    
    func updateUI(to size: CGSize) {
        topStackView.axis = size.height < size.width ? .horizontal : .vertical
        topStackView.frame = CGRect(x: 8, y: 8, width: size.width - 17, height: size.height - 17)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let size = view.bounds.size
        let factor = min(size.height, size.width)
        
        // Setup button stack view
        buttonStackview.axis = .vertical
        buttonStackview.distribution = .fillEqually
        
        // Setup correct word label
        correctWordLabel.font = UIFont.systemFont(ofSize: factor / 10)
        correctWordLabel.text = "Word"
        correctWordLabel.textAlignment = .center
        
        // Setup letter buttons
        initLetterButtons()
        
        // Setup score label
        scoreLabel.font = UIFont.systemFont(ofSize: factor / 16)
        scoreLabel.text = "Score"
        scoreLabel.textAlignment = .center
        
        // Setup stack view
        stackView.addArrangedSubview(buttonStackview)
        stackView.addArrangedSubview(correctWordLabel)
        stackView.addArrangedSubview(scoreLabel)
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
        
        // Setup top stack view
        topStackView.distribution = .fillEqually
        topStackView.addArrangedSubview(treeImageView)
        topStackView.addArrangedSubview(stackView)
        topStackView.spacing = 16
        
        // Setup tree image view
        treeImageView.contentMode = .scaleAspectFit
        treeImageView.image = UIImage(named: "Tree3")
        
        // Setup view
        view.addSubview(topStackView)
        view.backgroundColor = .white
        
        
        updateUI(to: view.bounds.size)
        
        newRound()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        updateUI(to: size)
    }
    
}

