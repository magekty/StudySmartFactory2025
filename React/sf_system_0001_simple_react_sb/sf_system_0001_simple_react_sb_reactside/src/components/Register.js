import { useState } from "react";
import { API_BASE } from "../utils/api";


const Register = ()=>{
    const [form, setForm] = useState(
        {username:"", password:"", email:""}
    )
    const [msg, setMsg] = useState("");


    const handleUsername = (e)=> setForm(
        {...form, username: e.target.value}
    )
    const handlePassword = (e)=> setForm(
        {...form, password: e.target.value}
    )
    const handleEmail = (e)=> setForm(
        {...form, email: e.target.value}
    )
    const handleSubmit = async (e)=>{
        e.preventDefault();
        const res = await fetch(
            `${API_BASE}/register`,
            {
                method:"POST",
                headers:{"Content-Type":"application/json"},
                body: JSON.stringify(form)
            }
        )
        const text = await res.text();
        setMsg(text);
    }
    return(
        <div>
            <h2>회원가입 페이지</h2>
            <form onSubmit={handleSubmit}>
                <input placeholder="아이디" onChange={handleUsername} /><br/>
                <input placeholder="비밀번호" onChange={handlePassword} /><br/>
                <input placeholder="이메일" onChange={handleEmail} /><br/>
                <button type="submit">회원 가입</button>
            </form>
            <p>{msg}</p>
        </div>

    );

}
export default Register;