namespace CHSH
{
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Primitive;

    operation MeasureQbit(bit : Bool, qbit : Qubit) : (Result)
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

    operation PlayGame (
        aliceBit : Bool,
        bobBit : Bool)
            : (Bool)
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

                // Rotate Bob's qbit by pi/8
                Ry(-0.39269908169, bobQbit);

                // Measure qbits in basis depending upon input bit
                set aliceResult = MeasureQbit(aliceBit, aliceQbit);
                set bobResult = MeasureQbit(bobBit, bobQbit);

                ResetAll(qbits);
            }

            return aliceResult == bobResult;
        }
    }
}
