using System;

using Microsoft.Quantum.Simulation.Core;
using Microsoft.Quantum.Simulation.Simulators;
using Microsoft.Quantum.Simulation.Simulators.QCTraceSimulators;

namespace Quantum.QuantumAlgorithms
{
    class Driver
    {
        static void Main(string[] args)
        {
            try
            {
                using (var qsim = new QuantumSimulator())
                {
                    Result[] initials = new Result[] { Result.Zero, Result.One };
                    foreach (Result initial in initials)
                    {
                        var res = QuantumAlgorithmsTest.Run(qsim, 1000, initial).Result;
                        var (numZeros, numOnes, agree) = res;
                        System.Console.WriteLine(
                            $"Init:{initial,-4} 0s={numZeros,-4} 1s={numOnes,-4} agree={agree,-4}");
                    }
                }
                var estimator = new ResourcesEstimator();
                var traceSimCfg = new QCTraceSimulatorConfiguration();
                traceSimCfg.useDistinctInputsChecker = true; 
                QCTraceSimulator sim = new QCTraceSimulator(traceSimCfg);
                QuantumAlgorithmsTest.Run(estimator, 1000, Result.Zero).Wait();

                var data = estimator.Data;
                Console.WriteLine($"Estimate resources needed for entanglement");
                Console.WriteLine($"QubitCliffords: {data.Rows.Find("QubitClifford")["Sum"]}");
                Console.WriteLine($"Ts: {data.Rows.Find("T")["Sum"]}");
                Console.WriteLine($"CNOTs: {data.Rows.Find("CNOT")["Sum"]}");

                Console.WriteLine($"");
                Console.WriteLine($"Trace Simulator: Distinct Inputs Checker");
                var traceData = traceSimCfg.callStackDepthLimit;
                System.Console.WriteLine(traceData.ToString());
                System.Console.WriteLine(traceData.GetQubits());
                Console.WriteLine($"Full estimator details:");
                System.Console.WriteLine(estimator.ToTSV());

            }
            catch (AggregateException e)
            {
                foreach (Exception inner in e.InnerExceptions)
                {
                    if (inner is ExecutionFailException failureException)
                    {
                        Console.WriteLine($" {failureException.Message}");
                    }
                }
            }
        }
    }
}