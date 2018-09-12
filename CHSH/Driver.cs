namespace CHSH
{
    using System;
    using Microsoft.Quantum.Simulation.Core;
    using Microsoft.Quantum.Simulation.Simulators;

    class Driver
    {
        static void Main(string[] args)
        {
            const int trials = 10000;
            Random generator = new Random();
            using (var sim = new QuantumSimulator())
            {
                int win = 0;
                int sameInput = 0;
                int sameResult = 0;
                for (int i = 0; i < trials; i++)
                {
                    bool aliceBit = GetRandomBit(generator);
                    bool bobBit = GetRandomBit(generator);
                    bool sameOutput = PlayGame.Run(sim, aliceBit, bobBit).Result;
                    if (aliceBit && bobBit)
                    {
                        sameInput++;
                    }

                    if (sameOutput)
                    {
                        sameResult++;
                    }

                    if ((aliceBit && bobBit) == !sameOutput)
                    {
                        win++;
                    }
                }

                Console.WriteLine((float)sameInput / (float)trials);
                Console.WriteLine((float)sameResult / (float)trials);
                Console.WriteLine((float)win / (float)trials);
            }
        }

        private static bool GetRandomBit(Random generator)
        {
            int next = generator.Next();
            return (next & 1) == 1;
        }
    }
}