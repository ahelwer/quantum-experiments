namespace Quantum.DeutschOracle
{
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;

    operation Clear(input: Qubit, output: Qubit) : ()
    {
        body
        {
            let currentInput = M(input);
			if (Zero != currentInput)
			{
				X(input);
			}

			let currentOutput = M(output);
			if (Zero != currentOutput)
			{
				X(output);
			}
        }
    }

	operation IsBlackBoxConstant(blackBox: ((Qubit, Qubit) => ())) : (Bool)
	{
		body
		{
			mutable inputResult = Zero;
			mutable outputResult = Zero;

			// Allocate two qbits
			using (qbits = Qubit[2])
			{
				// Label qbits as inputs and outputs
				let input = qbits[0];
				let output = qbits[1];

				// Set qbits to zero in preparation
				Clear(input, output);

				// Pre-processing
				X(input);
				X(output);
				H(input);
				H(output);

				// Send qbits into black box
				blackBox(input, output);

				// Post-processing
				H(input);
				H(output);

				// Measure both qbits
				set inputResult = M(input);
				set outputResult = M(output);

				// Clear qbits before release
				Clear(input, output);
			}

			// If input qbit is 1, then black box is constant; if 0, is variable
			return One == inputResult;
		}
	}

	operation IsConstantZeroConstant() : (Bool)
	{
		body
		{
			return IsBlackBoxConstant(ConstantZero);
		}
	}

	operation IsConstantOneConstant() : (Bool)
	{
		body
		{
			return IsBlackBoxConstant(ConstantOne);
		}
	}

	operation IsIdentityConstant() : (Bool)
	{
		body
		{
			return IsBlackBoxConstant(Identity);
		}
	}

	operation IsNegationConstant() : (Bool)
	{
		body
		{
			return IsBlackBoxConstant(Negation);
		}
	}
}
