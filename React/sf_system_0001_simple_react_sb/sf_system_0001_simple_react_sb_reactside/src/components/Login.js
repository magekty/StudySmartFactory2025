import { useState } from "react";
import { setToken } from "../utils/api";
import { useNavigate } from "react-router-dom";



const Login = ({onLogin})=>{
    const [msg, setMsg]=useState("");
    const [form, setForm] =useState({username:"", 
        password:""});
    const navigate = useNavigate();

    const handleUsername = (e)=> setForm(
        {...form, username: e.target.value}
    )
    const handlePassword = (e)=> setForm(
        {...form, password: e.target.value}
    )
    const handleSubmit = async (e)=>{
        e.preventDefault();
        const res = await fetch(
            `${API_BASE}/login`,
            {
                method:"POST",
                headers:{"Content-Type":"application/json"},
                body: JSON.stringify(form)
            }
        )
        if(res.ok){
            const data = await res.json();
            setToken(data.token);
            setMsg("로그인 성공!");
            onLogin(data.token);
            navigate("/");
        }else{
            setMsg("로그인 실패")
        }
    };

    return(
        <div>
            <h2>로그인 페이지</h2>
            <form onSubmit={handleSubmit}>
                <input placeholder="아이디" onChange={handleUsername} /><br/>
                <input placeholder="비밀번호" onChange={handlePassword} /><br/>
                <button type="submit">로그인</button>
            </form>
            <p>{msg}</p>
        </div>

    );

}

export default Login;