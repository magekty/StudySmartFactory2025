﻿// DataAccess/MySqlDataAccess.cs
using MY_LOGIN_ERP.Models;
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net.Http;
using System.Text.Json;
using System.Threading.Tasks;
using System.Windows; // MessageBox를 위해 임시로 추가, 실제로는 별도 로깅 또는 예외 처리 권장


namespace MY_LOGIN_ERP.DataAccess
{
    public class MySqlDataAccess
    {
        // "your_password"를 실제 MySQL root 비밀번호로 변경하세요.
        private readonly string connectionString = "Server=localhost;Port=3306;Database=smart_factory_erp;Uid=root;Pwd=1121;";
        // ViewModel 서비스 - Java연동
        private readonly HttpClient _httpClient;
        private const string BaseUrl = "http://localhost:8080/api/users"; // 백엔드 API 기본 URL
        private const string RegUrl = "http://localhost:8080/api/users/register"; // 백엔드 API 기본 URL

        public MySqlDataAccess()
        {
            TestConnection();
            // ViewModel 서비스 - Java 연동
            _httpClient = new HttpClient();
            // 필요에 따라 기본 헤더 설정 (예: 인증 토큰)
            // _httpClient.DefaultRequestHeaders.Add("Authorization", "Bearer your_jwt_token");
        }

        private void TestConnection()  
        {
            try
            {
                using (MySqlConnection connection = new MySqlConnection(connectionString))
                {
                    connection.Open();
                    // MessageBox.Show("MySQL 데이터베이스 연결 성공!", "정보", MessageBoxButton.OK, MessageBoxImage.Information);
                }
            }
            catch (MySqlException ex)
            {
                MessageBox.Show($"MySQL 데이터베이스 연결 실패: {ex.Message}\n\n데이터베이스 설정 및 연결 문자열을 확인해주세요.", "오류", MessageBoxButton.OK, MessageBoxImage.Error);
                Environment.Exit(1);
            }
        }
        public async Task<List<User>> GetUsersAsync()   // Java 연동
        {
            try
            {
                HttpResponseMessage response = await _httpClient.GetAsync(BaseUrl);
                response.EnsureSuccessStatusCode(); // 200번대 응답이 아니면 예외 발생

                string jsonResponse = await response.Content.ReadAsStringAsync();
                // JSON 문자열을 User 객체 리스트로 역직렬화
                return JsonSerializer.Deserialize<List<User>>(jsonResponse, new JsonSerializerOptions { PropertyNameCaseInsensitive = true });
            }
            catch (HttpRequestException e)
            {
                Console.WriteLine($"Error getting users: {e.Message}");
                // 사용자에게 오류 메시지 표시
                return null; // 또는 예외를 다시 던지거나 적절히 처리
            }
        }

        public async Task<User> CreateUserAsync(User newUser)  // Java 연동
        {
            try
            {
                string jsonContent = JsonSerializer.Serialize(newUser);
                StringContent content = new StringContent(jsonContent, System.Text.Encoding.UTF8, "application/json");

                HttpResponseMessage response = await _httpClient.PostAsync(RegUrl, content);
                response.EnsureSuccessStatusCode();

                string jsonResponse = await response.Content.ReadAsStringAsync();
                return JsonSerializer.Deserialize<User>(jsonResponse, new JsonSerializerOptions { PropertyNameCaseInsensitive = true });
            }
            catch (HttpRequestException e)
            {
                Console.WriteLine($"Error creating user: {e.Message}");
                return null;
            }
        }

        // 모든 사원 또는 조건에 맞는 사원을 조회하는 메서드 (기존과 동일)
        public List<Employee> GetEmployees(
            string department = null,
            string employeeName = null,
            string addressType = null,
            string employeeType = null,
            string status = null,
            int? employeeId = null) // 사원 ID로도 검색 가능하도록 추가
        {
            List<Employee> employees = new List<Employee>();
            string query = "SELECT * FROM tbl_employees WHERE 1=1";
            if (employeeId.HasValue)
                query += " AND EmployeeID = @EmployeeID";
            if (!string.IsNullOrEmpty(department))
                query += " AND Department LIKE @Department";
            if (!string.IsNullOrEmpty(employeeName))
                query += " AND EmployeeName LIKE @EmployeeName";
            if (!string.IsNullOrEmpty(addressType) && addressType != "선택안함")
                query += $" AND AddressType = @AddressType";
            if (!string.IsNullOrEmpty(employeeType) && employeeType != "선택안함")
                query += $" AND EmployeeType = @EmployeeType";
            if (!string.IsNullOrEmpty(status) && status != "선택안함")
                query += $" AND Status = @Status";

            try
            {
                using (MySqlConnection connection = new MySqlConnection(connectionString))
                {
                    MySqlCommand command = new MySqlCommand(query, connection);
                    if (employeeId.HasValue)
                        command.Parameters.AddWithValue("@EmployeeID", employeeId.Value);
                    if (!string.IsNullOrEmpty(department))
                        command.Parameters.AddWithValue("@Department", $"%{department}%");
                    if (!string.IsNullOrEmpty(employeeName))
                        command.Parameters.AddWithValue("@EmployeeName", $"%{employeeName}%");
                    if (!string.IsNullOrEmpty(addressType) && addressType != "선택안함")
                        command.Parameters.AddWithValue("@AddressType", addressType);
                    if (!string.IsNullOrEmpty(employeeType) && employeeType != "선택안함")
                        command.Parameters.AddWithValue("@EmployeeType", employeeType);
                    if (!string.IsNullOrEmpty(status) && status != "선택안함")
                        command.Parameters.AddWithValue("@Status", status);

                    connection.Open();

                    using (MySqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            employees.Add(new Employee
                            {
                                EmployeeID = reader.GetInt32("EmployeeID"),
                                EmployeeName = reader.GetString("EmployeeName"),
                                Department = reader.IsDBNull(2) ? null : reader.GetString("Department"),
                                WorkDepartment = reader.IsDBNull(3) ? null : reader.GetString("WorkDepartment"),
                                Position = reader.IsDBNull(4) ? null : reader.GetString("Position"),
                                JobRank = reader.IsDBNull(5) ? null : reader.GetString("JobRank"),
                                AppointmentDate = reader.IsDBNull(6) ? (DateTime?)null : reader.GetDateTime("AppointmentDate"),
                                Status = reader.IsDBNull(7) ? "선택안함" : reader.GetString("Status"),
                                EmployeeType = reader.IsDBNull(8) ? "선택안함" : reader.GetString("EmployeeType"),
                                AddressType = reader.IsDBNull(9) ? "선택안함" : reader.GetString("AddressType"),
                                PhoneNumber = reader.IsDBNull(10) ? null : reader.GetString("PhoneNumber"),
                                RoadAddress = reader.IsDBNull(11) ? null : reader.GetString("RoadAddress"),
                                JibunAddress = reader.IsDBNull(12) ? null : reader.GetString("JibunAddress"),
                                Email = reader.IsDBNull(13) ? null : reader.GetString("Email"),
                                // 추가된 컬럼들 (데이터베이스에 컬럼이 없으면 에러 발생, 주석 해제 시 DB 스키마 업데이트 필수)
                                Gender = reader.IsDBNull(14) ? "선택안함" : reader.GetString("Gender"),
                                BirthDate = reader.IsDBNull(15) ? (DateTime?)null : reader.GetDateTime("BirthDate"),
                                MaritalStatus = reader.IsDBNull(16) ? "선택안함" : reader.GetString("MaritalStatus"),
                                Nationality = reader.IsDBNull(17) ? null : reader.GetString("Nationality"),
                                HireDate = reader.IsDBNull(18) ? (DateTime?)null : reader.GetDateTime("HireDate")
                            });
                        }
                    }
                }
            }
            catch (MySqlException ex)
            {
                MessageBox.Show($"사원 정보 조회 중 오류 발생: {ex.Message}", "데이터베이스 오류", MessageBoxButton.OK, MessageBoxImage.Error);
            }
            return employees;
        }

        // 사원 ID로 사원 정보를 가져오는 메서드 (기존과 동일)
        public Employee GetEmployeeById(int employeeId)
        {
            // GetEmployees 메서드를 재활용
            return GetEmployees(employeeId: employeeId).FirstOrDefault();
        }

        // 새 사원 등록 메서드
        public bool AddEmployee(Employee employee)
        {
            string query = @"INSERT INTO tbl_employees (
                                EmployeeID, EmployeeName, Department, WorkDepartment, Position, JobRank,
                                AppointmentDate, Status, EmployeeType, AddressType, PhoneNumber,
                                RoadAddress, JibunAddress, Email, Gender, BirthDate, MaritalStatus, Nationality, HireDate
                            ) VALUES (
                                @EmployeeID, @EmployeeName, @Department, @WorkDepartment, @Position, @JobRank,
                                @AppointmentDate, @Status, @EmployeeType, @AddressType, @PhoneNumber,
                                @RoadAddress, @JibunAddress, @Email, @Gender, @BirthDate, @MaritalStatus, @Nationality, @HireDate
                            )";
            try
            {
                using (MySqlConnection connection = new MySqlConnection(connectionString))
                {
                    MySqlCommand command = new MySqlCommand(query, connection);
                    SetEmployeeParameters(command, employee);
                    connection.Open();
                    return command.ExecuteNonQuery() > 0;
                }
            }
            catch (MySqlException ex)
            {
                MessageBox.Show($"사원 등록 중 오류 발생: {ex.Message}", "데이터베이스 오류", MessageBoxButton.OK, MessageBoxImage.Error);
                return false;
            }
        }

        // 사원 정보 수정 메서드
        public bool UpdateEmployee(Employee employee)
        {
            string query = @"UPDATE tbl_employees SET
                                EmployeeName = @EmployeeName, Department = @Department, WorkDepartment = @WorkDepartment,
                                Position = @Position, JobRank = @JobRank, AppointmentDate = @AppointmentDate,
                                Status = @Status, EmployeeType = @EmployeeType, AddressType = @AddressType,
                                PhoneNumber = @PhoneNumber, RoadAddress = @RoadAddress, JibunAddress = @JibunAddress,
                                Email = @Email, Gender = @Gender, BirthDate = @BirthDate, MaritalStatus = @MaritalStatus,
                                Nationality = @Nationality, HireDate = @HireDate
                            WHERE EmployeeID = @EmployeeID";
            try
            {
                using (MySqlConnection connection = new MySqlConnection(connectionString))
                {
                    MySqlCommand command = new MySqlCommand(query, connection);
                    SetEmployeeParameters(command, employee);
                    connection.Open();
                    return command.ExecuteNonQuery() > 0;
                }
            }
            catch (MySqlException ex)
            {
                MessageBox.Show($"사원 수정 중 오류 발생: {ex.Message}", "데이터베이스 오류", MessageBoxButton.OK, MessageBoxImage.Error);
                return false;
            }
        }

        // 사원 삭제 메서드
        public bool DeleteEmployee(int employeeId)
        {
            string query = "DELETE FROM tbl_employees WHERE EmployeeID = @EmployeeID";
            try
            {
                using (MySqlConnection connection = new MySqlConnection(connectionString))
                {
                    MySqlCommand command = new MySqlCommand(query, connection);
                    command.Parameters.AddWithValue("@EmployeeID", employeeId);
                    connection.Open();
                    return command.ExecuteNonQuery() > 0;
                }
            }
            catch (MySqlException ex)
            {
                MessageBox.Show($"사원 삭제 중 오류 발생: {ex.Message}", "데이터베이스 오류", MessageBoxButton.OK, MessageBoxImage.Error);
                return false;
            }
        }

        // Employee 객체의 속성을 MySqlCommand의 파라미터로 설정하는 헬퍼 메서드
        private void SetEmployeeParameters(MySqlCommand command, Employee employee)
        {
            command.Parameters.AddWithValue("@EmployeeID", employee.EmployeeID);
            command.Parameters.AddWithValue("@EmployeeName", employee.EmployeeName);
            command.Parameters.AddWithValue("@Department", employee.Department ?? (object)DBNull.Value);
            command.Parameters.AddWithValue("@WorkDepartment", employee.WorkDepartment ?? (object)DBNull.Value);
            command.Parameters.AddWithValue("@Position", employee.Position ?? (object)DBNull.Value);
            command.Parameters.AddWithValue("@JobRank", employee.JobRank ?? (object)DBNull.Value); // Nullable
            command.Parameters.AddWithValue("@AppointmentDate", employee.AppointmentDate ?? (object)DBNull.Value);
            command.Parameters.AddWithValue("@Status", employee.Status ?? (object)DBNull.Value);
            command.Parameters.AddWithValue("@EmployeeType", employee.EmployeeType ?? (object)DBNull.Value);
            command.Parameters.AddWithValue("@AddressType", employee.AddressType ?? (object)DBNull.Value);
            command.Parameters.AddWithValue("@PhoneNumber", employee.PhoneNumber ?? (object)DBNull.Value);
            command.Parameters.AddWithValue("@RoadAddress", employee.RoadAddress ?? (object)DBNull.Value);
            command.Parameters.AddWithValue("@JibunAddress", employee.JibunAddress ?? (object)DBNull.Value);
            command.Parameters.AddWithValue("@Email", employee.Email ?? (object)DBNull.Value);
            // 추가된 컬럼들
            command.Parameters.AddWithValue("@Gender", employee.Gender ?? (object)DBNull.Value);
            command.Parameters.AddWithValue("@BirthDate", employee.BirthDate ?? (object)DBNull.Value);
            command.Parameters.AddWithValue("@MaritalStatus", employee.MaritalStatus ?? (object)DBNull.Value);
            command.Parameters.AddWithValue("@Nationality", employee.Nationality ?? (object)DBNull.Value);
            command.Parameters.AddWithValue("@HireDate", employee.HireDate ?? (object)DBNull.Value);
        }
    }
}
