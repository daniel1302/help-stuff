# Below are my notes from videos

### [Doctrine best practices](https://www.youtube.com/watch?v=WW2qPKukoZY)

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
