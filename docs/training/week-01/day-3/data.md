Context Slicing on OOP
Hierarchies: Building
classes, constructors, and
mixins with minimal context

two techniques for inspect and understand file independently

symbol scoping and line-range scoping.

Complete OOP domain module
generated in single-shot. - Task Module

# Authentication Specification

## Registration Requirements

1. User must register using email and password.
2. Email must be valid.
3. Password must contain at least 8 characters.
4. Registration must communicate through AuthRepository.
5. Use cases must not directly access Supabase.
6. Return an appropriate success or failure result.
7. Never expose or log passwords.
