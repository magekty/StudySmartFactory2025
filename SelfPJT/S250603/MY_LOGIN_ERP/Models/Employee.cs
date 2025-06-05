using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

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
        public string Status { get; set; } // 재직/퇴직구분
        public string EmployeeType { get; set; } // 사원구분
        public string AddressType { get; set; } // 주소지 종류
        public string PhoneNumber { get; set; }
        public string RoadAddress { get; set; }
        public string JibunAddress { get; set; }
        public string Email { get; set; }
        // 추가된 컬럼 (필요 시 주석 해제)
        public string Gender { get; set; }
        public DateTime? BirthDate { get; set; }
        public string MaritalStatus { get; set; }
        public string Nationality { get; set; }
        public DateTime? HireDate { get; set; } // 입사일

        public ObservableCollection<string> Genders { get; set; }
        private string _selectedGender;
        public string SelectedGender
        {
            get => _selectedGender;
            set
            {
                _selectedGender = value;
                OnPropertyChanged(nameof(SelectedGender));
            }
        }

        public event PropertyChangedEventHandler PropertyChanged;
        protected void OnPropertyChanged(string name) =>
    PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(name));
    }
}
