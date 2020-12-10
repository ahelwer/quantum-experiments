namespace SumOverPaths.Payload {
    
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;

    operation HelloQ () : Unit {
        Message("Hello quantum world!");
    }

    operation DoubleHadamard() : Result {
        using (psi = Qubit()) {
            H(psi);
            H(psi);
            return MResetZ(psi);
        }
    }
}
