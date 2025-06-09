using MY_LOGIN_ERP.DataAccess;
using MY_LOGIN_ERP.Models;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;

namespace MY_LOGIN_ERP
{
    public class UserViewModel : INotifyPropertyChanged
    {
        private readonly MySqlDataAccess _userService; // UserService 인스턴스
        public ObservableCollection<User> Users { get; set; }
        public string NewUserName { get; set; }
        public string NewUserEmail { get; set; }
        private string _statusMessage;
        public string StatusMessage
        {
            get => _statusMessage;
            set { _statusMessage = value; OnPropertyChanged(); }
        }

        public ICommand LoadUsersCommand { get; }
        public ICommand AddUserCommand { get; }

        public UserViewModel()
        {
            _userService = new MySqlDataAccess();
            Users = new ObservableCollection<User>();
            LoadUsersCommand = new RelayCommand(async () => await LoadUsers());
            AddUserCommand = new RelayCommand(async () => await AddUser());

            // 초기 사용자 로드
            _ = LoadUsers(); // 비동기 메서드를 시작하고 결과를 기다리지 않음
        }

        private async Task LoadUsers()
        {
            StatusMessage = "사용자 목록을 불러오는 중...";
            var users = await _userService.GetUsersAsync();
            if (users != null)
            {
                Users.Clear();
                foreach (var user in users)
                {
                    Users.Add(user);
                }
                StatusMessage = $"사용자 {Users.Count}명 불러오기 완료.";
            }
            else
            {
                StatusMessage = "사용자 불러오기 실패.";
            }
        }

        private async Task AddUser()
        {
            if (string.IsNullOrWhiteSpace(NewUserName) || string.IsNullOrWhiteSpace(NewUserEmail))
            {
                StatusMessage = "이름과 이메일을 입력해주세요.";
                return;
            }

            StatusMessage = "사용자 추가 중...";
            var newUser = new User { Username = NewUserName, Email = NewUserEmail };
            var createdUser = await _userService.CreateUserAsync(newUser);
            if (createdUser != null)
            {
                Users.Add(createdUser);
                NewUserName = string.Empty;
                NewUserEmail = string.Empty;
                OnPropertyChanged(nameof(NewUserName)); // UI 업데이트
                OnPropertyChanged(nameof(NewUserEmail)); // UI 업데이트
                StatusMessage = $"{createdUser.Username} 사용자 추가 완료!";
            }
            else
            {
                StatusMessage = "사용자 추가 실패.";
            }
        }

        // INotifyPropertyChanged 구현 (생략 - 기본 템플릿에 포함)
        public event PropertyChangedEventHandler PropertyChanged;
        protected void OnPropertyChanged([CallerMemberName] string propertyName = null)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }

    // 간단한 RelayCommand 구현 (MVVM 패턴에서 ICommand 구현용)
    public class RelayCommand : ICommand
    {
        private readonly Action _execute;
        private readonly Func<bool> _canExecute;

        public RelayCommand(Action execute, Func<bool> canExecute = null)
        {
            _execute = execute ?? throw new ArgumentNullException(nameof(execute));
            _canExecute = canExecute;
        }

        public bool CanExecute(object parameter) => _canExecute?.Invoke() ?? true;
        public void Execute(object parameter) => _execute();
        public event EventHandler CanExecuteChanged
        {
            add { CommandManager.RequerySuggested += value; }
            remove { CommandManager.RequerySuggested -= value; }
        }
    }
}
