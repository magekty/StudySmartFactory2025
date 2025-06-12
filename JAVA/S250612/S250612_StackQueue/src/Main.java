// Stack vs Queue
// Stack : LIFO 후입 선출
class MyStack<T>{
    private Object[] data;
    private int top;
    private static final int DEFAULT_SIZE = 10;

    public MyStack(){
        data = new Object[DEFAULT_SIZE];
        top = -1;
    }
    public void push(T item){
        ensureCapacity();
        this.data[++top] = item;
    }
    public T pop(){
        if(isEmpty()) throw new RuntimeException("Stack is empty");
        T value = (T) this.data[this.top];
        data[this.top] = null;
        this.top--;
        return value;
    }
    public boolean isEmpty(){return top==-1;}
    private void ensureCapacity(){
        if(this.top + 1 == this.data.length){
            int newCapacity = this.data.length * 2;
            Object[] newArray = new Object[newCapacity];
            System.arraycopy(this.data, 0, newArray, 0, data.length);
            this.data = newArray;
        }
    }
}
// Queue : FIFO 선입 선출
class MyQueue<T>{
    private Object[] data;
    private int front;
    private int rear;
    private int size;
    private static final int DEFAULT_SIZE = 10;

    public MyQueue() {
        this.data = new Object[DEFAULT_SIZE];
        this.front = 0;
        this.rear = 0;
        this.size = 0;
    }
    // 큐에 입력
    public void enqueue(T item){
        ensureCapacity();
        this.data[this.rear] = item;
        this.rear = (this.rear+1)%this.data.length;
        this.size++;
    }
    public T dequeue(){
        if(isEmpty())throw new RuntimeException("Queue is empty");
        T value = (T)this.data[this.front];
        this.front = (this.front+1)%this.data.length;
        this.size--;
        return value;
    }
    private boolean isEmpty(){return this.size == 0;}
    private void ensureCapacity(){
        if(this.size + 1 == this.data.length){
            int newCapacity = this.data.length * 2;
            Object[] newArray = new Object[newCapacity];
            for (int i = 0; i < this.size; i++) {
                newArray[i] = this.data[(front + i) % this.data.length];
            }
            this.data = newArray; this.front = 0; this.rear = this.size;
        }
    }

}
// LinkedList : LIFO 후입 선출
class MyStackLinked<T>{
    private Node<T> top;
    private int size;
    private static class Node<T>{
        T data;
        Node<T> next;
        public Node(T data) {this.data = data;}
    }
    public void push(T item){
        Node<T> newNode = new Node<>(item);
        newNode.next = top;
        top = newNode;
        size++;
    }
    public T pop(){
        if(isEmpty()) throw new RuntimeException("stack is empty");
        T value = top.data;
        top = top.next;
        this.size--;
        return value;
    }
    public boolean isEmpty(){return top == null;}
}
// LinkedQueue : FIFO 선입 선출
class MyQueueLinked<T>{
    private static class Node<T>{
        T data;
        Node<T> next;
        Node(T data) {this.data = data;}
    }
    private Node<T> front, rear;
    private int size;
    public void enqueue(T item){
        Node<T> newNode = new Node<>(item);
        if(isEmpty()){front = rear = newNode;}
        else{rear.next = newNode; rear = newNode;}
        size++;
    }
    public T dequeue(){
        if(isEmpty()) throw new RuntimeException("Queue is empty");
        T value = front.data;
        front = front.next;
        if(front == null) rear = null;
        size--;
        return value;
    }
    public boolean isEmpty(){return front == null;}
}
public class Main {
    public static void main(String[] args) {
        // MyStack
        MyStack<String> myStack = new MyStack<>();
        myStack.push("1");
        myStack.push("2");
        myStack.push("3");
        System.out.println("=====Stack=====");
        System.out.println("Pop data: "+myStack.pop());
        System.out.println("Pop data: "+myStack.pop());
        System.out.println("Pop data: "+myStack.pop());
        // MyQueue
        MyQueue<String> myQueue = new MyQueue<>();
        myQueue.enqueue("1");
        myQueue.enqueue("2");
        myQueue.enqueue("3");
        System.out.println("=====Queue=====");
        System.out.println("dequeue data: "+myQueue.dequeue());
        System.out.println("dequeue data: "+myQueue.dequeue());
        System.out.println("dequeue data: "+myQueue.dequeue());
        // MyStackLinked
        MyStackLinked<String> myStackLinked = new MyStackLinked<>();
        myStackLinked.push("1");
        myStackLinked.push("2");
        myStackLinked.push("3");
        System.out.println("=====StackLinked=====");
        System.out.println("dequeue data: "+myStackLinked.pop());
        System.out.println("dequeue data: "+myStackLinked.pop());
        System.out.println("dequeue data: "+myStackLinked.pop());
        // MyQueueLinked
        MyQueueLinked<String> myQueueLinked = new MyQueueLinked<>();
        myQueueLinked.enqueue("1");
        myQueueLinked.enqueue("2");
        myQueueLinked.enqueue("3");
        System.out.println("=====QueueLinked=====");
        System.out.println("dequeue data: "+myQueueLinked.dequeue());
        System.out.println("dequeue data: "+myQueueLinked.dequeue());
        System.out.println("dequeue data: "+myQueueLinked.dequeue());

    }
}