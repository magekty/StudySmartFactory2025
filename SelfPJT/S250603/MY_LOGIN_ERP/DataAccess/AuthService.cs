using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MY_LOGIN_ERP.DataAccess
{
    using System.Net.Http;
    using System.Net.Http.Headers;
    using System.Text;
    using System.Text.Json;
    using System.Threading.Tasks;

    internal class AuthService
    {
        private readonly HttpClient _httpClient = new HttpClient();
        private string _jwtToken;

        public async Task<bool> LoginAsync(string username, string password)
        {
            var loginData = new
            {
                username = username,
                password = password
            };

            string json = JsonSerializer.Serialize(loginData);
            var content = new StringContent(json, Encoding.UTF8, "application/json");

            HttpResponseMessage response = await _httpClient.PostAsync("http://localhost:8080/api/auth/login", content);

            if (response.IsSuccessStatusCode)
            {
                string result = await response.Content.ReadAsStringAsync();

                // 예: {"token":"eyJhbGciOi..."}
                var resultObj = JsonSerializer.Deserialize<JwtResponse>(result);
                _jwtToken = resultObj.Token;
                return true;
            }

            return false;
        }

        private class JwtResponse
        {
            public string Token { get; set; }
        }
    }

}
