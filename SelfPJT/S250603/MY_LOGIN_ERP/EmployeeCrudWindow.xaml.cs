// EmployeeCrudWindow.xaml.cs
using MY_LOGIN_ERP.DataAccess;
using MY_LOGIN_ERP.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input; // KeyUp 이벤트를 위해

namespace MY_LOGIN_ERP
{
    /// <summary>
    /// EmployeeCrudWindow.xaml에 대한 상호 작용 논리
    /// </summary>
    public partial class EmployeeCrudWindow : Window
    {
        private MySqlDataAccess _dataAccess;
        public Employee CurrentEmployee { get; set; } // 현재 등록/수정 대상 사원
        private bool _isEditMode = false; // 수정 모드 여부 플래그
        List<Employee> employees = null;
        private bool _isFirstEditMode = false;
        // INotifyPropertyChanged 구현
        public event PropertyChangedEventHandler PropertyChanged;

        private ComboBoxItem _selectedAddress;
        public ComboBoxItem SelectedAddressType
        {
            get => _selectedAddress;
            set
            {
                if (_selectedAddress != value)
                {
                    _selectedAddress = value;
                    OnPropertyChanged(); // UI에 속성 변경을 알림
                }
            }
        }
        private ComboBoxItem _selectedEmployee;
        public ComboBoxItem SelectedEmployeeType
        {
            get => _selectedEmployee;
            set
            {
                if (_selectedEmployee != value)
                {
                    _selectedEmployee = value;
                    OnPropertyChanged(); // UI에 속성 변경을 알림
                }
            }
        }
        private ComboBoxItem _selectedStatus;
        public ComboBoxItem SelectedStatus
        {
            get => _selectedStatus;
            set
            {
                if (_selectedStatus != value)
                {
                    _selectedStatus = value;
                    OnPropertyChanged(); // UI에 속성 변경을 알림
                    // 선택된 값이 변경될 때 추가적인 로직을 여기에 구현
                    // 예를 들어, 데이터 저장 버튼 활성화/비활성화 등
                }
            }
        }
        private ComboBoxItem _maritalStatus;
        public ComboBoxItem MaritalStatus
        {
            get => _maritalStatus;
            set
            {
                if (_maritalStatus != value)
                {
                    _maritalStatus = value;
                    OnPropertyChanged(); // UI에 속성 변경을 알림
                    // 선택된 값이 변경될 때 추가적인 로직을 여기에 구현
                    // 예를 들어, 데이터 저장 버튼 활성화/비활성화 등
                }
            }
        }
        private ComboBoxItem _gender;
        public ComboBoxItem Gender
        {
            get => _gender;
            set
            {
                if (_gender != value)
                {
                    _gender = value;
                    OnPropertyChanged(); // UI에 속성 변경을 알림
                    // 선택된 값이 변경될 때 추가적인 로직을 여기에 구현
                    // 예를 들어, 데이터 저장 버튼 활성화/비활성화 등
                }
            }
        }


        
            

        public EmployeeCrudWindow(Employee employee)
        {
            InitializeComponent();
            _dataAccess = new MySqlDataAccess();
            this.Owner = Application.Current.MainWindow;
            this.DataContext = this; // DataContext 설정
            CurrentEmployee = new Employee(); // 새 사원 객체 초기화
            if (employee is null)
            {
                SetMode(false); // 초기에는 등록 모드
            }
            else
            {
                _isFirstEditMode = true;
                employees = _dataAccess.GetEmployees(employeeId: employee.EmployeeID, employeeName: employee.EmployeeName);
                //MessageBox.Show(employees.First().ToString());
                SetMode(true); // 데이터 넘어오면 수정 모드
            }
        }

        // 팝업 로드 시 초기 상태 설정
        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            if(_isFirstEditMode) LoadEmployeeData(employees.First());

            // 콤보박스 초기값 "선택안함"으로 설정
            cbStatus.SelectedIndex = 0;
            cbEmployeeType.SelectedIndex = 0;
            cbAddressType.SelectedIndex = 0;
            cbGender.SelectedIndex = 0;
            cbMaritalStatus.SelectedIndex = 0;
        }

        // 등록/수정 모드 설정 및 UI 제어
        private void SetMode(bool isEdit)
        {
            _isEditMode = isEdit;
            if (isEdit)
            {
                tblTitle.Text = "사원 정보 수정/삭제";
                btnRegister.IsEnabled = false; // 수정 모드에서는 등록 비활성화
                btnUpdate.IsEnabled = true;    // 수정 활성화
                btnDelete.IsEnabled = true;    // 삭제 활성화
                txtEmployeeID.IsReadOnly = true; // 사번은 수정 불가
            }
            else
            {
                tblTitle.Text = "신규 사원 등록";
                btnRegister.IsEnabled = true;  // 등록 활성화
                btnUpdate.IsEnabled = false;   // 등록 모드에서는 수정 비활성화
                btnDelete.IsEnabled = false;   // 등록 모드에서는 삭제 비활성화
                txtEmployeeID.IsReadOnly = false; // 사번 입력 가능
            }
        }

        // 입력 필드를 초기화하는 메서드
        private void ClearForm()
        {
            CurrentEmployee = new Employee(); // 새 Employee 객체로 초기화
            this.DataContext = null; // DataContext를 null로 설정하여 바인딩을 끊고
            this.DataContext = this; // 다시 설정하여 모든 필드를 초기화 (가장 간단한 방법)

            // 콤보박스 초기값 "선택안함"으로 설정
            cbStatus.SelectedIndex = 0;
            cbEmployeeType.SelectedIndex = 0;
            cbAddressType.SelectedIndex = 0;
            cbGender.SelectedIndex = 0;
            cbMaritalStatus.SelectedIndex = 0;

            txtSearchEmployeeID.Clear();
            txtSearchEmployeeName.Clear();

            SetMode(false); // 등록 모드로 전환
        }

        // 사원 검색 (수정/삭제 대상 사원 선택)
        private void SearchEmployeeForEdit_Click(object sender, RoutedEventArgs e)
        {
            int? searchId = null;
            if (int.TryParse(txtSearchEmployeeID.Text, out int id))
            {
                searchId = id;
            }
            string searchName = txtSearchEmployeeName.Text;

            if (!searchId.HasValue && string.IsNullOrWhiteSpace(searchName))
            {
                MessageBox.Show("사번 또는 사원명을 입력하여 검색해주세요.", "검색 필요", MessageBoxButton.OK, MessageBoxImage.Information);
                return;
            }

            // 사원 조회 팝업을 활용하거나, 직접 ID와 이름으로 조회
            // 여기서는 GetEmployees를 활용하여 검색
            var employees = _dataAccess.GetEmployees(employeeId: searchId, employeeName: searchName);

            if (employees.Count == 0)
            {
                MessageBox.Show("해당하는 사원이 없습니다.", "검색 결과 없음", MessageBoxButton.OK, MessageBoxImage.Information);
                ClearForm(); // 검색 결과가 없으면 폼 초기화
                return;
            }
            else if (employees.Count > 1)
            {
                // 여러 명 검색될 경우, 사원 검색 팝업(EmployeeSearchPopup)을 띄워서 선택하게 함
                EmployeeSearchPopup popup = new EmployeeSearchPopup();
                popup.txtPopupEmployeeName.Text = searchName; // 검색어 전달
                popup.Window_Loaded(null, null); // 팝업 데이터 로드

                if (popup.ShowDialog() == true)
                {
                    if (popup.SelectedEmployee != null)
                    {
                        LoadEmployeeData(popup.SelectedEmployee);
                    }
                }
            }
            else // 한 명만 검색된 경우 바로 로드
            {
                LoadEmployeeData(employees.First());
            }
        }

        // 검색된 사원 정보를 폼에 로드
        public void LoadEmployeeData(Employee employee)
        {
            CurrentEmployee = employee;
            this.DataContext = null; // DataContext를 null로 설정하여 바인딩을 끊고
            this.DataContext = this; // 다시 설정하여 새 데이터로 바인딩

            txtEmployeeID.Text = CurrentEmployee.EmployeeID.ToString();
            txtEmployeeName.Text = CurrentEmployee.EmployeeName;
            txtDepartment.Text = CurrentEmployee.Department;
            txtWorkDepartment.Text = CurrentEmployee.WorkDepartment;
            txtPosition.Text = CurrentEmployee.Position;
            txtJobRank.Text = CurrentEmployee.JobRank;
            dpAppointmentDate.SelectedDate = CurrentEmployee.AppointmentDate;
            txtPhoneNumber.Text = CurrentEmployee.PhoneNumber;
            txtRoadAddress.Text = CurrentEmployee.RoadAddress;
            txtJibunAddress.Text = CurrentEmployee.JibunAddress;
            txtEmail.Text = CurrentEmployee.Email;
            dpBirthDate.SelectedDate = CurrentEmployee.BirthDate;
            txtNationality.Text = CurrentEmployee.Nationality;
            dpHireDate.SelectedDate = CurrentEmployee.HireDate;



            // 콤보박스 선택 항목 강제 업데이트 (바인딩만으로는 초기 설정이 안될 수 있음)
/*            cbStatus.SelectedItem = cbStatus.Items.OfType<ComboBoxItem>().FirstOrDefault(item => item.Content.ToString() == employee.Status);
            cbEmployeeType.SelectedItem = cbEmployeeType.Items.OfType<ComboBoxItem>().FirstOrDefault(item => item.Content.ToString() == employee.EmployeeType);
            cbAddressType.SelectedItem = cbAddressType.Items.OfType<ComboBoxItem>().FirstOrDefault(item => item.Content.ToString() == employee.AddressType);
            cbGender.SelectedItem = cbGender.Items.OfType<ComboBoxItem>().FirstOrDefault(item => item.Content.ToString() == employee.Gender);
            cbMaritalStatus.SelectedItem = cbMaritalStatus.Items.OfType<ComboBoxItem>().FirstOrDefault(item => item.Content.ToString() == employee.MaritalStatus);*/

            SetMode(true); // 수정 모드로 전환
        }

        // 사원 등록
        private void Register_Click(object sender, RoutedEventArgs e)
        {
            if (!ValidateInput()) return;

            // 사번 중복 확인
            if (_dataAccess.GetEmployeeById(CurrentEmployee.EmployeeID) != null)
            {
                MessageBox.Show("이미 존재하는 사번입니다. 다른 사번을 입력해주세요.", "등록 오류", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }
            SetCurrentEmployeeByFieldData();

            // 콤보박스 선택 값 반영
            CurrentEmployee.Status = ((ComboBoxItem)cbStatus.SelectedItem).Content.ToString();
            CurrentEmployee.EmployeeType = ((ComboBoxItem)cbEmployeeType.SelectedItem).Content.ToString();
            CurrentEmployee.AddressType = ((ComboBoxItem)cbAddressType.SelectedItem).Content.ToString();
            CurrentEmployee.Gender = ((ComboBoxItem)cbGender.SelectedItem).Content.ToString();
            CurrentEmployee.MaritalStatus = ((ComboBoxItem)cbMaritalStatus.SelectedItem).Content.ToString();

            if (_dataAccess.AddEmployee(CurrentEmployee))
            {
                MessageBox.Show("사원이 성공적으로 등록되었습니다.", "등록 성공", MessageBoxButton.OK, MessageBoxImage.Information);
                this.DialogResult = true; // 메인 윈도우에 변경 사항을 알림
                this.Close();
            }
            else
            {
                MessageBox.Show("사원 등록에 실패했습니다. 로그를 확인하세요.", "등록 실패", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        // 사원 수정
        private void Update_Click(object sender, RoutedEventArgs e)
        {
            if (!ValidateInput()) return;
            SetCurrentEmployeeByFieldData();



            if (_dataAccess.UpdateEmployee(CurrentEmployee))
            {
                MessageBox.Show("사원 정보가 성공적으로 수정되었습니다.", "수정 성공", MessageBoxButton.OK, MessageBoxImage.Information);
                this.DialogResult = true; // 메인 윈도우에 변경 사항을 알림
                this.Close();
            }
            else
            {
                MessageBox.Show("사원 정보 수정에 실패했습니다. 로그를 확인하세요.", "수정 실패", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        // 사원 삭제
        private void Delete_Click(object sender, RoutedEventArgs e)
        {
            if (CurrentEmployee.EmployeeID == 0)
            {
                MessageBox.Show("삭제할 사원을 먼저 검색하여 선택해주세요.", "삭제 오류", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }

            MessageBoxResult result = MessageBox.Show(
                $"사번: {CurrentEmployee.EmployeeID}, 사원명: {CurrentEmployee.EmployeeName} 사원을 정말로 삭제하시겠습니까?\n이 작업은 되돌릴 수 없습니다.",
                "사원 삭제 확인",
                MessageBoxButton.YesNo,
                MessageBoxImage.Question);

            if (result == MessageBoxResult.Yes)
            {
                if (_dataAccess.DeleteEmployee(CurrentEmployee.EmployeeID))
                {
                    MessageBox.Show("사원이 성공적으로 삭제되었습니다.", "삭제 성공", MessageBoxButton.OK, MessageBoxImage.Information);
                    this.DialogResult = true; // 메인 윈도우에 변경 사항을 알림
                    this.Close();
                }
                else
                {
                    MessageBox.Show("사원 삭제에 실패했습니다. 로그를 확인하세요.", "삭제 실패", MessageBoxButton.OK, MessageBoxImage.Error);
                }
            }
        }

        // 폼 초기화 및 검색 필드 초기화
        private void ClearSearchAndForm_Click(object sender, RoutedEventArgs e)
        {
            ClearForm();
        }

        // 취소 버튼 (창 닫기)
        private void Cancel_Click(object sender, RoutedEventArgs e)
        {
            this.DialogResult = false;
            this.Close();
        }

        // 입력 유효성 검사
        private bool ValidateInput()
        {
            int checkN = 0;
            
            if (!(int.TryParse(txtEmployeeID.Text, out checkN)) && checkN == 0)
            {
                MessageBox.Show("사번을 입력해주세요.", "입력 오류", MessageBoxButton.OK, MessageBoxImage.Warning);
                txtEmployeeID.Focus();
                return false;
            }
            if (string.IsNullOrWhiteSpace(txtEmployeeName.Text))
            {
                MessageBox.Show("사원명을 입력해주세요.", "입력 오류", MessageBoxButton.OK, MessageBoxImage.Warning);
                txtEmployeeName.Focus();
                return false;
            }

            // Add other required field validations as needed
            // 예: Department, Status 등 필수 필드 검사

            // 콤보박스 "선택안함" 검사 (필수 항목인 경우)
            if (((ComboBoxItem)cbStatus.SelectedItem).Content.ToString() == "선택안함")
            {
                MessageBox.Show("재직/퇴직구분을 선택해주세요.", "입력 오류", MessageBoxButton.OK, MessageBoxImage.Warning);
                cbStatus.Focus();
                return false;
            }
            // 다른 콤보박스도 필요하다면 추가

            return true;
        }

        private void SetCurrentEmployeeByFieldData()
        {
            CurrentEmployee.EmployeeID = int.Parse(txtEmployeeID.Text);
            CurrentEmployee.EmployeeName = txtEmployeeName.Text;
            CurrentEmployee.Department = txtDepartment.Text;
            CurrentEmployee.WorkDepartment = txtWorkDepartment.Text;
            CurrentEmployee.Position = txtPosition.Text;
            CurrentEmployee.JobRank = txtJobRank.Text;
            CurrentEmployee.AppointmentDate = dpAppointmentDate.SelectedDate;
            CurrentEmployee.PhoneNumber = txtPhoneNumber.Text;
            CurrentEmployee.RoadAddress = txtRoadAddress.Text;
            CurrentEmployee.JibunAddress = txtJibunAddress.Text;
            CurrentEmployee.Email = txtEmail.Text;
            CurrentEmployee.BirthDate = dpBirthDate.SelectedDate;
            CurrentEmployee.Nationality = txtNationality.Text;
            CurrentEmployee.HireDate = dpHireDate.SelectedDate;

            // 콤보박스 선택 값 반영
            CurrentEmployee.Status = ((ComboBoxItem)cbStatus.SelectedItem).Content.ToString();
            CurrentEmployee.EmployeeType = ((ComboBoxItem)cbEmployeeType.SelectedItem).Content.ToString();
            CurrentEmployee.AddressType = ((ComboBoxItem)cbAddressType.SelectedItem).Content.ToString();
            CurrentEmployee.Gender = ((ComboBoxItem)cbGender.SelectedItem).Content.ToString();
            CurrentEmployee.MaritalStatus = ((ComboBoxItem)cbMaritalStatus.SelectedItem).Content.ToString();
        }
        protected void OnPropertyChanged([CallerMemberName] string propertyName = null)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }
}
