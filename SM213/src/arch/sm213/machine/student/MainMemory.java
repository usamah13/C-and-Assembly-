package arch.sm213.machine.student;

import machine.AbstractMainMemory;


/**
 * Main Memory of Simple CPU.
 *
 * Provides an abstraction of main memory (DRAM).
 */

public class MainMemory extends AbstractMainMemory {
  private byte [] mem;
  
  /**
   * Allocate memory.
   * @param byteCapacity size of memory in bytes.
   */
  public MainMemory (int byteCapacity) {
    mem = new byte [byteCapacity];
  }
  
  /**
   * Determine whether an address is aligned to specified length.
   * @param address memory address.
   * @param length byte length.
   * @return true iff address is aligned to length.
   */
  @Override protected boolean isAccessAligned (int address, int length) {
    // TODO

    return address%length == 0;
  }
  
  /**
   * Convert an sequence of four bytes into a Big Endian integer.
   * @param byteAtAddrPlus0 value of byte with lowest memory address (base address).
   * @param byteAtAddrPlus1 value of byte at base address plus 1.
   * @param byteAtAddrPlus2 value of byte at base address plus 2.
   * @param byteAtAddrPlus3 value of byte at base address plus 3 (highest memory address).
   * @return Big Endian integer formed by these four bytes.
   */
  @Override public int bytesToInteger (byte byteAtAddrPlus0, byte byteAtAddrPlus1, byte byteAtAddrPlus2, byte byteAtAddrPlus3) {
    // TODO
      int total = 0;

      total+= (byteAtAddrPlus0 & 0x000000ff)<<24;
      total+= (byteAtAddrPlus1 & 0x000000ff)<<16;
      total+= (byteAtAddrPlus2 & 0x000000ff)<<8;
      total+= (byteAtAddrPlus3 & 0x000000ff)<<0;


    return total;
  }
  
  /**
   * Convert a Big Endian integer into an array of 4 bytes organized by memory address.
   * @param  i an Big Endian integer.
   * @return an array of byte where [0] is value of low-address byte of the number etc.
   */
  @Override public byte[] integerToBytes (int i) {
    // TODO
      byte b = (byte) i;
      int a = b;
      byte[] bytes = new byte[4];
      for (int c = 0; c<4;c++) {
          bytes[c] = (byte) ((a>>8*(3-c)) & 0xff);
      }
    return bytes;
  }
  
  /**
   * Fetch a sequence of bytes from memory.
   * @param address address of the first byte to fetch.
   * @param length  number of bytes to fetch.
   * @throws InvalidAddressException  if any address in the range address to address+length-1 is invalid.
   * @return an array of byte where [0] is memory value at address, [1] is memory value at address+1 etc.
   */
  @Override protected byte[] get (int address, int length) throws InvalidAddressException {
    // TODO

      if(address<0 || mem.length<address+length-1) {
          throw new InvalidAddressException();
      }
      byte[] get = new byte[length];

      try {
      for (int i = 0; i <length; i++){
          get[i] = mem[address+i];
      }}catch(IndexOutOfBoundsException ee){
          throw new InvalidAddressException();
      }

    return get;
  }
  
  /**
   * Store a sequence of bytes into memory.
   * @param  address                  address of the first byte in memory to recieve the specified value.
   * @param  value                    an array of byte values to store in memory at the specified address.
   * @throws InvalidAddressException  if any address in the range address to address+value.length-1 is invalid.
   */
  @Override protected void set (int address, byte[] value) throws InvalidAddressException {
    // TODO

      if(address<0 || mem.length<address+value.length-1){
          throw new InvalidAddressException();
      }

      try{
      for (int i = 0; i <value.length; i++){
          mem[address+i] = value[i];
      }} catch (IndexOutOfBoundsException ee) {
          throw new InvalidAddressException();
      }
  }
  
  /**
   * Determine the size of memory.
   * @return the number of bytes allocated to this memory.
   */
  @Override public int length () {
    return mem.length;
  }
}
