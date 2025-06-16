using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace S250616_OOP_GUI_State
{
    public partial class Form1 : Form
    {
        private UserContext userContext = new UserContext();
        public Form1()
        {
            InitializeComponent();
        }

        private void btnAction_Click(object sender, EventArgs e)
        {
            userContext.Request();
            UpdateUI();
        }

        private void UpdateUI()
        {
            IbIStatus.Text = userContext.GetStatusText();
            btnAction.Text = userContext.GetButtonText();

        }
    }

    interface IState
    {
        void handle(UserContext context);
        string StatusText { get; }
        string ButtonText { get; }
    }
    class LoginState : IState
    {
        public void handle(UserContext context)
        {
            context.SetState(new LogoutState());
        }
        public string StatusText => "현재 상태: 로그인";
        public string ButtonText => "로그아웃";
    }
    class LogoutState : IState
    {
        public void handle(UserContext context)
        {
            context.SetState(new LoginState());
        }
        public string StatusText => "현재 상태: 로그아웃";
        public string ButtonText => "로그인";
    }
    class UserContext
    {
        private IState stateNow;
        public UserContext(){ stateNow = new LogoutState(); }
        public void SetState(IState state) { stateNow = state; }
        public void Request() { stateNow.handle(this); }
        public string GetStatusText() => stateNow.StatusText;
        public string GetButtonText() => stateNow.ButtonText;

    }

}
