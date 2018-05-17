package arch.sm213.machine.student;

import machine.AbstractMainMemory;
import org.junit.Test;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.fail;

public class MainMemoryTest {
    @Test
    public void TestIsAlligned(){
        //Aim is to ensure that the memory is alligned by the given length.
        MainMemory m = new MainMemory(0);
        assertEquals(true, m.isAccessAligned(0, 4));
        assertEquals(true, m.isAccessAligned(16, 4));
        assertEquals(true, m.isAccessAligned(64, 2));
        assertEquals(false, m.isAccessAligned(1, 2));
        assertEquals(false, m.isAccessAligned(1, 4));
        assertEquals(true, m.isAccessAligned(8, 8));}

    @Test
    public void TestBytesToInteger() {
        //Testing to make sure the integer conversion of the given bytes matches target number
        MainMemory m = new MainMemory(0);
        assertEquals(0, m.bytesToInteger((byte)0,(byte)0,(byte)0,(byte)0));
        assertEquals(1, m.bytesToInteger((byte)0,(byte)0,(byte)0,(byte)1));
        assertEquals(128, m.bytesToInteger((byte)0,(byte)0,(byte)0,(byte)0x80));
        assertEquals(255, m.bytesToInteger((byte)0,(byte)0,(byte)0,(byte)0xff));
        assertEquals(-1, m.bytesToInteger((byte)0xff,(byte)0xff,(byte)0xff,(byte)0xff));
        assertEquals(Integer.MAX_VALUE, m.bytesToInteger((byte)0x7f,(byte)0xff,(byte)0xff,(byte)0xff));
        assertEquals(Integer.MIN_VALUE, m.bytesToInteger((byte)0x80,(byte)0,(byte)0,(byte)0));
    }

    @Test
    public void TestIntegerToBytes() {
        //Goal is to convert a single integer into a 4 byte equivalent code
        MainMemory m = new MainMemory(0);
        bytesEqual(0, 0, 0, 0, m.integerToBytes(0));
        bytesEqual(0, 0, 0, 1, m.integerToBytes(1));
        bytesEqual(0, 0, 0, 0x80, m.integerToBytes(128));
        bytesEqual(0, 0, 0, 0xff, m.integerToBytes(255));
        bytesEqual(0xff, 0xff, 0xff, 0xff, m.integerToBytes(-1));
        bytesEqual(0x7f, 0xff, 0xff, 0xff, m.integerToBytes(Integer.MAX_VALUE));
        bytesEqual(0x80, 0, 0, 0, m.integerToBytes(Integer.MIN_VALUE));
    }


    @Test
    public void TestSetGet() throws AbstractMainMemory.InvalidAddressException {
        //Test aim to set and get bytes from memory. In case of out of bounds or invalid address request, throw Exception
        MainMemory m = new MainMemory(64);
        byte[] longSet = new byte[]{0,1,2,3,4,5,6,7};
        byte[] shortSet = new byte[]{9,8,7,6};
        byte[] singleSet = new byte[]{7};

        m.set(0, longSet);
        assertEquals(longSet.length, m.get(0, 8).length);
        for (int i=0; i<longSet.length; i++) {
            assertEquals(longSet[i], m.mem[i]);
        }

        m.set(16, shortSet);
        assertEquals(shortSet.length, m.get(16, 4).length);
        for (int i=0; i<shortSet.length; i++) {
            assertEquals(shortSet[i], m.mem[i + 16]);
        }

        m.set(32, singleSet);
        assertEquals(singleSet.length, m.get(32, 1).length);
        for (int i=0; i<singleSet.length; i++) {
            assertEquals(singleSet[i], m.mem[i+ 32]);
        }

        try {
            m.set(-1, longSet);
            fail();
        } catch (Exception e) {}
        try {
            m.set(62, shortSet);
            fail();
        } catch (Exception e) {}
        try {
            m.get(-1, 4);
            fail();
        } catch (Exception e) {}
        try {
            m.get(0, 65);
            fail();
        } catch (Exception e) {}

    }



    private void bytesEqual(int a, int b, int c, int d, byte[] bytes) {
        // Additional function to aid with testing int to byte conversion
        assertEquals((byte)a,bytes[0]);
        assertEquals((byte)b,bytes[1]);
        assertEquals((byte)c,bytes[2]);
        assertEquals((byte)d,bytes[3]);
    }
}
