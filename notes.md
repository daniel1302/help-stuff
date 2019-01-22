# Below are my notes from videos

### [Doctrine best practices](https://www.youtube.com/watch?v=WW2qPKukoZY)

```
  Entities should work w/o ORM,
  Entities are not typed arrays,
  Entities should do some stuff,
  Law of Demether,
  Entities should be always valid - if data is not valid you cannot create entity,
  Named constructors are OK,
  Use DTO to get data from forms,
  Avoid lifecycle callbacks,
  Avoid auto-generated identifiers - Use UUID instead,
  Use AutoIncrement for sorting,
  Avoid composite primary keys, 
  Favor immutable data (simple, cacheable, predictable, analysable),
  Avoid soft-delete,
  Mapping driver: annotations in private packages, xml for public packages,
  Eager Loading is useless,
  Extra Lazy indicvates high risk areas,
  Avoid bi-directional associations - it is overhead,
  Prefer functional class over big repositories class,
  Avoid ObjectManager::getRepository(),
  MyRepository::find() can return null, ::get() cannot ::get() method should throw an exception,
  Keep transactions unrelated,
  Comunicate betwen boundaries betwen IDs, not object references.
```



### [C++ Casting](http://www.cplusplus.com/doc/tutorial/typecasting/)

```
Types:
1) Functional casting: b = int (a);
2) C-like casting
3) dynamic_cast
    - Only with pointers and references to classes
    - Casting to complete valid objects only
    - Naturally used to upcast, but can be used to downcast
    - Polymorphic types can be casted to void*
4) static_cast:
    - Used both for downcast and upcast
    - Does not perform full-type complete check in runtime
    - If casted type from void* is the same as casted to void* that value pointer is the same
    - Convert integers/floats/enums to enums
    - Can explicit call single argument cts or conversion op
    - Convert to rvalue reference
    - Convert enum into integer/float
    - Convert anytype to void
4) reinterpret_cast:
    - convert pointer type to any different pointer type
    - convert between integer pointers depends on platform
```

### [Compilation steps by Gynvael](https://www.youtube.com/watch?v=wDKeJ79TBsg)

GCC is not compiler is compilation tool set and compilation driver.
Compilation steps:
1) Preprocessing(cpp) - `gcc -e`
2) Compilation to the assembler - `gcc -S -masm=intel`
3) Compilation to the objects - `gcc -c`
4.1) Link to executeable - `ld`
4.2) Create shared lib(.ddl, .so)
4.3) Create static lib(.a)

You can dump all steps of compilation into files by add `-f dump-tree-all` flag
You can read objects files with
    - `objdump -d FILENAME` - disassembly
    - `objdump -x FILENAME` - attach all headers


