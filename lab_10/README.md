# Sequential Circuits: Latches

In this lab, we learned about edge-sensitive circuits and explored some of the uses of them.

## Rubric

| Item | Description | Value |
| - | - | - |
| Summary Answers | Your writings about what you learned in this lab. | 25% |
| Question 1 | Your answers to the question | 25% |
| Question 2 | Your answers to the question | 25% |
| Question 3 | Your answers to the question | 25% |

## Names
Oleg Strekachev, Travis Goodrich

## Summary

In this lab we explored how to move from combinational, level-sensitive latches to edge-sensitive sequential flip-flops.

We explored how to make Vivado generate flip-flops instead of latches, and how to build D, JK, and T flip-flops. Then we wired them to the Basys board to demonstrate their behavior.

## Lab Questions

### What is difference between edge and level sensitive circuits?

Level-sensitive circuits respond during the whole time the enable or clock level is active. Edge-sensitive circuits respond only at the transition of the clock, such as the rising edge or falling edge.

### Why is it important to declare initial state?

Because if the initial state is not declared, it is undefined, and we cannot reliably perform logic operations with undefined values.

### What do edge sensitive circuits let us build?

Edge-sensitive circuits let us build modern digital systems such as microprocessors, memory systems, and data transfer hardware and protocols.
