import java.util.ArrayList;
import java.util.List;
// Factory Method (팩토리 메서드)
// 1. Product (제품) 인터페이스
interface Coffee {
    void brew();
}

// 2. Concrete Product (구체적인 제품) 클래스
class Latte implements Coffee {
    @Override
    public void brew() {
        System.out.println("Brewing Latte...");
    }
}

class Americano implements Coffee {
    @Override
    public void brew() {
        System.out.println("Brewing Americano...");
    }
}

// 3. Creator (생성자) 추상 클래스
abstract class CoffeeFactory {
    // 팩토리 메서드
    public abstract Coffee createCoffee();

    public void orderCoffee() {
        Coffee coffee = createCoffee(); // 팩토리 메서드를 통해 커피 생성
        coffee.brew();
    }
}

// 4. Concrete Creator (구체적인 생성자) 클래스
class LatteFactory extends CoffeeFactory {
    @Override
    public Coffee createCoffee() {
        return new Latte();
    }
}

class AmericanoFactory extends CoffeeFactory {
    @Override
    public Coffee createCoffee() {
        return new Americano();
    }
}

//Abstract Factory (추상 팩토리)
// 1. Abstract Product A
interface Chair {
    void sitOn();
}

// Concrete Product A1
class ModernChair implements Chair {
    @Override
    public void sitOn() {
        System.out.println("Sitting on a modern chair.");
    }
}

// Concrete Product A2
class VictorianChair implements Chair {
    @Override
    public void sitOn() {
        System.out.println("Sitting on a victorian chair.");
    }
}

// 2. Abstract Product B
interface Table {
    void putOn();
}

// Concrete Product B1
class ModernTable implements Table {
    @Override
    public void putOn() {
        System.out.println("Putting things on a modern table.");
    }
}

// Concrete Product B2
class VictorianTable implements Table {
    @Override
    public void putOn() {
        System.out.println("Putting things on a victorian table.");
    }
}

// 3. Abstract Factory
interface FurnitureFactory {
    Chair createChair();
    Table createTable();
}

// 4. Concrete Factory 1
class ModernFurnitureFactory implements FurnitureFactory {
    @Override
    public Chair createChair() {
        return new ModernChair();
    }

    @Override
    public Table createTable() {
        return new ModernTable();
    }
}

// 4. Concrete Factory 2
class VictorianFurnitureFactory implements FurnitureFactory {
    @Override
    public Chair createChair() {
        return new VictorianChair();
    }

    @Override
    public Table createTable() {
        return new VictorianTable();
    }
}
// Adapter(어뎁터)
// 1. Target (타겟) 인터페이스
interface MediaPlayer {
    void play(String audioType, String fileName);
}

// 2. Adaptee (어댑티) 클래스 (기존 클래스)
class AdvancedMediaPlayer {
    public void playVlc(String fileName) {
        System.out.println("Playing vlc file. Name: " + fileName);
    }

    public void playMp4(String fileName) {
        System.out.println("Playing mp4 file. Name: " + fileName);
    }
}

// 3. Adapter (어댑터) 클래스
class MediaAdapter implements MediaPlayer {
    AdvancedMediaPlayer advancedMediaPlayer;

    public MediaAdapter(String audioType) {
        if (audioType.equalsIgnoreCase("vlc")) {
            advancedMediaPlayer = new AdvancedMediaPlayer();
        } else if (audioType.equalsIgnoreCase("mp4")) {
            advancedMediaPlayer = new AdvancedMediaPlayer();
        }
    }

    @Override
    public void play(String audioType, String fileName) {
        if (audioType.equalsIgnoreCase("vlc")) {
            advancedMediaPlayer.playVlc(fileName);
        } else if (audioType.equalsIgnoreCase("mp4")) {
            advancedMediaPlayer.playMp4(fileName);
        }
    }
}

// Client (클라이언트) 클래스 (MediaPlayer를 사용하는 클래스)
class AudioPlayer implements MediaPlayer {
    MediaAdapter mediaAdapter;

    @Override
    public void play(String audioType, String fileName) {
        // mp3는 직접 지원
        if (audioType.equalsIgnoreCase("mp3")) {
            System.out.println("Playing mp3 file. Name: " + fileName);
        }
        // vlc, mp4는 어댑터 사용
        else if (audioType.equalsIgnoreCase("vlc") || audioType.equalsIgnoreCase("mp4")) {
            mediaAdapter = new MediaAdapter(audioType);
            mediaAdapter.play(audioType, fileName);
        } else {
            System.out.println("Invalid media. " + audioType + " format not supported");
        }
    }
}
// 행위(Behavioral)
// 1. Subject (주제) 인터페이스
interface Subject {
    void registerObserver(Observer o);
    void removeObserver(Observer o);
    void notifyObservers();
}

// 2. Observer (옵저버) 인터페이스
interface Observer {
    void update(float temperature, float humidity, float pressure);
}

// 3. Concrete Subject (구체적인 주제)
class WeatherData implements Subject {
    private List<Observer> observers;
    private float temperature;
    private float humidity;
    private float pressure;

    public WeatherData() {
        observers = new ArrayList<>();
    }

    @Override
    public void registerObserver(Observer o) {
        observers.add(o);
    }

    @Override
    public void removeObserver(Observer o) {
        observers.remove(o);
    }

    @Override
    public void notifyObservers() {
        for (Observer observer : observers) {
            observer.update(temperature, humidity, pressure);
        }
    }

    public void measurementsChanged() {
        notifyObservers();
    }

    public void setMeasurements(float temperature, float humidity, float pressure) {
        this.temperature = temperature;
        this.humidity = humidity;
        this.pressure = pressure;
        measurementsChanged();
    }
}

// 4. Concrete Observer (구체적인 옵저버)
class CurrentConditionsDisplay implements Observer {
    private float temperature;
    private float humidity;
    private Subject weatherData;

    public CurrentConditionsDisplay(Subject weatherData) {
        this.weatherData = weatherData;
        weatherData.registerObserver(this); // Subject에 등록
    }

    @Override
    public void update(float temperature, float humidity, float pressure) {
        this.temperature = temperature;
        this.humidity = humidity;
        display();
    }

    public void display() {
        System.out.println("Current conditions: " + temperature
                + "F degrees and " + humidity + "% humidity");
    }
}

class StatisticsDisplay implements Observer {
    private float maxTemp = 0.0f;
    private float minTemp = 200.0f;
    private float tempSum = 0.0f;
    private int numReadings;
    private Subject weatherData;

    public StatisticsDisplay(Subject weatherData) {
        this.weatherData = weatherData;
        weatherData.registerObserver(this);
    }

    @Override
    public void update(float temperature, float humidity, float pressure) {
        tempSum += temperature;
        numReadings++;

        if (temperature > maxTemp) {
            maxTemp = temperature;
        }

        if (temperature < minTemp) {
            minTemp = temperature;
        }
        display();
    }

    public void display() {
        System.out.println("Avg/Max/Min temperature = " + (tempSum / numReadings)
                + "/" + maxTemp + "/" + minTemp);
    }
}
// Strategy (전략)
// 1. Strategy (전략) 인터페이스
interface PaymentStrategy {
    void pay(int amount);
}

// 2. Concrete Strategy (구체적인 전략) 클래스
class CreditCardPayment implements PaymentStrategy {
    private String cardNumber;
    private String name;

    public CreditCardPayment(String cardNumber, String name) {
        this.cardNumber = cardNumber;
        this.name = name;
    }

    @Override
    public void pay(int amount) {
        System.out.println(amount + " paid with credit card: " + cardNumber);
    }
}

class PayPalPayment implements PaymentStrategy {
    private String emailId;

    public PayPalPayment(String emailId) {
        this.emailId = emailId;
    }

    @Override
    public void pay(int amount) {
        System.out.println(amount + " paid using PayPal: " + emailId);
    }
}

// 3. Context (컨텍스트) 클래스
class ShoppingCart {
    private List<Integer> items;
    private PaymentStrategy paymentStrategy;

    public ShoppingCart() {
        this.items = new ArrayList<>();
    }

    public void addItem(int price) {
        this.items.add(price);
    }

    public void setPaymentStrategy(PaymentStrategy paymentStrategy) {
        this.paymentStrategy = paymentStrategy;
    }

    public void checkout() {
        int total = 0;
        for (Integer itemPrice : items) {
            total += itemPrice;
        }
        if (paymentStrategy != null) {
            paymentStrategy.pay(total);
        } else {
            System.out.println("No payment strategy set.");
        }
    }
}
public class Main {

    public static void main(String[] args) {
        // factory method 사용법
/*         CoffeeFactory latteFactory = new LatteFactory();
         latteFactory.orderCoffee(); // Brewing Latte...

         CoffeeFactory americanoFactory = new AmericanoFactory();
         americanoFactory.orderCoffee(); // Brewing Americano...*/

         // abstract factory 사용법
/*         FurnitureFactory modernFactory = new ModernFurnitureFactory();
         Chair modernChair = modernFactory.createChair();
         Table modernTable = modernFactory.createTable();
         modernChair.sitOn();
         modernTable.putOn();

         FurnitureFactory victorianFactory = new VictorianFurnitureFactory();
         Chair victorianChair = victorianFactory.createChair();
         Table victorianTable = victorianFactory.createTable();
         victorianChair.sitOn();
         victorianTable.putOn();*/

        // Adapter 사용법
        // 사용 예시:
/*         AudioPlayer audioPlayer = new AudioPlayer();
         audioPlayer.play("mp3", "beyond_the_horizon.mp3");
         audioPlayer.play("mp4", "alone.mp4");
         audioPlayer.play("vlc", "far_far_away.vlc");
         audioPlayer.play("avi", "mind_me.avi");*/

        // 행위(Behavioral) 사용법
/*         WeatherData weatherData = new WeatherData();

         CurrentConditionsDisplay currentDisplay = new CurrentConditionsDisplay(weatherData);
         StatisticsDisplay statisticsDisplay = new StatisticsDisplay(weatherData);

         weatherData.setMeasurements(80, 65, 30.4f);
         weatherData.setMeasurements(82, 70, 29.2f);
         weatherData.setMeasurements(78, 90, 29.2f);*/

        // Strategy (전략) 사용법
        ShoppingCart cart = new ShoppingCart();
        cart.addItem(100);
        cart.addItem(250);

        // 신용카드 결제
        cart.setPaymentStrategy(new CreditCardPayment("1234-5678-9012-3456", "John Doe"));
        cart.checkout(); // 350 paid with credit card: 1234-5678-9012-3456

        // PayPal 결제
        cart.setPaymentStrategy(new PayPalPayment("john.doe@example.com"));
        cart.checkout(); // 350 paid using PayPal: john.doe@example.com
    }
}