import { useEffect, useState } from "react";
import { getToken } from "../utils/api";


const Admin = ()=>{
    const [msg, setMsg] = useState("");
    const token = getToken();
    useEffect( ()=>{
        fetch(
            `${API_BASE}/admin`,
            {
                headers:{Authorization:`Bearer ${token}`}
            }
        ).then( res=>{
            if(res.ok) return res.text();
            else throw new Error("권한 없음")
        }).then(setMsg)
        .catch(()=>setMsg("접근 거부"));

    },[])

    return (
        <div>
            <h2>관리자 페이지</h2>
            <p>{msg}</p>
        </div>
    )
}

export default Admin;