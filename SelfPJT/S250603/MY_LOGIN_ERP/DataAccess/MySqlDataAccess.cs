// DataAccess/MySqlDataAccess.cs
using MY_LOGIN_ERP.Models;
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Windows; // MessageBox를 위해 임시로 추가, 실제로는 별도 로깅 또는 예외 처리 권장


namespace MY_LOGIN_ERP.DataAccess
{
    public class MySqlDataAccess
    {
        private readonly string connectionString = "Server=localhost;Port=3306;Database=smart_factory_erp;Uid=root;Pwd=1121;";
        // "your_password"를 실제 MySQL root 비밀번호로 변경하세요.

        public MySqlDataAccess()
        {
            TestConnection();
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
            {
                query += " AND EmployeeID = @EmployeeID";
            }
            if (!string.IsNullOrEmpty(department))
            {
                query += " AND Department LIKE @Department";
            }
            if (!string.IsNullOrEmpty(employeeName))
            {
                query += " AND EmployeeName LIKE @EmployeeName";
            }
            if (!string.IsNullOrEmpty(addressType) && addressType != "선택안함")
            {
                query += $" AND AddressType = @AddressType";
            }
            if (!string.IsNullOrEmpty(employeeType) && employeeType != "선택안함")
            {
                query += $" AND EmployeeType = @EmployeeType";
            }
            if (!string.IsNullOrEmpty(status) && status != "선택안함")
            {
                query += $" AND Status = @Status";
            }

            try
            {
                using (MySqlConnection connection = new MySqlConnection(connectionString))
                {
                    MySqlCommand command = new MySqlCommand(query, connection);
                    if (employeeId.HasValue)
                    {
                        command.Parameters.AddWithValue("@EmployeeID", employeeId.Value);
                    }
                    if (!string.IsNullOrEmpty(department))
                    {
                        command.Parameters.AddWithValue("@Department", $"%{department}%");
                    }
                    if (!string.IsNullOrEmpty(employeeName))
                    {
                        command.Parameters.AddWithValue("@EmployeeName", $"%{employeeName}%");
                    }
                    if (!string.IsNullOrEmpty(addressType) && addressType != "선택안함")
                    {
                        command.Parameters.AddWithValue("@AddressType", addressType);
                    }
                    if (!string.IsNullOrEmpty(employeeType) && employeeType != "선택안함")
                    {
                        command.Parameters.AddWithValue("@EmployeeType", employeeType);
                    }
                    if (!string.IsNullOrEmpty(status) && status != "선택안함")
                    {
                        command.Parameters.AddWithValue("@Status", status);
                    }

                    connection.Open();

                    using (MySqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            employees.Add(new Employee
                            {
                                EmployeeID = reader.GetInt32("EmployeeID"),
                                EmployeeName = reader.GetString("EmployeeName"),
                                Department = reader.GetString("Department"),
                                WorkDepartment = reader.GetString("WorkDepartment"),
                                Position = reader.GetString("Position"),
                                JobRank = reader.IsDBNull(5) ? null : reader.GetString("JobRank"),
                                AppointmentDate = reader.IsDBNull(6) ? (DateTime?)null : reader.GetDateTime("AppointmentDate"),
                                Status = reader.GetString("Status"),
                                EmployeeType = reader.GetString("EmployeeType"),
                                AddressType = reader.GetString("AddressType"),
                                PhoneNumber = reader.GetString("PhoneNumber"),
                                RoadAddress = reader.GetString("RoadAddress"),
                                JibunAddress = reader.GetString("JibunAddress"),
                                Email = reader.GetString("Email"),
                                // 추가된 컬럼들 (데이터베이스에 컬럼이 없으면 에러 발생, 주석 해제 시 DB 스키마 업데이트 필수)
                                Gender = reader.IsDBNull(14) ? null : reader.GetString("Gender"),
                                BirthDate = reader.IsDBNull(15) ? (DateTime?)null : reader.GetDateTime("BirthDate"),
                                MaritalStatus = reader.IsDBNull(16) ? null : reader.GetString("MaritalStatus"),
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
            command.Parameters.AddWithValue("@Department", employee.Department);
            command.Parameters.AddWithValue("@WorkDepartment", employee.WorkDepartment);
            command.Parameters.AddWithValue("@Position", employee.Position);
            command.Parameters.AddWithValue("@JobRank", employee.JobRank ?? (object)DBNull.Value); // Nullable
            command.Parameters.AddWithValue("@AppointmentDate", employee.AppointmentDate ?? (object)DBNull.Value);
            command.Parameters.AddWithValue("@Status", employee.Status);
            command.Parameters.AddWithValue("@EmployeeType", employee.EmployeeType);
            command.Parameters.AddWithValue("@AddressType", employee.AddressType);
            command.Parameters.AddWithValue("@PhoneNumber", employee.PhoneNumber);
            command.Parameters.AddWithValue("@RoadAddress", employee.RoadAddress);
            command.Parameters.AddWithValue("@JibunAddress", employee.JibunAddress);
            command.Parameters.AddWithValue("@Email", employee.Email);
            // 추가된 컬럼들
            command.Parameters.AddWithValue("@Gender", employee.Gender ?? (object)DBNull.Value);
            command.Parameters.AddWithValue("@BirthDate", employee.BirthDate ?? (object)DBNull.Value);
            command.Parameters.AddWithValue("@MaritalStatus", employee.MaritalStatus ?? (object)DBNull.Value);
            command.Parameters.AddWithValue("@Nationality", employee.Nationality ?? (object)DBNull.Value);
            command.Parameters.AddWithValue("@HireDate", employee.HireDate ?? (object)DBNull.Value);
        }
    }
}
