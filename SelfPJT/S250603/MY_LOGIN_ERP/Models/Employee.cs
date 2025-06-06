using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Linq;
using System.Runtime.CompilerServices;
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
        public string PhoneNumber { get; set; }
        public string RoadAddress { get; set; }
        public string JibunAddress { get; set; }
        public string Email { get; set; }
        public DateTime? BirthDate { get; set; }
        public string Nationality { get; set; }
        public DateTime? HireDate { get; set; } // 입사일

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
            set => SetProperty(ref _selectedAddress, value, AddressType);
        }

        private string _selectedEmployee;
        public string EmployeeType
        {
            get => _selectedEmployee;
            set => SetProperty(ref _selectedEmployee, value, EmployeeType);
        }
        private string _selectedStatus;
        public string Status
        {
            get => _selectedStatus;
            set => SetProperty(ref _selectedStatus, value, Status);
        }
        private string _maritalStatus;
        public string MaritalStatus
        {
            get => _maritalStatus;
            set => SetProperty(ref _maritalStatus, value, MaritalStatus);
        }
        private string _gender;
        public string Gender
        {
            get => _gender;
            set => SetProperty(ref _gender, value, Gender);
        }

        /*protected void OnPropertyChanged(string name)
            => PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(name));*/
        protected bool SetProperty<T>(ref T storage, T value, [CallerMemberName] string propertyName = null)
        {
            if (EqualityComparer<T>.Default.Equals(storage, value)) return false;
            storage = value;
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
            return true;
        }
    }
}
