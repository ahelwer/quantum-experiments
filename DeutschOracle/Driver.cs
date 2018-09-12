namespace Quantum.DeutschOracle
{
    using System;
    using Microsoft.Quantum.Simulation.Core;
    using Microsoft.Quantum.Simulation.Simulators;

    class Driver
    {
        static void Main(string[] args)
        {
            using (var sim = new QuantumSimulator())
            {
                Console.WriteLine($"ConstantZero constant? [{IsConstantZeroConstant.Run(sim).Result}]");
                Console.WriteLine($"ConstantOne constant? [{IsConstantOneConstant.Run(sim).Result}]");
                Console.WriteLine($"Identity constant? [{IsIdentityConstant.Run(sim).Result}]");
                Console.WriteLine($"Negation constant? [{IsNegationConstant.Run(sim).Result}]");
            }

            Console.WriteLine("Press any key to continue...");
            Console.ReadKey();
        }
    }
}