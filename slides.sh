# vim: set ft=markdown:

cat > one.md << 'EOF'
### Type qualification

Java 8 (JSR 308) introduces type annotations, which can qualify any type.

E.g.,

```java
@NonBlank String name = null;

String marshal(@ReadOnly user) {
    ...
}

(@Encrypted String) "foo"

class Folder<F extends @Existing File> {
    ...
}
```

Type annotations were added to Java to enable development of pluggable type systems
that can be used in conjuction with the standard `javac` compiler.
EOF

cat > two.md << 'EOF'
### Java Checker Framework 

```java
org.checkerframework.checker.nullness.qual.NonNull
```

Type qualifier `NonNull` removes the null value from the domain of any java reference type.

```
@NonNull Integer n = null; // compile error (or warning, you choose)
```

*Why shoud the typeless null value inhabit every reference type?*

```
@Nullable Integer m = null; // OK
```

### Flow-sensitive type refinement

The type checker analyses your code at compile time to remove the possibility
of null dereference at runtime. Successful compilation **proves** the absense of runtime
null pointer exceptions.

E.g.,

*Why check for null?*

```
Integer bump(Integer n) {
    if (n != null) {
        return n + 1;
    } else {
        return null;
    }
}
```

*Why not demand a non-null value?*

```
Integer bump(@NonNull Integer n) {
    return n + 1;
}

Integer n = compute(); 
bump(n); // type error, n could be null

if (n != null) {
    bump(n); // OK, n is not null
}
```

Inside the if-statement, the type checker has refined the type of `n`
from `Integer` to `@NonNull Integer`.
EOF

cat > test.md << 'EOF'
[google](http://www.google.com "go")
EOF

cat > three.md << 'EOF'
### Another example

Define your own type qualifier.

```java
@SubtypeOf(Unqualified.class)
@Target({ElementType.TYPE_USE, ElementType.TYPE_PARAMETER})
public @interface Encrypted {}
```

Processing the `@Encrypted` type annotation with the subtyping plugin 
(`prg.checkerframework.common.subtyping.SubtypingChecker`) puts the base type `T`
and the annotated type in subtyping relation `@Encrypted T <: T`.

E.g.,

```java
String promptForPassword() {
    ...
}

@SuppressWarnings("cast.unsafe")
@Encrypted String encrypt(String str) {
  return (@Encrypted String) des(str);
}

void persistPassword(@Encrypted String) {
    ...
}

persistPassword(promptForPassword()) // type error

persistPassword(encrypt(promptForPassword()) // OK
```
EOF



