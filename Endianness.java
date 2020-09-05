import static java.lang.System.out;

public class Endianness {

  public static int bigEndianValue (Byte[] mem) {
      int total = 0;
      for (int i=0; i<4;i++){
        
          total+=(mem[i] & 0x000000ff)<<8*(3-i) ;
      }


    return total;
  }
  
  public static int littleEndianValue (Byte[] mem) {
      int total = 0;
      for (int i=3; i>=0; i--) {

        total+=(mem[i] & 0x000000ff)<<8*(i) ;
      }
//      System.out.println(bytes);
//      System.out.println(Integer.parseInt(bytes, 16));
      return total;
  }
  
  public static void main (String[] args) {
    Byte mem[] = new Byte[4];
    try {
      for (int i=0; i<4; i++)
        mem [i] = Integer.valueOf (args[i], 16) .byteValue();
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