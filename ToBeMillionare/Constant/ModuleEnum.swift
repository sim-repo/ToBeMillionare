import Foundation


enum ModuleEnum: String {
    
    case profile
    case createProfile
    case options
    case menu
    case leaderboard
    case game
    case play
    case score
    case callFriends
    case finish
    case unknown
    
    
    init(vc: PresentableView) {
        switch vc {
        case is ProfileViewController:
            self = .profile
        case is NewProfileViewController:
            self = .createProfile
        case is OptionsViewController:
            self = .options
        case is ViewController:
            self = .menu
        case is LeaderboardViewController:
            self = .leaderboard
        case is PlayViewController:
            self = .play
        case is CallFriendsViewController:
            self = .callFriends
        case is ScoreViewController:
            self = .score
        case is FinishViewController:
            self = .finish
        default:
            //TODO: catch err
            self = .unknown
        }
    }
    
    
    init(presenter: PresenterProtocol) {
        switch presenter {
        case is ProfilePresenter:
            self = .profile
        case is CreateProfilePresenter:
            self = .createProfile
        case is OptionsPresenter:
            self = .options
        case is MenuPresenter:
            self = .menu
        case is LeaderboardPresenter:
            self = .leaderboard
        case is GamePresenter:
            self = .game
        case is PlayPresenter:
            self = .play
        case is CallFriendsPresenter:
            self = .callFriends
        case is ScorePresenter:
            self = .score
        case is FinishPresenter:
            self = .finish
        default:
            //TODO: catch err
            self = .unknown
        }
    }
    
    
    init(presenterType: PresenterProtocol.Type) {
        switch presenterType {
        case is ProfilePresenter.Type:
            self = .profile
        case is CreateProfilePresenter.Type:
            self = .createProfile
        case is OptionsPresenter.Type:
            self = .options
        case is MenuPresenter.Type:
            self = .menu
        case is LeaderboardPresenter.Type:
            self = .leaderboard
        case is GamePresenter.Type:
            self = .game
        case is PlayPresenter.Type:
            self = .play
        case is CallFriendsPresenter.Type:
            self = .callFriends
        case is ScorePresenter.Type:
            self = .score
        case is FinishPresenter.Type:
            self = .finish
        default:
            //TODO: catch err
            self = .unknown
        }
    }
    
    
    var presenter: PresenterProtocol.Type {
        switch self {
        case .profile:
            return ProfilePresenter.self
        case .createProfile:
            return CreateProfilePresenter.self
        case .options:
            return OptionsPresenter.self
        case .menu:
            return MenuPresenter.self
        case .leaderboard:
            return LeaderboardPresenter.self
        case .game:
            return GamePresenter.self
        case .play:
            return PlayPresenter.self
        case .callFriends:
            return CallFriendsPresenter.self
        case .score:
            return ScorePresenter.self
        case .finish:
            return FinishPresenter.self
        default:
            //TODO: catch err
            return ProfilePresenter.self
        }
    }
}
