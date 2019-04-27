package wrap;

public class CarWrap implements Car {

	private Car car;

	public CarWrap(Car car ) {
		this.car = car;
	}
	
	@Override
	public void run() {
		System.out.println("battery on");
		System.out.println("faster!");

	}

	@Override
	public void stop() {
		car.stop();

	}

}
