Day 9
Typed Error Handling &
Custom Exceptions:
Preventing unhandled
runtime crashes.
Exception Mapping Skill: Author a
compact skill that directs repository
methods to map low-level failures
into sealed AppException or
Result<T> types without boilerplate
prompts.
dart-error-handling skill +
resilient data parsing layer with
comprehensive typed exception
coverage.

- understanding type error handling - the goal is understanding why ordinary error handling is insufficient for production app.
  todays goal is to build An AI agent skill that automatically follows daymarks error handling architecture without needing you to explicitly mentioned in prompt.

  Exception vs error vs failure -

1.  Exception - Exception is an issue occuars during program excution and may be recoverable.
    final age = int.parse('abc');
    This throws:
    FormatException

2.  error - an error generally repesents a serious programing mistake or an unexpected condtion

3.  Failure - A Failure represents an application-level problem that your architecture understands.

try, catch , finally , throw , on , rethrow

try - contains code that might fails.
catch - it catches the specific type.
on - catch a specific exception.
finally - it eacuates eacuats whether the try block succeeds or fails.
throw - You can create an exception when a condition is invalid.
rethrow - throw the same exaception again.

custom exception - instead generic exception we are creating our own custom exception.

using the custom exception The program can react differently depending on the exception type.

why this is usefull for Ai agent.
without skill you might repeatedly prompt.
Create a custom exception for network errors. Make sure it has a message. Catch it in the repository and map it properly.

With a dart-error-handling skill, your agent already knows:
