# Sequential Circuits: Latches

In this lab, you learned about the basic building block of sequential circuits: the latch.

## Rubric

| Item | Description | Value |
| ---- | ----------- | ----- |
| Summary Answers | Your writings about what you learned in this lab. | 25% |
| Question 1 | Your answers to the question | 25% |
| Question 2 | Your answers to the question | 25% |
| Question 3 | Your answers to the question | 25% |

## Names
Oleg Strekachev
Travis Goodrich

## Summary

In this lab, we learned about latches as fundamental components of sequential circuits. A latch is capable of storing a value and updating it only when an enable signal is active, which distinguishes it from combinational logic where outputs change immediately in response to inputs. 

## Lab Questions

###  Why can we not just use structural Verilog to implement latches?

We actually can, but that would be inefficient. We would have to write gates and feedback loops manually which is a tedious way to do this task. Behavioral Verilog is much more suited for writing D-Latches.

### What is the meaning of always @(*) in a sensitivity block?

always @(*) tracks input signal changes inside of the code block.  The code block is triggered whenever any signal used within the block changes. The asterisk acts as a shorthand that automatically includes all relevant signals, eliminating the need to list them manually. 

### What importance is memory to digital circuits?

Memory allows to store state and retrieve it back when inputs are removed. Without memory it impossible to implement sequential behavior such as counting, state machines, or data storage.
