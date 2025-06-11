using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;

namespace MY_LOGIN_ERP.Util
{
    public static class PasswordBoxHelper
    {
        // 바인딩될 의존성 속성
        public static readonly DependencyProperty BoundPasswordProperty =
            DependencyProperty.RegisterAttached("BoundPassword", typeof(string), typeof(PasswordBoxHelper),
                new FrameworkPropertyMetadata(string.Empty, OnBoundPasswordChanged));

        // 이전에 바인딩된 PasswordBox를 추적하는 의존성 속성
        public static readonly DependencyProperty IsUpdatingProperty =
            DependencyProperty.RegisterAttached("IsUpdating", typeof(bool), typeof(PasswordBoxHelper));

        // BoundPassword 값을 가져오는 Getter
        public static string GetBoundPassword(PasswordBox pb)
        {
            return (string)pb.GetValue(BoundPasswordProperty);
        }

        // BoundPassword 값을 설정하는 Setter
        public static void SetBoundPassword(PasswordBox pb, string value)
        {
            pb.SetValue(BoundPasswordProperty, value);
        }

        // IsUpdating 값을 가져오는 Getter
        public static bool GetIsUpdating(PasswordBox pb)
        {
            return (bool)pb.GetValue(IsUpdatingProperty);
        }

        // IsUpdating 값을 설정하는 Setter
        public static void SetIsUpdating(PasswordBox pb, bool value)
        {
            pb.SetValue(IsUpdatingProperty, value);
        }

        // BoundPassword 속성이 변경되었을 때 호출되는 콜백 메서드
        private static void OnBoundPasswordChanged(DependencyObject d, DependencyPropertyChangedEventArgs e)
        {
            PasswordBox passwordBox = d as PasswordBox;
            if (passwordBox != null)
            {
                // SetValue 메서드 호출로 인해 재귀적으로 이 메서드가 호출되는 것을 방지
                if (!GetIsUpdating(passwordBox))
                {
                    passwordBox.PasswordChanged -= OnPasswordBoxPasswordChanged; // 기존 이벤트 핸들러 제거
                    passwordBox.Password = (string)e.NewValue; // PasswordBox의 Password 속성 업데이트
                    passwordBox.PasswordChanged += OnPasswordBoxPasswordChanged; // 새 이벤트 핸들러 추가
                }
            }
        }

        // PasswordBox의 Password 속성이 변경되었을 때 호출되는 이벤트 핸들러
        private static void OnPasswordBoxPasswordChanged(object sender, RoutedEventArgs e)
        {
            PasswordBox passwordBox = sender as PasswordBox;
            if (passwordBox != null)
            {
                SetIsUpdating(passwordBox, true); // 업데이트 중임을 표시
                SetBoundPassword(passwordBox, passwordBox.Password); // 바인딩된 BoundPassword 속성 업데이트
                SetIsUpdating(passwordBox, false); // 업데이트 완료
            }
        }
    }
}
