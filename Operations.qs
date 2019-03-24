namespace Quantum.QuantumAlgorithms
{
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;
    
    operation Set (desired: Result, q1: Qubit) : Unit 
	{
		let current = M(q1);
		if (desired != current)
			{
				X(q1);
			}
    }

	 operation QuantumAlgorithmsTest (count : Int, initial: Result) : (Int, Int, Int)
    {
		mutable numOnes = 0;
        mutable agree = 0;
        using (qubits = Qubit[2])
        {
            for (test in 1..count)
            {
                Set (initial, qubits[0]);
                Set (Zero, qubits[1]);

                H(qubits[0]);
                CNOT(qubits[0], qubits[1]);
                let res = M (qubits[0]);

                if (M (qubits[1]) == res) 
                {
                    set agree = agree + 1;
                }
                if (res == One)
                {
                    set numOnes = numOnes + 1;
                }
            }
            
            Set(Zero, qubits[0]);
            Set(Zero, qubits[1]);
        }
        return (count-numOnes, numOnes, agree);
    }

	operation Teleportation (source : Qubit, target : Qubit) : Unit {
    body (...) {
        using (ancillaRegister = Qubit[1]) {
            let ancilla = ancillaRegister[0];

            H(ancilla);
            CNOT(ancilla, target);

            CNOT(source, ancilla);
            H(source);

            AssertProb([PauliZ], [source], Zero, 0.5, "Outcomes must be equally likely", 1e-5);
            AssertProb([PauliZ], [ancilla], Zero, 0.5, "Outcomes must be equally likely", 1e-5);

            if (M(source) == One)  { Z(target); X(source); }
            if (M(ancilla) == One) { X(target); X(ancilla); }
        }
    }
	}
	
}
