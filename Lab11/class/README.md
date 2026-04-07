# Lab 11 - Counters and Dividers

In this lab, we learned how to make clock dividers from two types of counters.

## Rubric

| Item | Description | Value |
| ---- | ----------- | ----- |
| Summary Answers | Your writings about what you learned in this lab. | 25% |
| Question 1 | Your answers to the question | 25% |
| Question 2 | Your answers to the question | 25% |
| Question 3 | Your answers to the question | 25% |

## Names
Oleg Strekachev, Travis Goodrich

## Summary
In this lab, we learned that counters can be used as clock dividers. A ripple counter is simple and divides by powers of 2, while a modulo counter is more flexible because it can divide by arbitrary values, but it needs more logic such as adders, flip-flops, and comparison/reset logic. The lab also showed why the modulo output toggles separately from the count state.

## Lab Questions

### 1 - Why does the Modulo Counter actually divide clocks by 2 * Count?
Because the output toggles each time the terminal count is reached. One full cycle needs two toggles, from low to high and then high to low, so the full period takes two complete counts. That is why a count of 6 gives a / 12 output.

### 2 - Why does the ring counter's output go to all 1s on the first clock cycle?

Because all three T flip-flops start at 0, and the first clock edge causes the first stage to toggle to 1. That change ripples into the next stage, and then into the third stage, so after the ripple settles the three stage outputs become 111. This happens sequentially, not simultaneously, because the ripple counter is asynchronous.

### 3 - What width of ring counter would you use to get to an output of ~1KHz?

100 MHz / 2^n = 1kHz... N approx 16.6 so 17 stages.

