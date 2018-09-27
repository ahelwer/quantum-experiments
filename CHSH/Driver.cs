namespace CHSH
{
    using System;
    using Microsoft.Quantum.Simulation.Core;
    using Microsoft.Quantum.Simulation.Simulators;

    class Driver
    {
        static void Main(string[] args)
        {
            const int trialCount = 10000;
            Random generator = new Random();
            using (var sim = new QuantumSimulator())
            {
                int classicalWinCount = 0;
                int quantumWinCount = 0;
                for (int i = 0; i < trialCount; i++)
                {
                    bool aliceBit = GetRandomBit(generator);
                    bool bobBit = GetRandomBit(generator);
                    bool aliceMeasuresFirst = GetRandomBit(generator);
                    bool classicalSameOutput = PlayClassicalStrategy(aliceBit, bobBit);
                    bool quantumSameOutput = PlayQuantumStrategy.Run(sim, aliceBit, bobBit, aliceMeasuresFirst).Result;

                    if ((aliceBit && bobBit) == !classicalSameOutput)
                    {
                        classicalWinCount++;
                    }

                    if ((aliceBit && bobBit) == !quantumSameOutput)
                    {
                        quantumWinCount++;
                    }
                }

                Console.WriteLine("Classical success rate: " + classicalWinCount / (float)trialCount);
                Console.WriteLine("Quantum success rate: " + quantumWinCount / (float)trialCount);

                if (quantumWinCount > classicalWinCount)
                {
                    Console.WriteLine("SPOOKY");
                }
            }
        }

        private static bool GetRandomBit(Random generator)
        {
            int next = generator.Next();
            return (next & 1) == 1;
        }

        private static bool PlayClassicalStrategy(bool aliceBit, bool bobBit)
        {
            // Optimal classical strategy is to always both output 0
            bool aliceOutput = false;
            bool bobOutput = false;
            return aliceOutput == bobOutput;
        }
    }
}