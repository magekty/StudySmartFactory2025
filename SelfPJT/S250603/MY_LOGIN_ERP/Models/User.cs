using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MY_LOGIN_ERP.Models
{
    public class User
    {
        public int userid { get; set; }
        public string password { get; set; }
        public string username { get; set; }
        public string email { get; set; }

        // 기타 필요한 속성
    }
}
