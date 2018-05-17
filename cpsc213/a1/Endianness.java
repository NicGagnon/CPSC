import static java.lang.System.out;

public class Endianness {

  public static int bigEndianValue (Byte[] mem) {
    int bigE = 0;
    for (int i=0; i < mem.length; i++) {
      //isolate the last 8 bits since 0xFF is 00000000 00000000 00000000 11111111 and & bitwise AND
      int b = mem[i] & 0xFF;
      //bit shift each inputted number from left to right
      bigE += b << (8 * (mem.length -1 -i));
    }
    return bigE;
  }
  
  public static int littleEndianValue (Byte[] mem) {
    int out = 0;
    for (int i=0; i < mem.length; i++) {
      int b = mem[i] & 0xFF;
      //bit shift each inputted number from right to left
      out += b << (8 * i);
    }
    return out;
  }
  
  public static void main (String[] args) {
    Byte mem[] = new Byte[4];
    try {
      for (int i=0; i<4; i++) {
        mem [i] = Integer.valueOf (args[i], 16) .byteValue();
        //System.out.println(Integer.valueOf (args[i], 16).byteValue());
      }
    } catch (Exception e) {
      out.printf ("usage: java Endianness n0 n1 n2 n3\n");
      out.printf ("where: n0..n3 are byte values in memory at addresses 0..3 respectively, in hex (no 0x).\n");
      return;
    }
  
    int bi = bigEndianValue    (mem);
    int li = littleEndianValue (mem);
    
    out.printf ("Memory Contents\n");
    out.printf ("  Addr   Value\n");
    for (int i=0; i<4; i++)
      out.printf ("  %3d:   0x%-5x\n", i, mem[i]);
    out.printf ("The big    endian integer value at address 0 is %d\n", bi);
    out.printf ("The little endian integer value at address 0 is %d\n", li);
  }
}