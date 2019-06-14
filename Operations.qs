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
	// This is an example of entanglement using Bell States
	// Which is the concept that two qubits represent the simplest example of extanglement
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
	// Probablity of measurable outcomes
	// ancilla is known as auxiliary I.E. constant input
        using (ancilla = Qubit()) {

            H(ancilla);
            CNOT(ancilla, target);

            CNOT(source, ancilla);
            H(source);
			// Pauli-Z Gate, acts on a single qubit
            AssertProb([PauliZ], [source], Zero, 0.5, "Outcomes must be equally likely", 1e-5);
            AssertProb([PauliZ], [ancilla], Zero, 0.5, "Outcomes must be equally likely", 1e-5);

            if (M(source) == One)  { Z(target); X(source); }
            if (M(ancilla) == One) { X(target); X(ancilla); }
        }
    }
	}
	
