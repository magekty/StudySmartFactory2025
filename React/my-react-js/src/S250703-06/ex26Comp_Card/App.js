import Card from './Card';

const App = ()=>{
    const img_url = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRiJhvJfHwK32pAC4BbyGO6JfV1Z-r0OssTLA&s"
    return(
        <div style={{display:"flex", gap:"2rem", padding:"2rem"}} >
            <Card 
                image={img_url}
                title="싱싱한 활 새우"
                desc="탱글 탱글한 식감에 달큰한 맛!">
                    <button>test button</button>
            </Card>
            <Card
                title="라면 한 뚝배기"
                desc ="한뚝배기 하실래예?"
            >
                <button>test button2</button>
            </Card>
        </div>

    )
}

export default App;