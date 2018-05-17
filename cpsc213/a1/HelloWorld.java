public class HelloWorld {

    public static void main(String[] args) {
	    try {
	    	int decimal = Integer.valueOf(args[0]);
	    	System.out.println("Hello World");
 			System.out.printf("decimal representation: %d\n", decimal);
	    	System.out.printf("hexadecimal representation: 0x%x\n", decimal);
	    	System.out.println("binary representation: " + Integer.toBinaryString(decimal));
 		} catch (Exception e) {
 			System.out.printf("invalid input\n");
 		return;
 		}
    }
}
