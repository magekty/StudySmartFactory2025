import { useState, useEffect } from 'react';

export default function useFetch(url) {
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    let ignore = false;
    fetch(url)
      .then((res) => res.json())
      .then((data) => {
        if (!ignore) {
          setData(data);
          setLoading(false);
        }
      });
    return () => {
      ignore = true;
    };
  }, [url]);

  return { data, loading };
}
