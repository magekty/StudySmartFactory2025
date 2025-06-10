// Strategy 전략
interface PricingStrategy{int calculatePrice(Car car);}

class BasicPricing implements PricingStrategy{
    @Override
    public int calculatePrice(Car car) {return car.getBasicPrice();}
}
class DiscountPricing implements PricingStrategy{
    @Override
    public int calculatePrice(Car car) {return (int)(0.9 * car.getBasicPrice());}
}
class PremiumPricing implements PricingStrategy{
    @Override
    public int calculatePrice(Car car) {return car.getBasicPrice() + car.getOptionPrice();}
}

class Car{
    private String model;
    private int basicPrice;
    private int optionPrice;
    private PricingStrategy pricingStrategy;

    public Car(String model, int basicPrice, int optionPrice) {
        this.model = model;
        this.basicPrice = basicPrice;
        this.optionPrice = optionPrice;
    }
    public void setPricingStrategy(PricingStrategy pricingStrategy){this.pricingStrategy = pricingStrategy;}

    public String getModel() {return model;}
    public int getBasicPrice() {return basicPrice;}
    public int getOptionPrice(){return this.optionPrice;}
    public int getFinalPrice(){
        if(pricingStrategy != null)
            return pricingStrategy.calculatePrice(this);
        else
            throw new IllegalStateException("가격 전략이 설정 되지 않았음");
    }
}
public class Main {
    public static void main(String[] args) {
        Car car = new Car("SUV 3000", 3000, 500);   // 3000 기본가격, 500 옵션가격,
        car.setPricingStrategy(new BasicPricing());
        System.out.println("기본 가격: " + car.getFinalPrice());
        car.setPricingStrategy(new DiscountPricing());
        System.out.println("할인 적용 가격: " + car.getFinalPrice());
        car.setPricingStrategy(new PremiumPricing());
        System.out.println("프리미엄 가격: " + car.getFinalPrice());
    }
}