using Microsoft.Quantum.Simulation.Common;

namespace SumOverPaths.Simulator
{
    /// 
    /// This is a trivial implementation of a Simulator. Only used for unittesting. 
    /// Not apt to simulate any circuits as it implements no Intrinsic Gates.
    /// 
    public class SumOverPathsSimulator : SimulatorBase
    {
        public SumOverPathsSimulator() : base(new QubitManager(32))
        {
        }

        public override string Name
        {
            get
            {
                return this.GetType().Name;
            }
        }
    }
}
