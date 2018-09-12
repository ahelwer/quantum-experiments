namespace Quantum.DeutschOracle
{
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;

    operation ConstantZero(input: Qubit, output: Qubit) : ()
    {
        body
        {
        }
    }

	operation ConstantOne(input: Qubit, output: Qubit) : ()
	{
		body
		{
			X(output);
		}
	}

	operation Identity(input: Qubit, output: Qubit) : ()
	{
		body
		{
			CNOT(input, output);
		}
	}

	operation Negation(input: Qubit, output: Qubit) : ()
	{
		body
		{
			CNOT(input, output);
			X(output);
		}
	}
}
