package arch.sm213.machine.student;

import arch.sm213.machine.AbstractSM213CPU;
import machine.AbstractMainMemory;
import machine.RegisterSet;
import util.UnsignedByte;


/**
 * The Simple Machine CPU.
 *
 * Simulate the execution of a single cycle of the Simple Machine SM213 CPU.
 */

public class CPU extends AbstractSM213CPU {

    /**
     * Create a new CPU.
     *
     * @param name   fully-qualified name of CPU implementation.
     * @param memory main memory used by CPU.
     */
    public CPU (String name, AbstractMainMemory memory) {
        super (name, memory);
    }

    /**
     * Fetch Stage of CPU Cycle.
     * Fetch instruction at address stored in "pc" register from memory into instruction register
     * and set "pc" to point to the next instruction to execute.
     *
     * Input register:   pc.
     * Output registers: pc, instruction, insOpCode, insOp0, insOp1, insOp2, insOpImm, insOpExt
     * @see AbstractSM213CPU for pc, instruction, insOpCode, insOp0, insOp1, insOp2, insOpImm, insOpExt
     *
     * @throws MainMemory.InvalidAddressException when program counter contains an invalid memory address
     */
    @Override protected void fetch() throws MainMemory.InvalidAddressException {
        int            pcVal  = pc.get();
        UnsignedByte[] ins    = mem.read (pcVal, 2);
        byte           opCode = (byte) (ins[0].value() >>> 4);
        insOpCode.set (opCode);
        insOp0.set    (ins[0].value() & 0x0f);
        insOp1.set    (ins[1].value() >>> 4);
        insOp2.set    (ins[1].value() & 0x0f);
        insOpImm.set  (ins[1].value());
        pcVal += 2;
        switch (opCode) {
            case 0x0:
            case 0xb:
                long opExt = mem.readIntegerUnaligned (pcVal) & 0xffffffffL;
                pcVal += 4;
                insOpExt.set    (opExt);
                instruction.set (ins[0].value() << 40 | ins[1].value() << 32 | opExt);
                break;
            default:
                insOpExt.set    (0);
                instruction.set (ins[0].value() << 40 | ins[1].value() << 32);
        }
        pc.set (pcVal);
    }


    /**
     * Execution Stage of CPU Cycle.
     * Execute instruction that was fetched by Fetch stage.
     *
     * Input state: pc, instruction, insOpCode, insOp0, insOp1, insOp2, insOpImm, insOpExt, reg, mem
     * Ouput state: pc, reg, mem
     * @see AbstractSM213CPU for pc, instruction, insOpCode, insOp0, insOp1, insOp2, insOpImm, insOpExt
     * @see MainMemory       for mem
     * @see machine.AbstractCPU      for reg
     *
     * @throws InvalidInstructionException                when instruction format is invalid.
     * @throws MachineHaltException                       when instruction is the HALT instruction.
     * @throws RegisterSet.InvalidRegisterNumberException when instruction references an invalid register (i.e, not 0-7).
     * @throws MainMemory.InvalidAddressException         when instruction references an invalid memory address.
     */
    @Override protected void execute () throws InvalidInstructionException, MachineHaltException, RegisterSet.InvalidRegisterNumberException, MainMemory.InvalidAddressException
    {
        int addr;
        int value;
        int destReg;
        // aabb ccdd
        // a = OpCode
        // b = InsOp0
        // c = InsOp1
        // d = InsOp2
        switch (insOpCode.get()) {
            case 0x0: // r[d] ← v
                reg.set (insOp0.get(), insOpExt.get());
                break;
            case 0x1: //1psd     r[d] ← m[o=p*4 + r[s]]
                addr = insOp0.get() * 4 + reg.get(insOp1.get());
                reg.set(insOp2.get(), mem.readInteger(addr));
                break;
            case 0x2: //2sid      r[d] ← m[r[s] + r[i] * 4]
                destReg = insOp2.get();
                value = mem.readInteger(reg.get(insOp0.get()) + reg.get(insOp1.get()) * 4);
                reg.set(destReg, value);
                break;
            case 0x3: // m[o=p*4+r[d]] ← r[s]
                value = reg.get(insOp0.get());
                addr = insOp1.get() * 4 + reg.get(insOp2.get());
                mem.writeInteger(addr, value);
                break;
            case 0x4: // 4sdi  m[r[d]+r[i]*4] ← r[s]
                value = reg.get(insOp0.get());
                addr = reg.get(insOp1.get()) + reg.get(insOp2.get()) * 4;
                mem.writeInteger(addr, value);
                break;
            case 0x6: // ALU ................... 6-sd
                switch (insOp0.get()) {
                    case 0x0: // 60sd   r[d] ← r[s]
                        value = reg.get(insOp1.get());
                        destReg = insOp2.get();
                        reg.set(destReg, value);
                        break;
                    case 0x1: // 61sd   r[d] ← r[d] + r[s]
                        value = reg.get(insOp2.get()) + reg.get(insOp1.get());
                        destReg = insOp2.get();
                        reg.set(destReg, value);
                        break;
                    case 0x2: //  62sd   r[d] ← r[d] & r[s]
                        value = reg.get(insOp2.get()) & reg.get(insOp1.get());
                        destReg = insOp2.get();
                        reg.set(destReg, value);
                        break;
                    case 0x3: // 63-d    r[d] ← r[d] + 1
                        value = reg.get(insOp2.get()) + 1;
                        destReg = insOp2.get();
                        reg.set(destReg, value);
                        break;
                    case 0x4: // 64-d    r[d] ← r[d] + 4
                        value = reg.get(insOp2.get()) + 4;
                        destReg = insOp2.get();
                        reg.set(destReg, value);
                        break;
                    case 0x5: // 65-d    r[d] ← r[d] - 1
                        value = reg.get(insOp2.get()) - 1;
                        destReg = insOp2.get();
                        reg.set(destReg, value);
                        break;
                    case 0x6: // 66-d    r[d] ← r[d] - 4
                        value = reg.get(insOp2.get()) - 4;
                        destReg = insOp2.get();
                        reg.set(destReg, value);
                        break;
                    case 0x7: // 67-d    r[d] ← ~r[d]
                        value = ~reg.get(insOp2.get());
                        destReg = insOp2.get();
                        reg.set(destReg, value);
                        break;
                    default:
                        throw new InvalidInstructionException();
                }
                break;
            case 0x7: // r[d] ← r[d] << s  7dss
                if (insOpImm.get() > 0) {
                    value = reg.get(insOp0.get()) << insOpImm.get();
                    destReg = insOp0.get();
                    reg.set(destReg, value);
                }
                else
                    // shr $i,rd ............. 7dii
                    reg.set (insOp0.get(), reg.get (insOp0.get()) >> -insOpImm.get());
                break;
            case 0xf: // halt or nop ............. f?--
                if (insOp0.get() == 0)
                    throw new MachineHaltException();
                else if (insOp0.getUnsigned() == 0xf)
                    // nop ........................... ff--
                    break;
                break;
            default:
                throw new InvalidInstructionException();
        }
    }
}
