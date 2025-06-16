import { useParams } from 'react-router-dom';
import users from '../data/mockUsers';

export default function UserDetail() {
  const { id } = useParams();
  const user = users.find((u) => u.id === Number(id));

  if (!user) return <p>존재하지 않는 유저입니다.</p>;

  return (
    <div>
      <h2>{user.name}의 상세 정보</h2>
      <p>Email: {user.email}</p>
      <p>소개: {user.bio}</p>
    </div>
  );
}
