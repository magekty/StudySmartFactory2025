using MySql.Data.MySqlClient;
using MySqlX.XDevAPI.Relational;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace OnedayProject
{
    /// <summary>
    /// MainWindow4.xaml에 대한 상호 작용 논리
    /// </summary>
    public partial class MainWindow4 : Window
    {
        private int selectedTableId;
        private int total;
        private MainWindow mainWindow;

        public MainWindow4(int tableId, int totalAmount, MainWindow mainWindow)
        {
            InitializeComponent();
            this.mainWindow = mainWindow;
            selectedTableId = tableId;
            total = totalAmount;

            txtTableId.Text = selectedTableId.ToString();
            txtTotalAmount.Text = $"{total:N0}원";
        }

        private void btnPay_Click(object sender, RoutedEventArgs e)
        {
            //string connStr = "server=localhost;user=root;password=1121;database=restaurant;"; // 김태영 메인 윈도우 통합
            try
            {
                // using (var conn = new MySqlConnection(connStr))  // 김태영 다음줄 수정
                using (var conn = new MySqlConnection(mainWindow.connStr))
                {
                    conn.Open();

                    // 1. 결제할 order_id 가져오기 (예: 현재 선택 테이블 & is_paid = false)
                    string getOrderIdQuery = "SELECT order_id FROM orders WHERE table_id = @table_id AND is_paid = FALSE LIMIT 1";
                    var getOrderCmd = new MySqlCommand(getOrderIdQuery, conn);
                    getOrderCmd.Parameters.AddWithValue("@table_id", selectedTableId); // selectedTableId는 생성자 등에서 받은 테이블 번호
                    object orderIdObj = getOrderCmd.ExecuteScalar();

                    if (orderIdObj == null)
                    {
                        MessageBox.Show("결제할 주문이 없습니다.");
                        return;
                    }

                    int orderId = Convert.ToInt32(orderIdObj);
                    // 기존 쿼리문 버전
                    /*// 2. payments 테이블에 결제 정보 INSERT
                    string insertPaymentQuery = @"
                INSERT INTO payments (order_id, total_amount) VALUES (@order_id, @total_amount)";
                    var paymentCmd = new MySqlCommand(insertPaymentQuery, conn);
                    paymentCmd.Parameters.AddWithValue("@order_id", orderId);
                    paymentCmd.Parameters.AddWithValue("@total_amount", total); // total은 주문 총액 변수
                    paymentCmd.ExecuteNonQuery();

                    // 3. orders 테이블 is_paid 업데이트
                    string updateOrderQuery = "UPDATE orders SET is_paid = TRUE WHERE order_id = @order_id";
                    var updateOrderCmd = new MySqlCommand(updateOrderQuery, conn);
                    updateOrderCmd.Parameters.AddWithValue("@order_id", orderId);
                    updateOrderCmd.ExecuteNonQuery();*/

                    // StoredProcedure 버전
                    MySqlCommand spCmd = new MySqlCommand("pay_order", conn);
                    spCmd.CommandType = CommandType.StoredProcedure;
                    spCmd.Parameters.AddWithValue("@p_order_id", orderId);
                    spCmd.Parameters.AddWithValue("@p_total_amount", total);
                    spCmd.ExecuteNonQuery();

                    MessageBox.Show("결제가 완료되었습니다.");

                    // 결제 완료 후 테이블 선택 화면으로 돌아가기
                    MainWindow main = new MainWindow();
                    main.Show();
                    this.Close();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("결제 중 오류 발생: " + ex.Message);
            }
        }
    }
};