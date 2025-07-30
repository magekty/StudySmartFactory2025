export const decodeJwt = (token)=>{
    try{
        const payload = token.split('.')[1]; // JWT구조(header.payload.signature )
        const decoded = JSON.parse(atob(payload));
        return decoded
    } catch(e){return null;}
}