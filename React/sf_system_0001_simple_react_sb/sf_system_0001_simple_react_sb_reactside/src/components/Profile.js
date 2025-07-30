import { useEffect } from "react";
import { getToken } from "../utils/api";

const Profile = ()=>{
    const [data, setData] = useState(null);
    const [error, setError] = useState(null);
    useEffect(()=>{
        const token = getToken();
        fetch(
            `${API_BASE}/profile`,
            {
                headers:{Authorization:`Bearer ${token}`}
            }
        ).then( (res)=>{
            if(!res.ok) throw new Error("인증 실패 또는 서버 오류");
            return res.json();
        }).then(setData)
        .catch( (err)=>{
            console.error("프로필 로딩 실패:", err);
            setError("프로필 정보를 불러올 수 없어요");
        });

    },[]);
    return(
        <div>
            <h2>프로필</h2>
            {error && <p style={{color:"red"}}>{error}</p>}
            {data ? (
                <div>
                    <p>아이디:{data.username}</p>
                    <p>이메일:{data.email}</p>
                    <p>권한:{data.role}</p>                    
                </div>
            ): (
                <p>불러 오는 중...</p>
            )}
        </div>
    )
}

export default Profile;