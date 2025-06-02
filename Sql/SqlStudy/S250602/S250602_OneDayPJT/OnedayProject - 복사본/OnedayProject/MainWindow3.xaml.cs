using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
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
using MySql.Data.MySqlClient;

namespace OnedayProject
{
    /// <summary>
    /// MainWindow3.xaml에 대한 상호 작용 논리
    /// </summary>
    public partial class MainWindow3 : Window
    {
        private int selectedTableId;
        private int total = 0;
        private Dictionary<string, (int Price, int Quantity, TextBlock Block)> items = new();
        public MainWindow3(int tabelID)
        {
            InitializeComponent();
            selectedTableId = tabelID;
        }
        private void AddOrUpdateItem(string name, int price)
        {
            total += price;
            txtResult.Text = total.ToString("N0");
            UpdateTotalDisplay();

            if (items.ContainsKey(name))
            {
                var entry = items[name];
                entry.Quantity += 1;
                entry.Block.Text = $"{name} - {price:N0}원 x {entry.Quantity} = {price * entry.Quantity:N0}원";
                items[name] = entry;
            }
            else
            {
                var block = new TextBlock
                {
                    Text = $"{name} - {price:N0}원 x 1 = {price:N0}원",
                    FontSize = 18,
                    Margin = new Thickness(2)
                };
                itemListPanel.Children.Add(block);
                items[name] = (price, 1, block);
            }
        }

        private void UpdateTotalDisplay()
        {
            txtTotalDisplay.Text = $"총합: {total:N0}원";
        }

        // 버튼 핸들러 그대로 유지
        private void btn_ClickCoke(object sender, RoutedEventArgs e) => AddOrUpdateItem("콜라", 1000);
        private void btn_ClickSprite(object sender, RoutedEventArgs e) => AddOrUpdateItem("사이다", 1000);
        private void btn_ClickFanta(object sender, RoutedEventArgs e) => AddOrUpdateItem("환타", 1000);

        private void btn_ClickCheesburger(object sender, RoutedEventArgs e) => AddOrUpdateItem("치즈버거", 5000);
        private void btn_ClickBulgogiburger(object sender, RoutedEventArgs e) => AddOrUpdateItem("불고기버거", 6000);
        private void btn_ClickChieckenberger(object sender, RoutedEventArgs e) => AddOrUpdateItem("치킨버거", 6500);

        private void btn_ClickPotato(object sender, RoutedEventArgs e) => AddOrUpdateItem("감자튀김", 2500);
        private void btn_ClickCheeseStick(object sender, RoutedEventArgs e) => AddOrUpdateItem("치즈스틱", 1000);
        private void btn_ClickChickenNuggets(object sender, RoutedEventArgs e) => AddOrUpdateItem("치킨너겟", 3000);

        private void Dot_ClickSource(object sender, RoutedEventArgs e) => AddOrUpdateItem("소스추가", 500);
        private void btn_ClickSeasoning(object sender, RoutedEventArgs e) => AddOrUpdateItem("시즈닝추가", 1000);

        private void btn_ClickClear(object sender, RoutedEventArgs e)
        {
            total = 0;
            txtResult.Text = "0";
            txtTotalDisplay.Text = "총합: 0원";
            itemListPanel.Children.Clear();
            items.Clear();
        }

        private void btn_ConfirmOrder_Click(object sender, RoutedEventArgs e)
        {
            int tableId = selectedTableId; // 전달받은 테이블 ID 사용
            string connStr = "server=localhost;user=root;password=1121;database=restaurant;";
            try
            {
                using (var conn = new MySqlConnection(connStr))
                {
                    conn.Open();

                    // 1. orders 테이블에 주문 생성
                    string insertOrder = "INSERT INTO orders (table_id) VALUES (@table_id)";
                    var orderCmd = new MySqlCommand(insertOrder, conn);
                    orderCmd.Parameters.AddWithValue("@table_id", tableId);
                    orderCmd.ExecuteNonQuery();

                    long orderId = orderCmd.LastInsertedId; // 생성된 order_id

                    // 2. 각 메뉴를 order_items에 insert
                    foreach (var kvp in items)
                    {
                        string name = kvp.Key;
                        int quantity = kvp.Value.Quantity;
                        int price = kvp.Value.Price;

                        // 메뉴 ID 조회
                        string getMenuId = "SELECT menu_id FROM menu WHERE name = @name";
                        var menuCmd = new MySqlCommand(getMenuId, conn);
                        menuCmd.Parameters.AddWithValue("@name", name);
                        object? result = menuCmd.ExecuteScalar();
                        if (result == null)
                        {
                            MessageBox.Show($"'{name}' 메뉴가 menu 테이블에 없습니다.");
                            continue;
                        }

                        int menuId = Convert.ToInt32(result);

                        // order_items insert
                        string insertItem = @"
                    INSERT INTO order_items (order_id, menu_id, quantity, price)
                    VALUES (@order_id, @menu_id, @quantity, @price)";
                        var itemCmd = new MySqlCommand(insertItem, conn);
                        itemCmd.Parameters.AddWithValue("@order_id", orderId);
                        itemCmd.Parameters.AddWithValue("@menu_id", menuId);
                        itemCmd.Parameters.AddWithValue("@quantity", quantity);
                        itemCmd.Parameters.AddWithValue("@price", price);
                        itemCmd.ExecuteNonQuery();
                    }

                    MessageBox.Show("주문이 DB에 저장되었습니다.");

                    MainWindow4 window = new MainWindow4(selectedTableId, total);
                    window.Show();

                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("에러 발생: " + ex.Message);
            }
        }
    }
}