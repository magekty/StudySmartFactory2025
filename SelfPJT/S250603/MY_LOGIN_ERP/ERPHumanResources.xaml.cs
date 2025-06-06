// MainWindow.xaml.cs
using MY_LOGIN_ERP.DataAccess;
using MY_LOGIN_ERP.Models;
using System;
using System.Collections.ObjectModel; // ObservableCollection 사용
using System.Windows;
using System.Windows.Controls;

namespace MY_LOGIN_ERP
{
    public partial class ERPHumanResources : Window
    {
        private MySqlDataAccess _dataAccess;
        // ObservableCollection은 UI에 데이터 변경 사항을 자동으로 반영합니다.
        public ObservableCollection<Employee> Employees { get; set; } = new ObservableCollection<Employee>();
        // 조회 조건 바인딩을 위한 속성 (MVVM 패턴의 ViewModel 역할)
        public DateTime CurrentDate { get; set; } = DateTime.Today; // 기준년월일 초기값
        public string SelectedDepartmentName { get; set; } // 부서 검색 결과를 저장
        public string SelectedEmployeeName { get; set; } // 사원 검색 결과를 저장
        public Employee SelectedEmployee { get; private set; }

        public ERPHumanResources()
        {
            InitializeComponent();
            _dataAccess = new MySqlDataAccess();
            this.DataContext = this; // DataContext를 자기 자신으로 설정하여 속성 바인딩 가능하게 함
            LoadEmployees(); // 초기 사원 목록 로드
        }

        // 사원 목록을 로드하는 메서드
        private void LoadEmployees()
        {
            // 현재 선택된 필터 조건들을 가져옴
            string department = string.IsNullOrEmpty(SelectedDepartmentName) ? null : SelectedDepartmentName;
            string employeeName = string.IsNullOrEmpty(SelectedEmployeeName) ? null : SelectedEmployeeName;
            string addressType = ((ComboBoxItem)cbAddressType.SelectedItem).Content.ToString();
            string employeeType = ((ComboBoxItem)cbEmployeeType.SelectedItem).Content.ToString();
            string status = ((ComboBoxItem)cbStatus.SelectedItem).Content.ToString();
            // "선택안함"이 선택된 경우 필터에서 제외
            if (addressType == "선택안함") addressType = null;
            if (employeeType == "선택안함") employeeType = null;
            if (status == "선택안함") status = null;

            var employees = _dataAccess.GetEmployees(
                department: department,
                employeeName: employeeName,
                addressType: addressType,
                employeeType: employeeType,
                status: status
            );
            // 기존 목록을 비우고 새 데이터를 추가하여 DataGrid를 업데이트
            Employees.Clear();
            foreach (var emp in employees)
            {
                Employees.Add(emp);
            }
        }

        // '초기화' 버튼 클릭 이벤트 핸들러
        private void ClearButton_Click(object sender, RoutedEventArgs e)
        {
            SelectedEmployeeName = null;
            txtEmployee.Text = null;
        }

        // '조회' 버튼 클릭 이벤트 핸들러
        private void SearchButton_Click(object sender, RoutedEventArgs e)
        {
            LoadEmployees();
        }

        // '부서' 돋보기 버튼 클릭 이벤트 핸들러 (부서 검색 팝업)
        private void SearchDepartment_Click(object sender, RoutedEventArgs e)
        {
            // TODO: 부서 검색 팝업 구현 (여기서는 임시로 메시지 박스)
            MessageBox.Show("부서 검색 팝업을 띄웁니다.", "알림", MessageBoxButton.OK, MessageBoxImage.Information);
            // 실제 구현 시, 부서 목록을 보여주는 새 창을 띄우고, 선택된 부서 정보를 txtDepartment.Text에 반영해야 합니다.
            // 예:
            // var departmentPopup = new DepartmentSearchPopup(); // 새 부서 검색 팝업 창
            // if (departmentPopup.ShowDialog() == true)
            // {
            //     // departmentPopup.SelectedDepartment (팝업에서 선택된 부서 객체)를 가져와 txtDepartment.Text에 반영
            //     txtDepartment.Text = departmentPopup.SelectedDepartment.Name;
            //     // SelectedDepartmentName 바인딩 속성도 업데이트 (선택사항)
            //     SelectedDepartmentName = departmentPopup.SelectedDepartment.Name; 
            // }
        }

        // '사원' 돋보기 버튼 클릭 이벤트 핸들러 (사원 검색 팝업)
        private void SearchEmployee_Click(object sender, RoutedEventArgs e)
        {
            EmployeeSearchPopup employeeSearchPopup = new EmployeeSearchPopup();
            if (employeeSearchPopup.ShowDialog() == true)
            {
                // 팝업에서 선택된 사원 정보가 있다면 메인 페이지의 txtEmployee에 반영
                if (employeeSearchPopup.SelectedEmployee != null)
                {
                    txtEmployee.Text = employeeSearchPopup.SelectedEmployee.EmployeeName;
                    // SelectedEmployeeName 바인딩 속성도 업데이트
                    SelectedEmployeeName = employeeSearchPopup.SelectedEmployee.EmployeeName;
                }
            }
        }

        // '등록' 버튼 클릭 이벤트 핸들러
        private void AddEmployee_Click(object sender, RoutedEventArgs e)
        {
            EmployeeCrudWindow crudWindow = new EmployeeCrudWindow(null);
            if (crudWindow.ShowDialog() == true)
            {
                // 등록/수정/삭제 작업 후 메인 화면의 목록을 새로고침
                LoadEmployees();
            }
        }
        // 데이터 그리드 더블클릭으로 수정 이벤트 핸들러
        private void EditEmployee_MouseDoubleClick(object sender, RoutedEventArgs e)
        {
            var selector = dgEmployees.SelectedItem;
            if (selector is Employee selectedEmployee)
            {
                EmployeeCrudWindow crudWindow = new EmployeeCrudWindow(selectedEmployee);
                if (crudWindow.ShowDialog() == true)
                {
                    // 등록/수정/삭제 작업 후 메인 화면의 목록을 새로고침
                    LoadEmployees();
                }
            }
        }

    }
}
