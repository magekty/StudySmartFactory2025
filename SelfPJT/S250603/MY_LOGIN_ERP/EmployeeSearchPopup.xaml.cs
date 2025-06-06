// EmployeeSearchPopup.xaml.cs
using MY_LOGIN_ERP.DataAccess;
using MY_LOGIN_ERP.Models;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Windows;
using System.Windows.Input; // MouseDoubleClick 이벤트를 위해

namespace MY_LOGIN_ERP
{

    /// <summary>
    /// EmployeeSearchPopup.xaml에 대한 상호 작용 논리
    /// </summary>
    public partial class EmployeeSearchPopup : Window
    {
        private MySqlDataAccess _dataAccess;
        public Employee SelectedEmployee { get; private set; } // 선택된 사원 정보를 외부로 전달하기 위한 속성

        public EmployeeSearchPopup()
        {
            InitializeComponent();
            _dataAccess = new MySqlDataAccess();
            this.Owner = Application.Current.MainWindow; // 부모 창을 메인 윈도우로 설정하여 팝업이 메인 윈도우 위에 뜨도록 함
        }

        // 팝업 창 로드 시 초기 사원 목록 로드
        public void Window_Loaded(object sender, RoutedEventArgs e)
        {
            LoadPopupEmployees();
        }

        // 팝업 내 사원 목록 로드 메서드
        private void LoadPopupEmployees()
        {
            string employeeName = txtPopupEmployeeName.Text;
            // 데이터 액세스 메서드를 재사용 (필요하다면 팝업 전용 검색 메서드 추가 가능)
            List<Employee> employees = _dataAccess.GetEmployees(employeeName: employeeName);
            dgPopupEmployees.ItemsSource = new ObservableCollection<Employee>(employees); // ObservableCollection으로 바인딩
        }

        // 팝업 내 '돋보기' 또는 '%' 버튼 클릭 시 검색
        private void PopupSearch_Click(object sender, RoutedEventArgs e)
        {
            LoadPopupEmployees();
        }

        // '적용' 버튼 클릭 시 선택된 사원 정보를 메인으로 전달
        private void ApplyButton_Click(object sender, RoutedEventArgs e)
        {
            if (dgPopupEmployees.SelectedItem is Employee selectedEmployee)
            {
                SelectedEmployee = selectedEmployee;
                this.DialogResult = true; // DialogResult를 true로 설정하여 부모 창에 성공적으로 선택되었음을 알림
                this.Close();
            }
            else
            {
                MessageBox.Show("사원을 선택해주세요.", "선택 오류", MessageBoxButton.OK, MessageBoxImage.Warning);
            }
        }

        // '닫기' 버튼 클릭 시 팝업 닫기
        private void CloseButton_Click(object sender, RoutedEventArgs e)
        {
            this.DialogResult = false; // DialogResult를 false로 설정하여 부모 창에 선택이 취소되었음을 알림
            this.Close();
        }

        // 데이터그리드 항목 더블클릭 시 바로 '적용'과 동일한 동작 수행
        private void dgPopupEmployees_MouseDoubleClick(object sender, MouseButtonEventArgs e)
        {
            ApplyButton_Click(sender, e);
        }
    }
}
