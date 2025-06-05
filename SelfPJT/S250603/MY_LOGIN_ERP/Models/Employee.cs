using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Controls;

namespace MY_LOGIN_ERP.Models
{
    public class Employee : INotifyPropertyChanged
    {
        public int EmployeeID { get; set; }
        public string EmployeeName { get; set; }
        public string Department { get; set; }
        public string WorkDepartment { get; set; }
        public string Position { get; set; }
        public string JobRank { get; set; }
        public DateTime? AppointmentDate { get; set; } // Nullable DateTime
        //public string Status { get; set; } // 재직/퇴직구분
        //public string EmployeeType { get; set; } // 사원구분
        //public string AddressType { get; set; } // 주소지 종류
        public string PhoneNumber { get; set; }
        public string RoadAddress { get; set; }
        public string JibunAddress { get; set; }
        public string Email { get; set; }
        public DateTime? BirthDate { get; set; }
        public string Nationality { get; set; }
        public DateTime? HireDate { get; set; } // 입사일
        // 추가된 컬럼 (필요 시 주석 해제)
        //public string Gender { get; set; }
        //public string MaritalStatus { get; set; }
        public event PropertyChangedEventHandler PropertyChanged;

        public ObservableCollection<string> Maritals { get; set; } = new ObservableCollection<string>
        {
            "선택안함", "미혼", "기혼", "이혼"
        };
        
        public ObservableCollection<string> Genders { get; set; } = new ObservableCollection<string>
        {
            "선택안함", "남", "여"
        };
        public ObservableCollection<string> AddressTypes { get; set; } = new ObservableCollection<string>
        {
            "선택안함", "본적", "주민등록상거주지","실거주지","근무지 주소"
        };
        public ObservableCollection<string> EmployeeTypes { get; set; } = new ObservableCollection<string>
        {
            "선택안함", "상임", "비상임","계약직상임","계약직비상임"
        };
        public ObservableCollection<string> Statuss { get; set; } = new ObservableCollection<string>
        {
            "선택안함", "재직자", "퇴직자"
        };

        private string _selectedAddress;
        public string AddressType
        {
            get => _selectedAddress;
            set
            {
                if (_selectedAddress != value)
                {
                    _selectedAddress = value;
                    OnPropertyChanged(nameof(AddressType)); // UI에 속성 변경을 알림
                }
            }
        }

        private string _selectedEmployee;
        public string EmployeeType
        {
            get => _selectedEmployee;
            set
            {
                if (_selectedEmployee != value)
                {
                    _selectedEmployee = value;
                    OnPropertyChanged(nameof(EmployeeType)); // UI에 속성 변경을 알림
                }
            }
        }
        private string _selectedStatus;
        public string Status
        {
            get => _selectedStatus;
            set
            {
                if (_selectedStatus != value)
                {
                    _selectedStatus = value;
                    OnPropertyChanged(nameof(Status)); // UI에 속성 변경을 알림
                    // 선택된 값이 변경될 때 추가적인 로직을 여기에 구현
                    // 예를 들어, 데이터 저장 버튼 활성화/비활성화 등
                }
            }
        }
        private string _maritalStatus;
        public string MaritalStatus
        {
            get => _maritalStatus;
            set
            {
                if (_maritalStatus != value)
                {
                    _maritalStatus = value;
                    OnPropertyChanged(nameof(MaritalStatus)); // UI에 속성 변경을 알림
                    // 선택된 값이 변경될 때 추가적인 로직을 여기에 구현
                    // 예를 들어, 데이터 저장 버튼 활성화/비활성화 등
                }
            }
        }
        private string _gender;
        public string Gender
        {
            get => _gender;
            set
            {
                if (_gender != value)
                {
                    _gender = value;
                    OnPropertyChanged(nameof(Gender)); // UI에 속성 변경을 알림
                    // 선택된 값이 변경될 때 추가적인 로직을 여기에 구현
                    // 예를 들어, 데이터 저장 버튼 활성화/비활성화 등
                }
            }
        }
        public Employee()
        {
            AddressType = "선택없음";
            EmployeeType = "선택없음";
            Status = "선택없음";
            MaritalStatus = "선택없음";
            Gender = "선택없음";
        }

        protected void OnPropertyChanged(string name)
            => PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(name));

    }
}
