<h1 align="center">Quantum Algorithms</h1>
<h2 align="center"><sub>Quantum Algorithms demonstrated in Q#</sub></h2>

---
## About
* The quantum simulator supplied by Microsoft's Quantum Development Kit allows demonstrations of quantum algorithms. This project contains an exhibit of entanglement. During each run of this program it informs the user of the estimated resources needed to run it on a quantum computer. Concepts covered are: Pauli-Z Gate, and Bell States. 

<b>Example output in terminal:</b>
```   
Init:Zero 0s=497  1s=503  agree=1000
Init:One  0s=478  1s=522  agree=1000
Estimate resources needed for entanglement
QubitCliffords: 1000
Ts: 0
CNOTs: 1000

Trace Simulator: Distinct Inputs Checker
4294967295

Full estimator details:
Metric          Sum
CNOT            1000
QubitClifford   1000
R               0
Measure         4002
T               0
Depth           0
Width           2
BorrowedWidth   0
```

## Built with
* [Quantum Development Kit](https://www.microsoft.com/en-us/quantum/development-kit)

* [Visual Studio Code 2017 Community](https://code.visualstudio.com/)

## References

* [Microsoft Documentation](https://docs.microsoft.com/en-us/quantum/machines)

* [Quantum entanglement and quantum computational
algorithms](https://www.ias.ac.in/article/fulltext/pram/056/02-03/0357-0365)

* [An Introduction to Quantum Algorithms](https://www.ias.ac.in/article/fulltext/pram/056/02-03/0357-0365)


