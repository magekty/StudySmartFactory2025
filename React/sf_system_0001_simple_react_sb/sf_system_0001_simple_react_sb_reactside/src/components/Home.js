
const Home = ({isLoggedIn, username})=>{
    return(
        <div>
            <h2>메인(홈) 페이지</h2>
            {isLoggedIn ? (
                <p><strong>{username}</strong>님 반가워요</p>
            ):(
                <p>로그인 해주세요</p>
            )}
        </div>
    )
}

export default Home;