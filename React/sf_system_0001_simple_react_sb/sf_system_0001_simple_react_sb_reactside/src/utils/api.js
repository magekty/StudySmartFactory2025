export const API_BASE = "http://localhost:8080/api/v1"; //Springboot의 v1(RequestMapping)
export const getToken = ()=> localStorage.getItem("token");
export const setToken = (token)=>localStorage.setItem("token", token);
export const removeToken = ()=> localStorage.removeItem("token");