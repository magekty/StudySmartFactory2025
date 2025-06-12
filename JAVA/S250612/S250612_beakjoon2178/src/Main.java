import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.LinkedList;
import java.util.Queue;
import java.util.StringTokenizer;

// 미로탐색 백준 https://www.acmicpc.net/problem/2178
public class Main {
    static class Point{
        int x,  y;

        Point(int x, int y) {
            this.x = x;
            this.y = y;
        }
    }
    static int N, M;
    static int[][] map;
    static int[][] dist;
    static int[][] dirs = {{-1,0},{1,0},{0,-1},{0,1}};
    public static void main(String[] args) throws IOException {

        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        StringTokenizer st = new StringTokenizer(br.readLine());
        N = Integer.parseInt(st.nextToken());
        M = Integer.parseInt(st.nextToken());
        map = new int[N][M];
        dist = new int[N][M];
        for (int i = 0; i < N; i++) {
            char[] line = br.readLine().toCharArray();
            for (int j = 0; j < M; j++) {
                map[i][j] = line[j] - '0';
            }
        }
        bfs();
        System.out.print(dist[N-1][M-1]);
    }
    static void bfs(){
        Queue<Point> q = new LinkedList<>();
        q.offer(new Point(0, 0));
        dist[0][0] = 1;
        while(!q.isEmpty()){
            Point p = q.poll();
            int x = p.x; int y = p.y;
            for (int[] d: dirs) {
                int nx = x + d[0];  // {{-1,0},{1,0},{0,-1},{0,1}};
                int ny = y + d[1];
                if(nx < 0 || nx >= N || ny < 0 || ny >= M) continue;
                if(map[nx][ny] == 0 || dist[nx][ny] != 0) continue;

                dist[nx][ny] = dist[x][y] + 1;
                if (nx == N-1 && ny == M-1) return;
                q.offer(new Point(nx, ny));
            }
        }
    }
}