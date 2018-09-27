namespace CHSH
{
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Primitive;

    operation MeasureAliceQbit(bit : Bool, qbit : Qubit) : (Result)
    {
        body
        {
            if (bit)
            {
                // Measure in sign basis if bit is 1
                return Measure([PauliX], [qbit]);
            }
            else
            {
                // Measure in computational basis if bit is 0
                return Measure([PauliZ], [qbit]);
            }
        }
    }

    operation MeasureBobQbit(bit : Bool, qbit : Qubit) : (Result)
    {
        body
        {
            if (bit)
            {
                // Measure in -pi/8 basis if bit is 1
                Ry(0.78539816339, qbit);
                return M(qbit);
            }
            else
            {
                // Measure in pi/8 basis if bit is 0
                Ry(-0.78539816339, qbit);
                return M(qbit);
            }
        }
    }

    operation PlayQuantumStrategy(aliceBit : Bool, bobBit : Bool, aliceMeasuresFirst : Bool) : (Bool)
    {
        body
        {
            mutable aliceResult = Zero;
            mutable bobResult = Zero;

            using (qbits = Qubit[2])
            {
                // Alice and Bob get one qbit each
                let aliceQbit = qbits[0];
                let bobQbit = qbits[1];

                // Entangle Alice & Bob's qbits
                H(aliceQbit);
                CNOT(aliceQbit, bobQbit);

                // Measure qbits in basis depending upon input bit
                // Randomize who measures first
                if (aliceMeasuresFirst)
                {
                    set aliceResult = MeasureAliceQbit(aliceBit, aliceQbit);
                    set bobResult = MeasureBobQbit(bobBit, bobQbit);
                }
                else
                {
                    set bobResult = MeasureBobQbit(bobBit, bobQbit);
                    set aliceResult = MeasureAliceQbit(aliceBit, aliceQbit);
                }

                ResetAll(qbits);
            }

            return aliceResult == bobResult;
        }
    }
}
