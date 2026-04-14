# FSM

In this lab, you’ve learned about One Hot and Binary state machines and how to build them.

## Rubric

| Item | Description | Value |
| ---- | ----------- | ----- |
| Summary Answers | Your writings about what you learned in this lab. | 25% |
| Question 1 | Your answers to the question | 25% |
| Question 2 | Your answers to the question | 25% |
| Question 3 | Your answers to the question | 25% |

## Name
Oleg Strekachev, Travis Goodrich

## Summary
In this lab, we learned how to design state machines using both one-hot and binary encoding. We built the state machines from a state table and used combinational logic and flip-flops to create the next-state and output logic.

## Lab Questions

### Compare and contrast One Hot and Binary encodings

One-hot encoding uses one flip-flop for each state, and only one flip-flop is active at a time. This makes the logic easier to understand and implement. Binary encoding uses fewer flip-flops because each state is represented by a binary number, but it usually requires more complex logic.

### Which method did your team find easier, and why?

Our team found one-hot encoding easier because it was simpler to follow and less likely to cause mistakes during K-map simplification and implementation.

### In what conditions would you have to use one over the other? Think about resource utilization on the FPGA.
One-hot encoding is useful when there are enough flip-flops available and simplicity is more important. Binary encoding is better when resource usage matters more, because it uses fewer flip-flops and is more efficient for larger state machines.

