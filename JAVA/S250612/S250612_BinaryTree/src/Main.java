import java.util.LinkedList;
import java.util.Queue;
import java.util.Stack;

// Binary Tree (Graph의 한 종류, cycle순환 유무)
class TreeNode<T>{
    T data;
    TreeNode<T> left,right;
    public TreeNode(T data){this.data = data;}
}
class BinarySearchTree<T>{
    private TreeNode<Integer> root;
    public void insert(int value){
        root = insertResursive(root, value);
    }
    private TreeNode<Integer> insertResursive(
            TreeNode<Integer> node, int value){
        if(node == null) return new TreeNode<>(value);
        if(value < node.data) node.left = insertResursive(node.left, value);
        else if (value > node.data){node.right = insertResursive(node.right, value);}
        return node;
    }
    // 순회 (traverse) preorder traverse, inorder traverse, postorder traverse
    public void inOrder(){
        inOrderRecurive(root);
    }
    private void inOrderRecurive(TreeNode<Integer> node){
        if(node != null){
            inOrderRecurive(node.left);
            System.out.print(node.data + " ");
            inOrderRecurive(node.right);
        }
    }
    // dfs방식 : 깊이 우선 탐색 - Depth First Search
    public void dfsWithStack(){
        Stack<TreeNode<Integer>> stack = new Stack<>();
        TreeNode<Integer> now = root;
        while (now != null || !stack.isEmpty()){
            while (now != null){
                stack.push(now);
                now = now.left;
            }
            now = stack.pop();
            System.out.print(now.data + " ");
            now = now.right;
        }
    }
    // bfs방식 : 너비 우선 탐색 - Breadth First Search
    public void bfsWithQueue(){
        Queue<TreeNode<Integer>> queue = new LinkedList<>();
        queue.offer(root);
        while (!queue.isEmpty()){
            TreeNode<Integer> now = queue.poll();
            System.out.print(now.data + " ");
            if(now.left != null) queue.offer(now.left);
            if(now.right != null) queue.offer(now.right);
        }
    }
    public void clearRoot(){
        root = null;
    }
}
public class Main {
    public static void main(String[] args) {
        // Binary Tree
        System.out.println("=====BinarySearchTree=====");
        BinarySearchTree<Integer> bst = new BinarySearchTree<>();
        bst.insert(5);bst.insert(3);
        bst.insert(7);bst.insert(4);
        bst.insert(8);bst.insert(6);
        bst.insert(2);
        bst.inOrder();

        // dfsWithStack
        System.out.println("\n=====dfsWithStack=====");
        bst.clearRoot();
        bst.insert(5);bst.insert(3);
        bst.insert(7);bst.insert(4);
        bst.insert(8);bst.insert(6);
        bst.insert(2);
        bst.dfsWithStack();

        // bfsWithQueue
        System.out.println("\n=====bfsWithQueue=====");
        bst.clearRoot();
        bst.insert(5);bst.insert(3);
        bst.insert(7);bst.insert(4);
        bst.insert(8);bst.insert(6);
        bst.insert(2);
        bst.bfsWithQueue();
    }
}