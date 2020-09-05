package arch.sm213.machine.student;

import machine.AbstractMainMemory;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

public class MainMemoryTest {
    MainMemory memory1 ;
    MainMemory memory2;
    byte b0;
    byte b1;
    byte b2;
    byte b3;

    @BeforeEach
    void runBefore() {
        memory1 = new MainMemory(128);
        memory2 = new MainMemory(32);
    }

    //Testing when address is aligned using isAccessAligned Method
    @Test
     void whenAddressAlignedTest() {
        //testing memory length here as well
        assertEquals(memory2.length(), 32);
        assertEquals(memory1.length(), 128);
        int address = 2;
        int length = 2;
        assertTrue(memory1.isAccessAligned(address,length));
        assertTrue(memory2.isAccessAligned(address,length));
        assertTrue(memory2.isAccessAligned(4,2));

    }
    @Test
    void whenAddressNOTAlignedTest() {
        int address = 2;
        int length = 3;
        assertFalse(memory1.isAccessAligned(address,length));
        assertFalse(memory2.isAccessAligned(address,length));
        assertFalse(memory2.isAccessAligned(address,4));

    }


    //Testing bytes to big endian integer using different cases to make sure it works properly
    @Test
    void bytesToIntegerTest() {
        //int number 1
        Integer a = 0;
        Integer b = 1;
        b0 = a.byteValue();
        b1 = a.byteValue();
        b2 = a.byteValue();
        b3 = b.byteValue();

        assertEquals(1, memory2.bytesToInteger(b0,b1,b2,b3));

        //int number 0;

        assertEquals(0,memory2.bytesToInteger(b0,b1,b2,b2));

        //int -1

        //from Endianness.java
        a = Integer.valueOf ("ff", 16);
        b0 = a.byteValue();

        assertEquals(-1,memory2.bytesToInteger(b0,b0,b0,b0));

        //int for Hexadecimals digits 80 80 80 80, value is -2139062144

        b = Integer.valueOf ("80", 16);
        b1 = b.byteValue();
        assertEquals(-2139062144,memory2.bytesToInteger(b1,b1,b1,b1));

        // int for when first byte and 4th byte are equal while, 2nd and 4th are equal

        assertEquals(-2130706560, memory2.bytesToInteger(b1,b0,b0,b1));


    }


    //Testing big endian integers to a 4 byte array
    @Test
    void integerToBytesTest() {
        //int 0 test, where array will have 0 0 0 0

        //first checking whether array size is zero or not
        assertEquals(4, memory2.integerToBytes(0).length);
        Integer a = 0;
        b0 = a.byteValue();
        byte[] test = memory2.integerToBytes(0);

        for(int i = 0; i<test.length; i++){
            assertEquals(b0,test[i]);
        }

        //int -1 test,

        Integer b = Integer.valueOf ("ff", 16);
        b1 = b.byteValue();

        test = memory2.integerToBytes(-1);

        for(int i = 0; i<test.length; i++){
            assertEquals(b1,test[i]);
        }

    }

    //Test sequence of bytes into memory first
    @Test
    void setTestWithoutExceptionTEST() {
        //test with int 0;
        Integer a = 0;
        b0 = a.byteValue();
        int address = 0;
        byte[] test = memory2.integerToBytes(0);

        try{
            memory2.set(address,test);
        } catch (AbstractMainMemory.InvalidAddressException ee) {
            fail("No exception thrown");
        }

        //test with int -1
        Integer b = Integer.valueOf ("ff", 16);
        b1 = b.byteValue();
        address = 4;

        test = memory2.integerToBytes(-1);
        try{
            memory2.set(address,test);
        } catch (AbstractMainMemory.InvalidAddressException ee) {
            fail("No exception thrown");
        }
    }

    @Test
    void setTestWithExceptionTEST() {
        //test with int 0;
        Integer a = 0;
        b0 = a.byteValue();
        byte[] test = memory2.integerToBytes(0);

        int address = -1;
        try{
            memory2.set(address,test);
            fail("Should throw Invalid Address exception");
        } catch (AbstractMainMemory.InvalidAddressException ee) {
        }

        //test with int -1
        Integer b = Integer.valueOf ("ff", 16);
        b1 = b.byteValue();

        test = memory2.integerToBytes(-1);
        address = 32;
        try{
            memory2.set(address,test);
            fail("Should throw Invalid Address exception");
        } catch (AbstractMainMemory.InvalidAddressException ee) {

        }
    }

    //testing fetching a sequence of bytes from memory
    @Test
    void getMethodWithoutExceptionTest() {
        //testing when no values set in memory
        int address = 0;
        int length = 4;
        byte[] test = memory2.integerToBytes(0);
        try{
            memory2.set(0,test);
            assertEquals(4, memory2.get(address,length).length);
            byte [] getTest = memory2.get(address,length);
            for(int i = 0; i<getTest.length; i++){
                assertEquals(test[i],getTest[i]);
            }
        } catch (AbstractMainMemory.InvalidAddressException ee) {
            fail("No exception thrown");
        }

    }
    @Test
    void getMethodWithExceptionTest() {
        //testing when no values set in memory
        int address = -1;
        int length = 4;
        byte[] test = memory2.integerToBytes(0);
        try{
            byte [] getTest = memory2.get(address,length);
            fail("Should throw Invalid Address exception");
        } catch (AbstractMainMemory.InvalidAddressException ee) {

        }
        address = 0;
        length = 33;
        try{
            byte [] getTest2 = memory2.get(address,length);
            fail("Should throw Invalid Address exception");
        } catch (AbstractMainMemory.InvalidAddressException ee) {

        }
        address = -1;
        length = 4;
        try{
            byte [] getTest2 = memory2.get(address,length);
            fail("Should throw Invalid Address exception");
        } catch (AbstractMainMemory.InvalidAddressException ee) {

        }
        address = 32;
        length = 4;
        try{
            byte [] getTest2 = memory2.get(address,length);
            fail("Should throw Invalid Address exception");
        } catch (AbstractMainMemory.InvalidAddressException ee) {

        }
        address = 33;
        length = 4;
        try{
            byte [] getTest2 = memory2.get(address,length);
            fail("Should throw Invalid Address exception");
        } catch (AbstractMainMemory.InvalidAddressException ee) {

        }

        // Not sure how to test when length empty
//        address = 0;
//        length = 0;
//        try{
//            byte [] getTest2 = memory2.get(address,length);
//            fail("Should throw Invalid Address exception");
//        } catch (AbstractMainMemory.InvalidAddressException ee) {
//
//        }
    }




}
