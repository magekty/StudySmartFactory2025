using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MySqlConnector;
namespace _250530TestMysqlConnector
{
    internal class Program
    {
        static void Main(string[] args)
        {

            ExecuteQuery();

        }

        static void ExecuteQuery()
        {
            string connectionString = "Server=localhost;Database=mydb;Uid=root;Pwd=1121;";

            using (var connection = new MySqlConnection(connectionString))
            {
                connection.Open();

                // INSERT 쿼리 실행
                string insertQuery = "INSERT INTO mytable (id, name, age) VALUES (2, 'min', 20)";
                using (var command = new MySqlCommand(insertQuery, connection))
                {
                    //command.Parameters.AddWithValue("@name", "John Doe");
                    //command.Parameters.AddWithValue("@email", "john.doe@example.com");
                    command.ExecuteNonQuery();
                }

                // SELECT 쿼리 실행
                string selectQuery = "SELECT * FROM mytable";
                using (var command = new MySqlCommand(selectQuery, connection))
                {
                    using (var reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            Console.WriteLine($"ID: {reader["id"]}, Name: {reader["name"]}, Age: {reader["age"]}");
                        }
                    }
                }

                connection.Close();
            }
        }
    }
}
