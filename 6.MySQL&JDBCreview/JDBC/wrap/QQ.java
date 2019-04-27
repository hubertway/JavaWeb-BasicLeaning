package wrap;

public class QQ implements Car {

	@Override
	public void run() {
		System.out.println("QQ is running");

	}

	@Override
	public void stop() {
		System.out.println("brake!");
	}

}
