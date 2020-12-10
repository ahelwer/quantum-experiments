namespace SumOverPaths.Driver
{
    using System;
    using SumOverPaths.Simulator;
    using SumOverPaths.Payload;

    class Program
    {
        static void Main(string[] args)
        {
            var qsim = new SumOverPathsSimulator();
            HelloQ.Run(qsim).Wait();
            Console.WriteLine("Hello World!");
        }
    }
}
